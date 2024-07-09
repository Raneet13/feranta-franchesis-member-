import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:feranta_franchise/model/login/chechin_out_history_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/login/loginmodel.dart';
import '../../repository/login_repository/login_otp_send_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class LoginViewmodel extends ChangeNotifier {
  TextEditingController mobNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otpController = TextEditingController();
  LoginModel? loginModel;
  String sendOtp = '';
  String otppin = "";
  bool showResend = false;
  late Timer timer;
  int start = 30;
  // verifyotpHomemodel? verifyotpGohome;
  bool isLoading = false;
  String deviceTokenToSendPushNotification = "";
  bool passwordVisible = false;
  File? _imageCheckInout;
  final ImagePicker _picker = ImagePicker();
  late bool isCheckIn;
  CheckInoutHistoryModel? checkInoutHistoryModel;

  passwordVisibleupdate() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  isloadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  isloadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // Future<void> getDeviceTokenToSendNotification() async {
  //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  //   final token = await _fcm.getToken();
  //   deviceTokenToSendPushNotification = token.toString();
  // }

  Future submitLogin(BuildContext context) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ShowToast(msg: "${password.text != "" ? "no" : "yes"}");
    if (mobNumber.text.length != 10) {
      ShowToast(msg: "Enter your 10 digit Mobile Number First");
    } else if (password.text == "") {
      ShowToast(msg: "Enter Password");
    } else {
      var data = await AuthApiRepository()
          .loginRepo(phone: mobNumber.text, password: password.text);
      if (data["error"] == null) {
        loginModel = LoginModel.fromJson(data);
        await prefs.setString(
            "userId", loginModel!.response!.profileDetails!.id.toString());
        context.pushReplacement('/home', extra: {'id': '0'});
      } else {
        ShowToast(msg: data["response"]!["message"].toString());
        // ShowToast(msg: "error");
      }
    }
    isloadingFalse();
    notifyListeners();
  }

  Future Logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");

    context.go('/login');
    notifyListeners();
  }

  Future<bool?> checkCheckinOutTrue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var che = await prefs.getBool("check_in");
    // ShowToast(msg: checkInnOut.toString());
    isCheckIn = che ?? false;
    notifyListeners();
    // print(checkInnOut);
    // return checkInnOut;
  }

  Future<void> showPickerDialog({required lat, required lng}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      var compressImage = await compressFile(File(pickedFile.path));
      _imageCheckInout = File(compressImage!.path);
      //File(pickedFile.path);
      await checkInOut(lat: lat.toString(), lng: lng.toString());
      // var fileNew = await compressFile(_imageCheckInout!);
      // var fileSize =
      //     await getFileSizeString(bytes: File(fileNew!.path).lengthSync());
      // print(fileSize);
      notifyListeners();
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }

  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.png|.jpeg|.jpg'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    print("OUTPATH :  ${outPath}");
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath, //file.path
      minWidth: 300,
      minHeight: 300,
      format: CompressFormat.jpeg,
      quality: 25,
    );

    // print(file.lengthSync());
    // print(File(result!.path).lengthSync());

    return result;
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  // showPickerDialog(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Photo Library'),
  //               onTap: () {
  //                 _pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.photo_camera),
  //               title: Text('Camera'),
  //               onTap: () {
  //                 _pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future checkInOut({required lat, required lng}) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    bool? check = await prefs.getBool('check_in');
    var allData = await AuthApiRepository().checkInOut(
        member_id: userId,
        image: _imageCheckInout != null
            ? await MultipartFile.fromFile(_imageCheckInout!.path,
                filename: _imageCheckInout!.path.split('/').last)
            : "",
        type: !isCheckIn ? 'check_in' : 'check_out',
        lat: lat.toString(),
        lng: lng.toString());
    if (allData["error"] == null) {
      ShowToast(msg: allData["response"]["success"].toString());
      check != null
          ? prefs.remove('check_in')
          : prefs.setBool('check_in', true);
      await checkCheckinOutTrue();
      // checkTrue != null
      //     ? prefs.remove('check_in')
      //     : prefs.setBool('check_in', true);
      // isCheckIn = !isCheckIn;
    } else {
      ShowToast(msg: "Wrong to Load Location");
    }
    isloadingFalse();
    notifyListeners();
  }

  Future checkInOutHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData =
        await AuthApiRepository().allcheckInOutHistory(member_id: userId);
    checkInoutHistoryModel = CheckInoutHistoryModel.fromJson(allData);
    // print(allData);
    notifyListeners();
  }
}

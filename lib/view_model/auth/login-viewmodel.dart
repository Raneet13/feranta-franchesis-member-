import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    if (mobNumber.text.length != 10 && password.text != null) {
      ShowToast(msg: "Enter your 10 digit Mobile number and password");
    } else {
      var data = await AuthApiRepository()
          .loginRepo(phone: mobNumber.text, password: password.text);
      if (data["error"] == null) {
        loginModel = LoginModel.fromJson(data);
        await prefs.setString(
            "userId", loginModel!.response!.profileDetails!.id.toString());
        context.pushReplacement('/home', extra: {'id': '0'});
      } else {
        ShowToast(msg: data["response"]["message"]);
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
}

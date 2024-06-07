import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:feranta_franchise/repository/resister/resister_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/login/loginmodel.dart';
import '../../model/resister/master_model.dart';
import '../../repository/login_repository/login_otp_send_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class ResisterViewmodel extends ChangeNotifier {
  bool isLoading = false;
  MasterModel? masterModel;
  //resistration
// name,,,,state,city,pincode,,,,,,,,,,,,
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController altcontact = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController license_no = TextEditingController();
  TextEditingController resister_password = TextEditingController();
  TextEditingController ac_name = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  TextEditingController acc_no = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController exp_year = TextEditingController();
  TextEditingController ahdarno = TextEditingController(); //ahdarno
  List<String> choosestate = ["odisha", "andhrapradesh"];
  String state = "";
  String city = "";
  String pinCode = "";
  File? img;
  File? frontimg;
  File? backimg;
  File? license_img;
  File? seeDemo;
  //resistation complete
  //customer
  File? customerImage;
  TextEditingController cname = TextEditingController();
  TextEditingController cemail = TextEditingController();
  TextEditingController ccontact = TextEditingController();
  TextEditingController caltcontact = TextEditingController();
  //customer rfield

  //owner
  bool isCheck = false;
  //owner

  //resister fuction
  Future insertLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      img = file;
    } else {
      // print(result);
      // User canceled the picker
    }
    notifyListeners();
  }

  Future insertDemoImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      seeDemo = file;
    } else {
      // print(result);
      // User canceled the picker
    }
    notifyListeners();
  }

  Future submitImage({required String filename}) async {
    if (filename == "Aadhar Card Font") {
      frontimg = seeDemo;
      notifyListeners();
    } else if (filename == "Aadhar Card Back") {
      backimg = seeDemo;
      notifyListeners();
    } else if (filename == "Licence") {
      license_img = seeDemo;
      notifyListeners();
    }
    seeDemo = null;
    notifyListeners();
  }

  userRegister(BuildContext context) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().resisterDriver(
        name: name.text.toString(),
        email: email.text.toString(),
        contact: contact.text.toString(),
        altcontact: altcontact.text.toString(),
        state: state,
        city: city,
        pincode: pinCode,
        address1: address1.text.toString(),
        license_no: license_no.text.toString(),
        password: resister_password.text.toString(),
        ac_name: ac_name.text.toString(),
        bank_name: bank_name.text.toString(),
        acc_no: acc_no.text.toString(),
        ifsc: ifsc.text.toString(),
        exp_year: exp_year.text.toString(),
        img: img != null
            ? await MultipartFile.fromFile(img!.path,
                filename: img!.path.split('/').last)
            : "",
        frontimg: frontimg != null
            ? await MultipartFile.fromFile(frontimg!.path,
                filename: frontimg!.path.split('/').last)
            : "",
        backimg: backimg != null
            ? await MultipartFile.fromFile(backimg!.path,
                filename: backimg!.path.split('/').last)
            : "",
        license_img: license_img != null
            ? await MultipartFile.fromFile(license_img!.path,
                filename: license_img!.path.split('/').last)
            : "",
        adharno: ahdarno.text.toString(),
        member_id: userId!);
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      Navigator.pop(context);
      clearResistationForm();
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
    }
    isloadingFalse();
    clearResistationForm();
    // isLoadingupdateFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img

  clearResistationForm() {
    name.text = "";
    email.text = "";
    contact.text = "";
    altcontact.text = "";
    ahdarno.text = "";
    address1.text = "";
    license_no.text = "";
    resister_password.text = "";
    ac_name.text = "";
    bank_name.text = "";
    acc_no.text = "";
    ifsc.text = "";
    exp_year.text = "";
    img = null;
    frontimg = null;
    backimg = null;
    license_img = null;
    state = "";
    city = "";
    pinCode = "";
    isCheck = false;
    notifyListeners();
  }

  updateSttate(String newstate) {
    state = newstate;
    notifyListeners();
  }

  updateCity(String newstate) {
    city = newstate;
    notifyListeners();
  }

  updatePin(String newstate) {
    pinCode = newstate;
    notifyListeners();
  }

  //resister function complete

  //custtomer resistation function
  Future customererLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      customerImage = file;
    } else {
      // print(result);
      // User canceled the picker
    }
    notifyListeners();
  }

  customerRegister(BuildContext context) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().customerRegiRepo(
        member_id: userId,
        name: cname.text.toString(),
        phone: ccontact.text.toString(),
        email: cemail.text.toString(),
        profile_image: customerImage != null
            ? await MultipartFile.fromFile(customerImage!.path,
                filename: customerImage!.path.split('/').last)
            : "",
        wp_contact: caltcontact.text.toString());
    if (allData["error"] == null) {
      Navigator.pop(context);
      clearCustomerResistationForm();
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      // print(allData);
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
    }
    isloadingFalse();
    clearCustomerResistationForm();
    // isLoadingupdateFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img

  clearCustomerResistationForm() {
    cname.text = "";
    cemail.text = "";
    ccontact.text = "";
    caltcontact.text = "";
    customerImage = null;

    notifyListeners();
  }
//customer function close

//owner resistation function
  ischeckUpdate(bool check) {
    isCheck = check;
    notifyListeners();
  }

  ownerRegister(BuildContext context) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().resisterOwner(
        full_name: name.text.toString(),
        email: email.text.toString(),
        contact_no: contact.text.toString(),
        altcontact: altcontact.text.toString(),
        state: state,
        city: city,
        pincode: pinCode,
        address1: address1.text.toString(),
        license_no: license_no.text.toString(),
        password: resister_password.text.toString(),
        ac_name: ac_name.text.toString(),
        bank_name: bank_name.text.toString(),
        acc_no: acc_no.text.toString(),
        ifsc: ifsc.text.toString(),
        img: img != null
            ? await MultipartFile.fromFile(img!.path,
                filename: img!.path.split('/').last)
            : "",
        frontimg: frontimg != null
            ? await MultipartFile.fromFile(frontimg!.path,
                filename: frontimg!.path.split('/').last)
            : "",
        backimg: backimg != null
            ? await MultipartFile.fromFile(backimg!.path,
                filename: backimg!.path.split('/').last)
            : "",
        license_img: license_img != null
            ? await MultipartFile.fromFile(license_img!.path,
                filename: license_img!.path.split('/').last)
            : "",
        adharno: ahdarno.text.toString(),
        is_driver: isCheck ? "1" : "0",
        member_id: userId,
        address2: address2.text.toString());
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      // ShowToast(msg: "You Resister Sucessfully");
      Navigator.pop(context);
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
      // print(allData);
    }

    clearownerResistationForm();
    isloadingFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img

  clearownerResistationForm() {
    name.text = "";
    email.text = "";
    contact.text = "";
    altcontact.text = "";
    ahdarno.text = "";
    address1.text = "";
    license_no.text = "";
    resister_password.text = "";
    ac_name.text = "";
    bank_name.text = "";
    acc_no.text = "";
    ifsc.text = "";
    exp_year.text = "";
    img = null;
    frontimg = null;
    backimg = null;
    license_img = null;
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

  Future getAllMaster() async {
    var allData = await ResisterRepository().getMasterrepo();
    if (allData["error"] == null) {
      masterModel = MasterModel.fromJson(allData);
    } else {
      ShowToast(msg: "Wrong to Load Location");
    }
    notifyListeners();
  }
}

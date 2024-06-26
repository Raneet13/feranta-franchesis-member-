import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:feranta_franchise/model/profile/view_profileDetails.dart';
import 'package:feranta_franchise/repository/resister/resister_repository.dart';
import 'package:feranta_franchise/static/color.dart';
import 'package:feranta_franchise/view_model/allRecordViewmodel/all-record_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/imageCompress_function.dart';
import '../../model/login/loginmodel.dart';
import '../../model/past_record/all_record_model.dart';
import '../../model/resister/master_model.dart' as master;
import '../../repository/login_repository/login_otp_send_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class ResisterViewmodel extends ChangeNotifier {
  bool isLoading = false;
  master.MasterModel? masterModel;
  final ImagePicker _picker = ImagePicker();
  //resistration
// ,block,ditrict,,blood_group,cheque) (spouse_name,pin
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController altcontact = TextEditingController();
  TextEditingController mother_name = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController license_no = TextEditingController();
  TextEditingController father_name = TextEditingController();
  TextEditingController wife_name = TextEditingController(); //spouse_name
  TextEditingController spouse_name = TextEditingController(); //
  TextEditingController resister_password = TextEditingController();
  TextEditingController ac_name = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  TextEditingController acc_no = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController branch_name = TextEditingController();
  TextEditingController exp_year = TextEditingController();
  TextEditingController ahdarno = TextEditingController();
  TextEditingController pincode = TextEditingController();
  //TextEditingController addressPin = TextEditingController();
  TextEditingController villageName = TextEditingController(); //ahdarno
  final TextEditingController dobController = TextEditingController();
  List<String> licenseTyppe = [
    "MCWG", //Motorcycles with and without gear(
    "LMV-NT" //Light Motor Vehicle—Non Transport(
  ];
  String licenseTpeSelect = "";

  DateTime? selectedDate;
  final TextEditingController drivingExpiryController = TextEditingController();
  int married_type = 1;
  DateTime? selecteddrivingExpiryDate;
  bool termsCheck = false;
  bool criminalCheck = false;
  String state = "";
  String city = "";
  // pinCode.text = "";
  String block = "";
  String ditrict = "";
  String blood_group = "";
  String stateID = "";
  String cityID = "";
  String pinCodeID = "";
  String blockID = "";
  String ditrictID = "";
  String blood_groupID = "";
  File? img;
  File? frontimg;
  File? backimg;
  File? license_img;
  File? seeDemo;
  File? cheque;
  File? vechicleRc;
  File? vechicleInsurancef;
  File? vechicleInsurancet;
  File? fitnessCertificate;
  File? polutionCertificate;
  //already update data
  String? img_update;
  String? frontimg_update;
  String? backimg_update;
  String? license_img_update;
  String? cheque_update;
  String? vechicleRc_update;
  String? vechicleInsurancef_update;
  String? vechicleInsurancet_update;
  String? fitnessCertificate_update;
  String? polutionCertificate_update;
  //nominee
  TextEditingController nomineeName = TextEditingController();
  TextEditingController nomineeRelationship = TextEditingController();
  TextEditingController nomineeAddress = TextEditingController();
  final TextEditingController dobNomineeController = TextEditingController();
  DateTime? selectedNomineeDate;
  //vechicle
  TextEditingController engineNumberField = TextEditingController();
  TextEditingController rcNumberField = TextEditingController();
  TextEditingController insuranccefield = TextEditingController();
  TextEditingController polutionField = TextEditingController();
  TextEditingController ftnessField = TextEditingController();
  //resistation complete
  //customer
  File? customerImage;
  String? customerImage_update;
  TextEditingController cname = TextEditingController();
  TextEditingController cemail = TextEditingController();
  TextEditingController ccontact = TextEditingController();
  TextEditingController caltcontact = TextEditingController();
  //customer rfield

  //owner
  bool isCheck = false;
  //owner

  //resister fuction
  // Future insertLogo() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     img = file;
  //   } else {
  //     // print(result);
  //     // User canceled the picker
  //   }
  //   notifyListeners();
  // }
  insertLogo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Choose the medium of your Image"),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImagelogo(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImagelogo(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _pickImagelogo(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      var compressImage = await compressFile(file: File(pickedFile.path));
      img = File(compressImage!.path);

      notifyListeners();
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      seeDemo = File(pickedFile.path);

      notifyListeners();
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }

  insertDemoImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Choose the medium of your Image"),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return SafeArea(
    //       child: Center(
    //         child: Wrap(
    //           children: ),
    //       ),
    //     );
    //   },
    // );
  }

  // Future insertDemoImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     seeDemo = file;
  //   } else {
  //     // print(result);
  //     // User canceled the picker
  //   }
  //   notifyListeners();
  // }

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
    } else if (filename == "cheque") {
      cheque = seeDemo;
      notifyListeners();
    } else if (filename == "rc") {
      vechicleRc = seeDemo;
      notifyListeners();
    } else if (filename == "insurance first party") {
      vechicleInsurancef = seeDemo;
      notifyListeners();
    } else if (filename == "insurance third party") {
      vechicleInsurancet = seeDemo;
      notifyListeners();
    } else if (filename == "fitness") {
      fitnessCertificate = seeDemo;
      notifyListeners();
    } else if (filename == "Pollution") {
      polutionCertificate = seeDemo;
      notifyListeners();
    }
    seeDemo = null;
    notifyListeners();
  } //rc //insurance first party  //insurance third party  //fitness //Pollution

  userRegister(BuildContext context) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");

    var allData = await ResisterRepository().resisterDriver(
      name: name.text.toString(),
      email: email.text.toString(),
      contact: contact.text.toString(),
      altcontact: altcontact.text.toString(),
      state: stateID,
      city: cityID,
      pincode: pincode.text,
      address1: address1.text.toString(),
      address2: villageName.text,
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
      member_id: userId!,
      branch_name: branch_name.text.toString(),
      block: blockID,
      ditrict: ditrictID,
      father_name: father_name.text.toString(),
      blood_group: blood_groupID,
      cheque: cheque != null
          ? await MultipartFile.fromFile(cheque!.path,
              filename: cheque!.path.split('/').last)
          : "",
      spouse_name: wife_name.text.toString(),
      license_expire_date: drivingExpiryController.text.toString(),
      dob: dobController.text.toString(),
      mother_name: mother_name.text.toString(),
      nominee_name: nomineeName.text.toString(),
      nominee_rltn: nomineeRelationship.text.toString(),
      nominee_add: nomineeAddress.text.toString(),
      nominee_dob: dobNomineeController.text.toString(),
      license_type: licenseTpeSelect == "MCWG" ? "1" : "2",
    );
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      clearResistationForm();
      Navigator.pop(context);
    } else {
      ShowToast(
          msg: "${allData["response"]['message'].keys.toString()} is required");
      // ShowToast(
      //     msg: "${allData["response"]['message'].toString()} must be unique");
      //print(allData);
    }
    isloadingFalse();
    // clearResistationForm();
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
    licenseTpeSelect = "";
    isCheck = false;
    dobController.text = "";
    father_name.text = "";
    mother_name.text = "";
    ditrict = "";
    block = "";
    villageName.text = "";
    pincode.text = "";
    blood_group = "";
    cheque = null;
    exp_year.text = "";
    drivingExpiryController.text = "";
    engineNumberField.text = "";
    vechicleRc = null;
    vechicleInsurancef = null;
    vechicleInsurancet = null;
    fitnessCertificate = null;
    polutionCertificate = null;
    branch_name.text = "";
    nomineeName.text = '';
    nomineeAddress.text = "";
    nomineeRelationship.text = "";
    dobNomineeController.text = "";
    wife_name.text = "";
    stateID = "";
    cityID = "";
    ditrictID = "";
    blockID = "";
    blood_groupID = "";
    termsCheck = false;
    criminalCheck = false;
    frontimg_update = "";
    img_update = "";
    frontimg_update = "";
    backimg_update = "";
    license_img_update = "";
    cheque_update = "";
    vechicleRc_update = "";
    vechicleInsurancef_update = "";
    vechicleInsurancet_update = "";
    fitnessCertificate_update = "";
    polutionCertificate_update = "";
    notifyListeners();
  }

  updateSttate(master.State newstate) {
    state = newstate.stateName!;
    stateID = newstate.stateId!;
    notifyListeners();
  }

  updateCity(master.City newstate) {
    city = newstate.cityName!;
    cityID = newstate.cityId!;
    notifyListeners();
  }

  updateBloodGrup(master.BloodGroup grup) {
    blood_group = grup.bloodGroup!;
    blood_groupID = grup.id!;
    notifyListeners();
  }

  // updatePin(String newpin) {
  //   pinCode = newpin;
  //   notifyListeners();
  // }

  updateDistrict(master.Districts newdistrict) {
    ditrict = newdistrict.districtName!;
    ditrictID = newdistrict.id!;
    notifyListeners();
  }

  updateBlock(master.Blocks newblock) {
    block = newblock.blockName!;
    blockID = newblock.id!;
    notifyListeners();
  }

  //resister function complete
  updateMariedType(int newstate) {
    married_type = newstate;
    notifyListeners();
  }

  updateTerms(bool newstate) {
    termsCheck = newstate;
    notifyListeners();
  }

  updateCriminal(bool newstate) {
    criminalCheck = newstate;
    notifyListeners();
  }

  updateLicenseType(String newstate) {
    licenseTpeSelect = newstate;
    notifyListeners();
  }

  //custtomer resistation function
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate!);
    } else {
      ShowToast(msg: "You have not select any date");
    }
    notifyListeners();
  }

  Future<void> selectNomineeBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedNomineeDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedNomineeDate) {
      selectedNomineeDate = picked;
      dobNomineeController.text =
          DateFormat('dd-MM-yyyy').format(selectedNomineeDate!);
    } else {
      ShowToast(msg: "You have not select any date");
    }
    notifyListeners();
  }

  Future<void> driverLicenseExpiry(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddrivingExpiryDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selecteddrivingExpiryDate) {
      selecteddrivingExpiryDate = picked;
      drivingExpiryController.text =
          DateFormat('dd-MM-yyyy').format(selecteddrivingExpiryDate!);
    } else {
      ShowToast(msg: "You have not select any date");
    }
    notifyListeners();
  }

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
      clearCustomerResistationForm();
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      Navigator.pop(context);

      // print(allData);
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
    }
    isloadingFalse();
    clearCustomerResistationForm();
    // isLoadingupdateFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img

  updatecustomerRegisterView(BuildContext context, custId) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().updatecustomerRegiRepo(
        user_id: custId,
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
      clearCustomerResistationForm();
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      Navigator.pop(context);

      // print(allData);
    } else {
      ShowToast(
          msg:
              "${allData["response"]["message"].keys.toString()} must be unique");
    }
    isloadingFalse();

    // isLoadingupdateFalse();
    notifyListeners();
  }

  initCustomerDet(UserList user) {
    cname.text = user.fullName ?? "";
    ccontact.text = user.contactNo ?? "";
    cemail.text = user.email ?? "";
    customerImage_update = user.profileImage ?? "";
    caltcontact.text = user.alterCnum ?? "";
    notifyListeners();
  }

  clearCustomerResistationForm() {
    cname.text = "";
    cemail.text = "";
    ccontact.text = "";
    caltcontact.text = "";
    customerImage = null;
    customerImage_update = null;

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
      state: stateID,
      city: cityID,
      pincode: pincode.text,
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
      address2: villageName.text.toString(), //uppdate
      branch_name: branch_name.text.toString(),
      block: blockID,
      ditrict: ditrictID,
      father_name: father_name.text.toString(),
      blood_group: blood_groupID,
      cheque: cheque != null
          ? await MultipartFile.fromFile(cheque!.path,
              filename: cheque!.path.split('/').last)
          : "",
      spouse_name: wife_name.text.toString(),
      license_expire_date: drivingExpiryController.text.toString(),
      dob: dobController.text.toString(),
      mother_name: mother_name.text.toString(),
      nominee_name: nomineeName.text.toString(),
      nominee_rltn: nomineeRelationship.text.toString(),
      nominee_add: nomineeAddress.text.toString(),
      nominee_dob: dobNomineeController.text.toString(),
    );
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      // ShowToast(msg: "You Resister Sucessfully");
      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      clearownerResistationForm();
      Navigator.pop(context);
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
      // print(allData);
    }

    isloadingFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img

  updateownerRegisterViewmodel(
      BuildContext context, userid, bool ownertr) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().updateResisterOwner(
      ownerty: ownertr,
      user_id: userid.toString(),
      full_name: name.text.toString(),
      email: email.text.toString(),
      contact_no: contact.text.toString(),
      altcontact: altcontact.text.toString(),
      state: stateID,
      city: cityID,
      pincode: pincode.text,
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
      address2: villageName.text.toString(), //uppdate
      branch_name: branch_name.text.toString(),
      block: blockID,
      ditrict: ditrictID,
      father_name: father_name.text.toString(),
      blood_group: blood_groupID,
      cheque: cheque != null
          ? await MultipartFile.fromFile(cheque!.path,
              filename: cheque!.path.split('/').last)
          : "",
      spouse_name: wife_name.text.toString(),
      license_expire_date: drivingExpiryController.text.toString(),
      dob: dobController.text.toString(),
      mother_name: mother_name.text.toString(),
      nominee_name: nomineeName.text.toString(),
      nominee_rltn: nomineeRelationship.text.toString(),
      nominee_add: nomineeAddress.text.toString(),
      nominee_dob: dobNomineeController.text.toString(),
    );
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      // ShowToast(msg: "You Resister Sucessfully");
      //
      clearownerResistationForm();

      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      Navigator.pop(context);
    } else {
      ShowToast(
          msg:
              "${allData["response"]["message"].keys.toString()} must be unique");
      print(allData);
    }

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
    isCheck = false;
    dobController.text = "";
    father_name.text = "";
    mother_name.text = "";
    ditrict = "";
    block = "";
    villageName.text = "";
    pincode.text = "";
    blood_group = "";
    cheque = null;
    exp_year.text = "";
    state = "";
    city = "";
    stateID = "";
    cityID = "";
    ditrictID = "";
    blockID = "";
    blood_groupID = "";
    drivingExpiryController.text = "";
    engineNumberField.text = "";
    vechicleRc = null;
    vechicleInsurancef = null;
    vechicleInsurancet = null;
    fitnessCertificate = null;
    polutionCertificate = null;
    branch_name.text = "";
    nomineeName.text = '';
    nomineeAddress.text = "";
    nomineeRelationship.text = "";
    dobNomineeController.text = "";
    wife_name.text = "";
    termsCheck = false;
    criminalCheck = false;
    img_update = null;
    frontimg_update = null;
    backimg_update = null;
    license_img_update = null;
    cheque_update = null;
    notifyListeners();
  }

  initOwnerallfield(UserList owner) {
    name.text = owner.fullName ?? "";
    email.text = owner.email ?? "";
    contact.text = owner.contactNo ?? "";
    altcontact.text = owner.alterCnum ?? "";
    ahdarno.text = owner.adharNo ?? "";
    address1.text = owner.address1 ?? "";
    license_no.text = owner.licenseNo ?? "";
    resister_password.text = owner.password ?? "";
    ac_name.text = owner.acName ?? "";
    bank_name.text = owner.bankName ?? "";
    acc_no.text = owner.accNo ?? "";
    ifsc.text = owner.ifsc ?? "";
    exp_year.text = owner.expYear ?? "";
    img = null;
    frontimg = null;
    backimg = null;
    license_img = null;
    isCheck = owner.isDriver == "0" ? false : true;
    dobController.text = owner.dob ?? "";
    father_name.text = owner.fatherName ?? "";
    mother_name.text = owner.motherName ?? "";
    licenseTpeSelect = "";
    villageName.text = owner.address2 ?? "";
    pincode.text = owner.pin ?? "";

    cheque = null;
    exp_year.text = "";

    drivingExpiryController.text = "";
    engineNumberField.text = "";
    vechicleRc = null;
    vechicleInsurancef = null;
    vechicleInsurancet = null;
    fitnessCertificate = null;
    polutionCertificate = null;
    branch_name.text = owner.branchName ?? "";
    nomineeName.text = owner.nomineeName ?? '';
    nomineeAddress.text = owner.nomineeAdd ?? "";
    nomineeRelationship.text = owner.nomineeRltn ?? "";
    dobNomineeController.text = owner.nomineeDob ?? "";
    owner.spouseName != null || owner.spouseName != ""
        ? married_type = 1
        : married_type = 2;
    wife_name.text = owner.spouseName ?? "";
    termsCheck = true;
    criminalCheck = true;
    owner.stateId != null || owner.stateId != ""
        ? stateinit(owner.stateId!)
        : null;
    owner.cityId == null || owner.cityId == "" ? null : cityinit(owner.cityId!);
    owner.ditrict == null || owner.ditrict == ""
        ? null
        : districtinit(owner.ditrict!);
    owner.block == null || owner.block == "" ? null : blockinit(owner.block!);
    owner.bloodGroup == null || owner.bloodGroup == ""
        ? null
        : bloodGrupinit(owner.bloodGroup!);
    owner.licenseNo == "" || owner.licenseNo == null
        ? isCheck = false
        : isCheck = true;
    owner.profileImage == "" || owner.profileImage == null
        ? null
        : img_update = owner.profileImage;
    owner.licenseImg == "" || owner.licenseImg == null
        ? null
        : license_img_update = owner.licenseImg;
    owner.adharFont == "" || owner.adharFont == null
        ? null
        : frontimg_update = owner.adharFont;
    owner.adharBack == "" || owner.adharBack == null
        ? null
        : backimg_update = owner.adharBack;

    owner.cheque == "" || owner.cheque == null
        ? null
        : cheque_update = owner.cheque;
    notifyListeners();
  }

  stateinit(String sttateID) async {
    // Future.delayed(Duration(seconds: 5), () {
    var selectStt = masterModel!.response!.state!
        .where((element) => element.stateId.toString() == sttateID)
        .toList();
    if (selectStt.length != 0) {
      stateID = selectStt[0].stateId!;
      state = selectStt[0].stateName!;
    }
  }

  cityinit(String sttateID) async {
    // Future.delayed(Duration(seconds: 5), () {
    var selectStt = masterModel!.response!.city!
        .where((element) => element.cityId.toString() == sttateID)
        .toList();
    if (selectStt.length != 0) {
      cityID = selectStt[0].cityId!;
      city = selectStt[0].cityName!;
    }
  }

  districtinit(String sttateID) async {
    // Future.delayed(Duration(seconds: 5), () {
    var selectStt = masterModel!.response!.districts!
        .where((element) => element.id == sttateID)
        .toList();
    if (selectStt.length != 0) {
      ditrictID = selectStt[0].id!;
      ditrict = selectStt[0].districtName!;
    }
  }

  blockinit(String sttateID) async {
    // Future.delayed(Duration(seconds: 5), () {
    var selectStt = masterModel!.response!.blocks!
        .where((element) => element.id == sttateID)
        .toList();
    if (selectStt.length != 0) {
      blockID = selectStt[0].id!;
      block = selectStt[0].blockName!;
    }
  }

  bloodGrupinit(String sttateID) async {
    // Future.delayed(Duration(seconds: 5), () {
    var selectStt = masterModel!.response!.bloodGroup!
        .where((element) => element.id == sttateID)
        .toList();
    if (selectStt.length != 0) {
      blood_groupID = selectStt[0].id!;
      blood_group = selectStt[0].bloodGroup!;
    }
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
      masterModel = master.MasterModel.fromJson(allData);
    } else {
      ShowToast(msg: "Wrong to Load Location");
    }
    notifyListeners();
  }

  updatedriverrRegister(BuildContext context, userI) async {
    isloadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await ResisterRepository().updateresisterDriver(
      userI: userI,
      name: name.text.toString(),
      email: email.text.toString(),
      contact: contact.text.toString(),
      altcontact: altcontact.text.toString(),
      state: stateID,
      city: cityID,
      pincode: pincode.text,
      address1: address1.text.toString(),
      address2: villageName.text,
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
      member_id: userId!,
      branch_name: branch_name.text.toString(),
      block: blockID,
      ditrict: ditrictID,
      father_name: father_name.text.toString(),
      blood_group: blood_groupID,
      cheque: cheque != null
          ? await MultipartFile.fromFile(cheque!.path,
              filename: cheque!.path.split('/').last)
          : "",
      spouse_name: wife_name.text.toString(),
      license_expire_date: drivingExpiryController.text.toString(),
      dob: dobController.text.toString(),
      mother_name: mother_name.text.toString(),
      nominee_name: nomineeName.text.toString(),
      nominee_rltn: nomineeRelationship.text.toString(),
      nominee_add: nomineeAddress.text.toString(),
      nominee_dob: dobNomineeController.text.toString(),
    );
    if (allData["error"] == null) {
      ShowToast(msg: "${allData["response"]["success"].toString()}");
      await Provider.of<RecordViewmodel>(context, listen: false)
          .viewAllrecord();
      clearResistationForm();
      Navigator.pop(context);
    } else {
      ShowToast(msg: "${allData["response"].keys.toString()} must be unique");
    }
    isloadingFalse();
    //clearResistationForm();
    // isLoadingupdateFalse();
    notifyListeners();
  } //img,frontimg,backimg,license_img
}

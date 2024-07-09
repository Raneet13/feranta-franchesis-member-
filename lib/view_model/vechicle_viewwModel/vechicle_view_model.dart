import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/imageCompress_function.dart';
import '../../model/resister/master_model.dart';
import '../../model/vechicle/all_owner_model.dart';
import '../../model/vechicle/assign_vechicle_driver_otp.dart';
import '../../model/vechicle/memberWise_veehicle_model.dart';
import '../../model/vechicle/vechicle_record_model.dart';
import '../../repository/resister/resister_repository.dart';
import '../../repository/vechicle/vechicle_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class VehicleViewmodel extends ChangeNotifier {
  OwnerModel? ownerModel;
  bool isLoading = false;
  VechcleRecordModel? vechcleRecordModel;
  MasterModel? masterModel;
  bool visibleOwner = false;
  TextEditingController ownerFind = TextEditingController();
  List<Ownerlist>? allFindOwnerList;
  MemberWiseVehicleListModel? memberWiseVehicleListModel;
  bool visibleDriver = false;
  TextEditingController driverFind = TextEditingController();
  List<Driverlist>? allFindDriverList;
  int? select_DriverIndex;
  var strCab = "";
  //add Vechicle form  field
  //vehicle_type,
  TextEditingController otpController = TextEditingController();
  TextEditingController no_of_sit = TextEditingController();
  TextEditingController redg_no = TextEditingController();
  TextEditingController model_name = TextEditingController();
  TextEditingController vehicle_make = TextEditingController();
  TextEditingController vehicle_body = TextEditingController();
  TextEditingController engine_no = TextEditingController();
  TextEditingController chassis_no = TextEditingController();
  TextEditingController manufacture_yr = TextEditingController();
  TextEditingController vehicle_cc = TextEditingController();
  TextEditingController rc_no = TextEditingController();
  String? ownerId;
  String? driverId;
  DateTime? fit_expr;
  DateTime? booking_type;
  DateTime? polution_exp_date;
  DateTime? permit_expr_date;
  DateTime? insurance_date_from;
  DateTime? insurance_date_to;
  String vechiceCategryID = "";

  String vechiceCabCategry = "";
  String vechiceLiftCategry = "";
  List<String> liftSub = ["bike", "taxi"];
  List<String> vehicleType = ["Cab", "Lift", "Ambulance"];
  String selectedVech = "";
  File? insurance_img;
  File? fit_doc;
  File? pollurion_doc;
  File? permit_doc;
  File? seeDemo;
  File? rc_copy;
  String? insurance_img_update;
  String? fit_doc_update;
  String? pollurion_doc_update;
  String? permit_doc_update;
  String? seeDemo_update;
  String? rc_copy_update;
  int? select_OwnerIndex;
  bool showFilterOption = false;
  TextEditingController textfieldText = TextEditingController();
  bool filter = false;
  List<VehicleList>? datewseRecord;
  asignDriverOtp? vechicleAsignDriver;
  //add echiclee form end
  // getAllVechicleModel? allVechicleModel;
  // asignDriverOtp? vechicleAsignDriver;
  // TextEditingController otpController = TextEditingController();
  bool showVerification = false;
  showVerificationTrue() {
    showVerification = true;
    notifyListeners();
  }

  isLoadingupdateTrue() {
    isLoading = true;
    notifyListeners();
  }

  isLoadingupdateFalse() {
    isLoading = false;
    notifyListeners();
  }

  ownerIndexSelect(int index) {
    select_OwnerIndex = index;
    notifyListeners();
  }

  driverIndexSelect(int index) {
    select_DriverIndex = index;
    notifyListeners();
  }

  updateVehicleType(String type) {
    selectedVech = type;
    vechiceCategryID = "";

    vechiceCabCategry = "";
    vechiceLiftCategry = "";
    notifyListeners();
  }

  updateownerVisible() {
    visibleOwner = false;
    notifyListeners();
  }

  updateVehicleCategoryType(VehicleType type) {
    vechiceCategryID = type.id!;
    vechiceCabCategry = type.typeName!;
    notifyListeners();
  }

  updateLiftCategoryType(String type) {
    vechiceLiftCategry = type;
    notifyListeners();
  }

  Future findOwnerAll(String lcnNumber) async {
    isLoadingupdateTrue();
    if (lcnNumber == "") {
      visibleOwner = false;
    } else {
      allFindOwnerList = ownerModel!.response!.ownerlist!
          .where((element) =>
              element.fullName!.contains(lcnNumber) ||
              element.contactNo!.contains(lcnNumber))
          .toList();
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future vechiceNoWiserecord(String lcnNumber) async {
    isLoadingupdateTrue();
    if (lcnNumber == "") {
      filter = false;
    } else {
      datewseRecord = vechcleRecordModel!.response!.vehicleList!
          .where((element) => element.regdNo!.contains(lcnNumber))
          .toList();
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future allOwnerListViewModel() async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().viewAllOwner(member_id: userId);
    if (allData["error"] == null) {
      ownerModel = OwnerModel.fromJson(allData);
    } else {
      ShowToast(msg: "Error to load Drivers list");
    }
    isLoadingupdateFalse();

    notifyListeners();
  }

  Future allDriverListViewModel() async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().viewAllDriver(member_id: userId);
    if (allData["error"] == null) {
      memberWiseVehicleListModel = MemberWiseVehicleListModel.fromJson(allData);
    } else {
      ShowToast(msg: "Error to load Drivers list");
    }
    isLoadingupdateFalse();

    notifyListeners();
  }

  Future findDriverAll(String lcnNumber) async {
    isLoadingupdateTrue();
    if (lcnNumber == "") {
      visibleDriver = false;
    } else {
      allFindDriverList = memberWiseVehicleListModel!.response!.driverlist!
          .where((element) =>
              element.fullName!.contains(lcnNumber) ||
              element.contactNo!.contains(lcnNumber))
          .toList();
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future allVechicleListViewModel() async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().viewAllVechicle(member_id: userId);
    if (allData["error"] == null) {
      vechcleRecordModel = VechcleRecordModel.fromJson(allData);
    } else {
      ShowToast(msg: "Error to load Vechicle list");
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  chooseDate(BuildContext context, String date) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      if (date == "insuranceFrom") {
        insurance_date_from = pickedDate;
        notifyListeners();
      } else if (date == "insurance") {
        insurance_date_to = pickedDate;
        notifyListeners();
      } else if (date == "fitness") {
        fit_expr = pickedDate;
        notifyListeners();
      } else if (date == "permit") {
        permit_expr_date = pickedDate;
        notifyListeners();
      } else if (date == "Polution") {
        polution_exp_date = pickedDate;
        notifyListeners();
      } else {
        ShowToast(msg: "Wrong Date Box yu choose");
      }

      notifyListeners();
    }
    notifyListeners();
  }

  Future addCab(BuildContext context, ownerID) async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().addCabRepo(
        member_id: userId!,
        owner_id: ownerID,
        no_of_sit: no_of_sit.text.toString(),
        redg_no: redg_no.text.toString(),
        model_name: model_name.text.toString(),
        vehicle_type: vechiceCabCategry == ""
            ? vechiceLiftCategry != ""
                ? vechiceLiftCategry == "bike"
                    ? "2"
                    : "1"
                : "1"
            : vechiceCategryID,
        insurance_img: insurance_img != null
            ? await MultipartFile.fromFile(insurance_img!.path,
                filename: insurance_img!.path.split("/").last)
            : "",
        fit_doc: fit_doc != null
            ? await MultipartFile.fromFile(fit_doc!.path,
                filename: fit_doc!.path.split("/").last)
            : "",
        pollurion_doc: pollurion_doc != null
            ? await MultipartFile.fromFile(pollurion_doc!.path,
                filename: pollurion_doc!.path.split("/").last)
            : "",
        permit_doc: permit_doc != null
            ? await MultipartFile.fromFile(permit_doc!.path,
                filename: permit_doc!.path.split("/").last)
            : "",
        vehicle_make: vehicle_make.text.toString(),
        vehicle_body: vehicle_body.text.toString(),
        engine_no: engine_no.text.toString(),
        chassis_no: chassis_no.text.toString(),
        manufacture_yr: manufacture_yr.text.toString(),
        vehicle_cc: vehicle_cc.text.toString(),
        insurance_date_from: insurance_date_from.toString(),
        insurance_date_to: insurance_date_to.toString(),
        fit_expr: fit_expr.toString(),
        polution_exp_date: polution_exp_date.toString(),
        permit_expr_date: permit_expr_date.toString(),
        booking_type: selectedVech == "Cab"
            ? "1"
            : selectedVech == "Lift"
                ? "2"
                : "3",
        rc_no: rc_no.text.toString(),
        rc_copy: rc_copy != null
            ? await MultipartFile.fromFile(rc_copy!.path,
                filename: rc_copy!.path.split("/").last)
            : "",
        driver_id: driverId);
    if (allData["error"] == null) {
      ShowToast(msg: "Vechicle Add Sucessfully");
      await allVechicleListViewModel();
      clearDriverAddDett();
      context.pop();
    } else {
      ShowToast(
          msg: "${allData['response']['message'].keys.toString()} required");
      // print(allData);
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future updateCabView(BuildContext context, ownerID, vehicleID) async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().updateCabRepo(
        vehicleid: vehicleID,
        member_id: userId!,
        owner_id: ownerID,
        no_of_sit: no_of_sit.text.toString(),
        redg_no: redg_no.text.toString(),
        model_name: model_name.text.toString(),
        vehicle_type: vechiceCabCategry == ""
            ? vechiceLiftCategry != ""
                ? vechiceLiftCategry == "bike"
                    ? "2"
                    : "1"
                : "1"
            : vechiceCategryID,
        insurance_img: insurance_img != null
            ? await MultipartFile.fromFile(insurance_img!.path,
                filename: insurance_img!.path.split("/").last)
            : "",
        fit_doc: fit_doc != null
            ? await MultipartFile.fromFile(fit_doc!.path,
                filename: fit_doc!.path.split("/").last)
            : "",
        pollurion_doc: pollurion_doc != null
            ? await MultipartFile.fromFile(pollurion_doc!.path,
                filename: pollurion_doc!.path.split("/").last)
            : "",
        permit_doc: permit_doc != null
            ? await MultipartFile.fromFile(permit_doc!.path,
                filename: permit_doc!.path.split("/").last)
            : "",
        vehicle_make: vehicle_make.text.toString(),
        vehicle_body: vehicle_body.text.toString(),
        engine_no: engine_no.text.toString(),
        chassis_no: chassis_no.text.toString(),
        manufacture_yr: manufacture_yr.text.toString(),
        vehicle_cc: vehicle_cc.text.toString(),
        insurance_date_from: insurance_date_from.toString(),
        insurance_date_to: insurance_date_to.toString(),
        fit_expr: fit_expr.toString(),
        polution_exp_date: polution_exp_date.toString(),
        permit_expr_date: permit_expr_date.toString(),
        booking_type: selectedVech == "Cab"
            ? "1"
            : selectedVech == "Lift"
                ? "2"
                : "3",
        rc_no: rc_no.text.toString(),
        rc_copy: rc_copy != null
            ? await MultipartFile.fromFile(rc_copy!.path,
                filename: rc_copy!.path.split("/").last)
            : "",
        driver_id: driverId);
    if (allData["error"] == null) {
      ShowToast(msg: "Vechicle update Successfully");
      clearDriverAddDett();
      await allVechicleListViewModel();
      context.pop();
    } else {
      ShowToast(
          msg: "${allData['response']['message'].keys.toString()} required");
      // print(allData);
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future insertDemoImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var compressImage =
          await compressFile(file: File(result.files.single.path!));

      seeDemo = File(compressImage!.path);
    } else {
      // print(result);
      // User canceled the picker
    }
    notifyListeners();
  }

  Future submitImage({required String filename}) async {
    if (filename == "InsuranceImg") {
      //InsuranceImg  Permit   fitness  Polution
      insurance_img = seeDemo;
      notifyListeners();
    } else if (filename == "Permit") {
      permit_doc = seeDemo;
      notifyListeners();
    } else if (filename == "fitness") {
      fit_doc = seeDemo;
      notifyListeners();
    } else if (filename == "Polution") {
      pollurion_doc = seeDemo;
      notifyListeners();
    } else if (filename == "rc") {
      rc_copy = seeDemo;
      notifyListeners();
    } else {
      ShowToast(msg: "Wrong file insert");
    }
    seeDemo = null;
    notifyListeners();
  }

  updateFilterOption(bool option) {
    showFilterOption = !option;
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

  clearDriverAddDett() {
    ownerFind.text = "";
    ownerId = "";
    visibleOwner = false;
    select_OwnerIndex = null;
    select_DriverIndex = null;
    driverFind.text = "";
    driverId = "";
    visibleDriver = false;

    no_of_sit.text = "";
    redg_no.text = "";
    model_name.text = "";
    vechiceCabCategry == "";
    vechiceLiftCategry = "";
    vechiceCategryID = "";
    insurance_img = null;
    fit_doc = null;
    pollurion_doc = null;
    permit_doc = null;
    vehicle_make.text = "";
    vehicle_body.text = "";
    engine_no.text = "";
    chassis_no.text = "";
    manufacture_yr.text = "";
    vehicle_cc.text = "";
    insurance_date_from = null;
    insurance_date_to = null;
    fit_expr = null;
    polution_exp_date = null;
    permit_expr_date = null;
    booking_type = null;
    rc_no.text = "";
    rc_copy = null;
    selectedVech = "";
    notifyListeners();
  }

  initVehicle(VehicleList vehicleee) {
    //;
    vehicleee.vendorId == null || vehicleee.vendorId == ""
        ? null
        : ownerNameInit(vehicleee.vendorId!);
    vehicleee.driverId == null || vehicleee.driverId == ""
        ? null
        : //memberWiseVehicleListModel!
        driverNameInit(vehicleee.driverId);
    no_of_sit.text = vehicleee.noOfSit ?? "";
    redg_no.text = vehicleee.regdNo ?? "";
    model_name.text = vehicleee.modelName ?? "";
    insurance_img_update = vehicleee.insuranceImg ?? "";
    fit_doc_update = vehicleee.fitDoc ?? "";
    pollurion_doc_update = vehicleee.pollurionDoc ?? "";
    permit_doc_update = vehicleee.permitDoc ?? "";
    vehicle_make.text = vehicleee.vehicleMake ?? "";
    vehicle_body.text = vehicleee.vehicleBody ?? "";
    engine_no.text = vehicleee.engineNo ?? "";
    chassis_no.text = vehicleee.chassisNo ?? "";
    manufacture_yr.text = vehicleee.manufactureYr ?? "";
    vehicle_cc.text = vehicleee.vehicleCc ?? "";
    if (vehicleee.insuranceDateFrom != null) {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
        insurance_date_from = format.parse(vehicleee.insuranceDateFrom!);
      } catch (e) {
        // Handle parse error
        insurance_date_from = null;
      }
    } else {
      insurance_date_from = null;
    }
    if (vehicleee.insuranceDateTo != null) {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
        insurance_date_to = format.parse(vehicleee.insuranceDateTo!);
      } catch (e) {
        // Handle parse error
        insurance_date_to = null;
      }
    } else {
      insurance_date_to = null;
    }
    if (vehicleee.fitExpr != null) {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
        fit_expr = format.parse(vehicleee.fitExpr!);
      } catch (e) {
        // Handle parse error
        fit_expr = null;
      }
    } else {
      fit_expr = null;
    }

    if (vehicleee.polutionExpDate != null) {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
        polution_exp_date = format.parse(vehicleee.polutionExpDate!);
      } catch (e) {
        // Handle parse error
        polution_exp_date = null;
      }
    } else {
      polution_exp_date = null;
    }
    if (vehicleee.permitExprDate != null) {
      try {
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
        permit_expr_date = format.parse(vehicleee.permitExprDate!);
      } catch (e) {
        // Handle parse error
        permit_expr_date = null;
      }
    } else {
      permit_expr_date = null;
    }
    // insurance_date_from = vehicleee.insuranceDateFrom != null
    //     ? DateFormat('dd/MM/yyyy').parse(vehicleee.insuranceDateFrom ?? "")
    //     : null;

    // insurance_date_to = vehicleee.insuranceDateTo != null
    //     ? DateTime.parse(vehicleee.insuranceDateTo ?? "")
    //     : null;
    // fit_expr = vehicleee.fitExpr != null
    //     ? DateTime.parse(vehicleee.fitExpr ?? "")
    //     : null;
    // polution_exp_date = vehicleee.polutionExpDate != null
    //     ? DateTime.parse(vehicleee.polutionExpDate ?? "")
    //     : null;
    // permit_expr_date = vehicleee.permitExprDate != null
    //     ? DateTime.parse(vehicleee.permitExprDate ?? "")
    //     : null;
    rc_no.text = vehicleee.rcNo ?? "";
    rc_copy_update = vehicleee.rcCopy ?? "";
    vehicleee.bookingType == null || vehicleee.bookingType == ""
        ? null
        : selectedVech =
            vehicleType[int.parse(vehicleee.bookingType ?? "") - 1];
    // vehicleee.bookingType == "1"
    //     ? "Cab"
    //     : vehicleee.bookingType == "2"
    //         ? "Lift"
    //         : "Ambulance";...
    vehicleee.bookingType == "1"
        ? findCabTypeInit(vehicleee.typeId!)
        : vehicleee.bookingType == "2"
            ? findLiftTypeInit(vehicleee.typeId!)
            : null;
    // vechiceCabCategry ==vehicleee. ""
    //         ? vechiceLiftCategry != ""
    //             ? vechiceLiftCategry == "bike"
    //                 ? "1"
    //                 : "2"
    //             : null
    //         : vechiceCategryID,
    notifyListeners();
  }

  findLiftTypeInit(String Ownerght) async {
    // var selectStt =
    //     await liftSub.where((element) => element == OwnerII).toList();
    // if (selectStt.length != 0) {
    vechiceLiftCategry = liftSub[int.parse(Ownerght) - 1];
    // ownerId = selectStt[0].id!;
    // ownerFind.text = selectStt[0].fullName!;
    // }
    notifyListeners();
  }

  findCabTypeInit(String OwnerII) async {
    var selectStt = await masterModel!.response!.vehicleType!
        .where((element) => element.id == OwnerII)
        .toList();
    if (selectStt.length != 0) {
      vechiceCabCategry = selectStt[0].typeName!;
      vechiceCategryID = selectStt[0].id!;
    }
    notifyListeners();
  }

  Future<String> findLiftTypeDets(String Ownerght) async {
    // var selectStt =
    //     await liftSub.where((element) => element == OwnerII).toList();
    // if (selectStt.length != 0) {
    var tye = liftSub[int.parse(Ownerght) - 1];
    // ownerId = selectStt[0].id!;
    // ownerFind.text = selectStt[0].fullName!;
    // }
    return tye;
    // notifyListeners();
  }

  findCabTypeDets(String OwnerII) {
    // late String vechtype;
    var selectStt = masterModel?.response?.vehicleType!
        .where((element) => element.id == OwnerII)
        .toList();
    if (selectStt?.length != 0) {
      strCab = selectStt![0].typeName!;
    } else
      // vechtype = "";
      // return vechtype;

      notifyListeners();
  }

  ownerNameInit(String OwnerII) async {
    print(ownerModel!.toJson());
    var selectStt = await ownerModel!.response!.ownerlist!
        .where((element) => element.id == OwnerII)
        .toList();
    if (selectStt.length != 0) {
      ownerId = selectStt[0].id!;
      ownerFind.text = selectStt[0].fullName!;
    }
    notifyListeners();
  }

  driverNameInit(String DriverII) async {
    // print(ownerModel!.toJson());
    var selectStt = await memberWiseVehicleListModel!.response!.driverlist!
        .where((element) => element.id == DriverII)
        .toList();
    if (selectStt.length != 0) {
      driverId = selectStt[0].id!;
      driverFind.text = selectStt[0].fullName!;
    }
    notifyListeners();
  }
  // Future allVechicleList() async {
  //   isLoadingupdateTrue();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? ownerId = await prefs.getString('ownerID');
  //   var allData = await DriverRepository().getVechicleList(owner_id: ownerId);
  //   if (allData["error"] == null) {
  //     allVechicleModel = getAllVechicleModel.fromJson(allData);
  //   } else {
  //     ShowToast(msg: "Error to load Drivers list");
  //   }
  //   isLoadingupdateFalse();
  //   notifyListeners();
  // }

  // Future vechicleAsignOTPDriver(
  //     {required driver_id, required vehicle_id}) async {
  //   isLoadingupdateTrue();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? ownerId = await prefs.getString('ownerID');
  //   var allData = await DriverRepository().vechicleasignOTPdriver(
  //       owner_id: ownerId, driver_id: driver_id, vehicle_id: vehicle_id);
  //   if (allData["error"] == null) {
  //     vechicleAsignDriver = asignDriverOtp.fromJson(allData);
  //     // allVechicleModel = getAllVechicleModel.fromJson(allData);
  //     ShowToast(msg: vechicleAsignDriver!.response!.otp.toString());
  //   } else {
  //     print(allData);
  //     ShowToast(msg: "Error to load Drivers list");
  //   }
  //   isLoadingupdateFalse();
  //   notifyListeners();
  // }

  // Future verifyOtp(
  //     {required driver_id, required vehicle_id, required otp}) async {
  //   isLoadingupdateTrue();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? ownerId = await prefs.getString('ownerID');
  //   if (otp.toString() == vechicleAsignDriver!.response!.otp.toString()) {
  //     var allData = await DriverRepository().verifyvechicleasignOTPdriver(
  //         owner_id: ownerId,
  //         driver_id: driver_id,
  //         vehicle_id: vehicle_id,
  //         otp: vechicleAsignDriver!.response!.otp.toString());
  //     if (allData["error"] == null) {
  //       // vechicleAsignDriver = asignDriverOtp.fromJson(allData);
  //       // allVechicleModel = getAllVechicleModel.fromJson(allData);
  //       ShowToast(msg: "Otp Verified Sucessfully");
  //     } else {
  //       ShowToast(msg: "Error to load Drivers list");
  //     }
  //   } else {
  //     ShowToast(msg: "Otp does nt match");
  //   }

  //   isLoadingupdateFalse();
  //   notifyListeners();
  // }
  Future vechicleAsignOTPDriver(
      {required driver_id, required vehicle_id}) async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString("userId");
    var allData = await VehicleRepository().vechicleasignOTPdriver(
        owner_id: userId, driver_id: driver_id, vehicle_id: vehicle_id);
    if (allData["error"] == null) {
      vechicleAsignDriver = asignDriverOtp.fromJson(allData);
      otpController.text = vechicleAsignDriver!.response!.otp.toString();

      // allVechicleModel = getAllVechicleModel.fromJson(allData);
      // ShowToast(msg: vechicleAsignDriver!.response!.otp.toString());
    } else {
      print(allData);
      ShowToast(msg: "Error to load Drivers list");
    }
    isLoadingupdateFalse();
    notifyListeners();
  }

  Future verifyOtp(
      {required driver_id,
      required vehicle_id,
      required otp,
      required ownerId}) async {
    isLoadingupdateTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? ownerId = await prefs.getString('ownerID');
    if (otp.toString() == vechicleAsignDriver!.response!.otp.toString()) {
      var allData = await VehicleRepository().verifyvechicleasignOTPdriver(
          owner_id: ownerId,
          driver_id: driver_id,
          vehicle_id: vehicle_id,
          otp: vechicleAsignDriver!.response!.otp.toString());
      if (allData["error"] == null) {
        // vechicleAsignDriver = asignDriverOtp.fromJson(allData);
        // allVechicleModel = getAllVechicleModel.fromJson(allData);
        ShowToast(msg: "Otp Verified Sucessfully");
        await allVechicleListViewModel();
      } else {
        // print(allData);
        ShowToast(msg: "Vehicle Not Assign Driver");
      }
    } else {
      ShowToast(msg: "Otp Does Not match");
    }
    otpController.text = "";

    isLoadingupdateFalse();
    notifyListeners();
  }
}// 

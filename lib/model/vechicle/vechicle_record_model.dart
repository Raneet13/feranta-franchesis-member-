class VechcleRecordModel {
  int? status;
  dynamic error;
  Response? response;

  VechcleRecordModel({this.status, this.error, this.response});

  VechcleRecordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? success;
  List<VehicleList>? vehicleList;

  Response({this.success, this.vehicleList});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['vehicleList'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicleList'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.vehicleList != null) {
      data['vehicleList'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleList {
  String? id;
  String? typeId;
  String? vendorId;
  dynamic driverId;
  String? bookingType;
  dynamic liftVehicleType;
  String? modelName;
  String? regdNo;
  String? noOfSit;
  String? vehicleMake;
  String? vehicleBody;
  String? engineNo;
  String? chassisNo;
  String? manufactureYr;
  String? vehicleCc;
  String? insuranceDateFrom;
  String? insuranceDateTo;
  String? insuranceImg;
  String? fitExpr;
  String? fitDoc;
  String? polutionExpDate;
  String? pollurionDoc;
  String? permitExprDate;
  String? permitDoc;
  dynamic rcNo;
  dynamic rcCopy;
  String? status;
  String? addedBy;
  String? createAt;
  String? ownerName;
  String? ownerNumber;
  dynamic driverName;
  dynamic driverNumber;

  VehicleList(
      {this.id,
      this.typeId,
      this.vendorId,
      this.driverId,
      this.bookingType,
      this.liftVehicleType,
      this.modelName,
      this.regdNo,
      this.noOfSit,
      this.vehicleMake,
      this.vehicleBody,
      this.engineNo,
      this.chassisNo,
      this.manufactureYr,
      this.vehicleCc,
      this.insuranceDateFrom,
      this.insuranceDateTo,
      this.insuranceImg,
      this.fitExpr,
      this.fitDoc,
      this.polutionExpDate,
      this.pollurionDoc,
      this.permitExprDate,
      this.permitDoc,
      this.rcNo,
      this.rcCopy,
      this.status,
      this.addedBy,
      this.createAt,
      this.ownerName,
      this.ownerNumber,
      this.driverName,
      this.driverNumber});

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    vendorId = json['vendor_id'];
    driverId = json['driver_id'];
    bookingType = json['booking_type'];
    liftVehicleType = json['lift_vehicle_type'];
    modelName = json['model_name'];
    regdNo = json['regd_no'];
    noOfSit = json['no_of_sit'];
    vehicleMake = json['vehicle_make'];
    vehicleBody = json['vehicle_body'];
    engineNo = json['engine_no'];
    chassisNo = json['chassis_no'];
    manufactureYr = json['manufacture_yr'];
    vehicleCc = json['vehicle_cc'];
    insuranceDateFrom = json['insurance_date_from'];
    insuranceDateTo = json['insurance_date_to'];
    insuranceImg = json['insurance_img'];
    fitExpr = json['fit_expr'];
    fitDoc = json['fit_doc'];
    polutionExpDate = json['polution_exp_date'];
    pollurionDoc = json['pollurion_doc'];
    permitExprDate = json['permit_expr_date'];
    permitDoc = json['permit_doc'];
    rcNo = json['rc_no'];
    rcCopy = json['rc_copy'];
    status = json['status'];
    addedBy = json['added_by'];
    createAt = json['create_at'];
    ownerName = json['owner_name'];
    ownerNumber = json['owner_number'];
    driverName = json['driver_name'];
    driverNumber = json['driver_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['vendor_id'] = this.vendorId;
    data['driver_id'] = this.driverId;
    data['booking_type'] = this.bookingType;
    data['lift_vehicle_type'] = this.liftVehicleType;
    data['model_name'] = this.modelName;
    data['regd_no'] = this.regdNo;
    data['no_of_sit'] = this.noOfSit;
    data['vehicle_make'] = this.vehicleMake;
    data['vehicle_body'] = this.vehicleBody;
    data['engine_no'] = this.engineNo;
    data['chassis_no'] = this.chassisNo;
    data['manufacture_yr'] = this.manufactureYr;
    data['vehicle_cc'] = this.vehicleCc;
    data['insurance_date_from'] = this.insuranceDateFrom;
    data['insurance_date_to'] = this.insuranceDateTo;
    data['insurance_img'] = this.insuranceImg;
    data['fit_expr'] = this.fitExpr;
    data['fit_doc'] = this.fitDoc;
    data['polution_exp_date'] = this.polutionExpDate;
    data['pollurion_doc'] = this.pollurionDoc;
    data['permit_expr_date'] = this.permitExprDate;
    data['permit_doc'] = this.permitDoc;
    data['rc_no'] = this.rcNo;
    data['rc_copy'] = this.rcCopy;
    data['status'] = this.status;
    data['added_by'] = this.addedBy;
    data['create_at'] = this.createAt;
    data['owner_name'] = this.ownerName;
    data['owner_number'] = this.ownerNumber;
    data['driver_name'] = this.driverName;
    data['driver_number'] = this.driverNumber;
    return data;
  }
}

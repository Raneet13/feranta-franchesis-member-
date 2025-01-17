class LoginModel {
  int? status;
  dynamic error;
  Response? response;

  LoginModel({this.status, this.error, this.response});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  ProfileDetails? profileDetails;

  Response({this.message, this.profileDetails});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profileDetails = json['profileDetails'] != null
        ? new ProfileDetails.fromJson(json['profileDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.profileDetails != null) {
      data['profileDetails'] = this.profileDetails!.toJson();
    }
    return data;
  }
}

class ProfileDetails {
  String? id;
  String? fullName;
  String? userName;
  String? password;
  String? email;
  String? contactNo;
  dynamic gender;
  String? alterCnum;
  String? profileImage;
  dynamic centerName;
  String? details;
  dynamic acName;
  dynamic bankName;
  dynamic accNo;
  dynamic ifsc;
  dynamic expYear;
  dynamic centerRedgProof;
  dynamic gst;
  dynamic gstImage;
  String? adharFont;
  String? adharBack;
  String? adharNo;
  String? userType;
  String? isDriver;
  dynamic licenseNo;
  dynamic licenseImg;
  String? cityId;
  dynamic areaId;
  String? stateId;
  dynamic pin;
  String? address1;
  String? address2;
  dynamic commition;
  dynamic bannerImage;
  dynamic logoImage;
  dynamic hygene;
  dynamic acciesType;
  String? status;
  dynamic reasone;
  String? wallet;
  dynamic otp;
  dynamic lat;
  dynamic lng;
  dynamic roles;
  dynamic accountDetails;
  dynamic benefName;
  dynamic merchantAgrrement;
  String? deviceToken;
  dynamic createdBy;
  String? createdDate;
  String? updatedDate;

  ProfileDetails(
      {this.id,
      this.fullName,
      this.userName,
      this.password,
      this.email,
      this.contactNo,
      this.gender,
      this.alterCnum,
      this.profileImage,
      this.centerName,
      this.details,
      this.acName,
      this.bankName,
      this.accNo,
      this.ifsc,
      this.expYear,
      this.centerRedgProof,
      this.gst,
      this.gstImage,
      this.adharFont,
      this.adharBack,
      this.adharNo,
      this.userType,
      this.isDriver,
      this.licenseNo,
      this.licenseImg,
      this.cityId,
      this.areaId,
      this.stateId,
      this.pin,
      this.address1,
      this.address2,
      this.commition,
      this.bannerImage,
      this.logoImage,
      this.hygene,
      this.acciesType,
      this.status,
      this.reasone,
      this.wallet,
      this.otp,
      this.lat,
      this.lng,
      this.roles,
      this.accountDetails,
      this.benefName,
      this.merchantAgrrement,
      this.deviceToken,
      this.createdBy,
      this.createdDate,
      this.updatedDate});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['user_name'];
    password = json['password'];
    email = json['email'];
    contactNo = json['contact_no'];
    gender = json['gender'];
    alterCnum = json['alter_cnum'];
    profileImage = json['profile_image'];
    centerName = json['center_name'];
    details = json['details'];
    acName = json['ac_name'];
    bankName = json['bank_name'];
    accNo = json['acc_no'];
    ifsc = json['ifsc'];
    expYear = json['exp_year'];
    centerRedgProof = json['center_redg_proof'];
    gst = json['gst'];
    gstImage = json['gst_image'];
    adharFont = json['adhar_font'];
    adharBack = json['adhar_back'];
    adharNo = json['adhar_no'];
    userType = json['user_type'];
    isDriver = json['is_driver'];
    licenseNo = json['license_no'];
    licenseImg = json['license_img'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    stateId = json['state_id'];
    pin = json['pin'];
    address1 = json['address1'];
    address2 = json['address2'];
    commition = json['commition'];
    bannerImage = json['banner_image'];
    logoImage = json['logo_image'];
    hygene = json['hygene'];
    acciesType = json['accies_type'];
    status = json['status'];
    reasone = json['reasone'];
    wallet = json['wallet'];
    otp = json['otp'];
    lat = json['lat'];
    lng = json['lng'];
    roles = json['roles'];
    accountDetails = json['account_details'];
    benefName = json['benef_name'];
    merchantAgrrement = json['merchant_agrrement'];
    deviceToken = json['device_token'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['gender'] = this.gender;
    data['alter_cnum'] = this.alterCnum;
    data['profile_image'] = this.profileImage;
    data['center_name'] = this.centerName;
    data['details'] = this.details;
    data['ac_name'] = this.acName;
    data['bank_name'] = this.bankName;
    data['acc_no'] = this.accNo;
    data['ifsc'] = this.ifsc;
    data['exp_year'] = this.expYear;
    data['center_redg_proof'] = this.centerRedgProof;
    data['gst'] = this.gst;
    data['gst_image'] = this.gstImage;
    data['adhar_font'] = this.adharFont;
    data['adhar_back'] = this.adharBack;
    data['adhar_no'] = this.adharNo;
    data['user_type'] = this.userType;
    data['is_driver'] = this.isDriver;
    data['license_no'] = this.licenseNo;
    data['license_img'] = this.licenseImg;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['state_id'] = this.stateId;
    data['pin'] = this.pin;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['commition'] = this.commition;
    data['banner_image'] = this.bannerImage;
    data['logo_image'] = this.logoImage;
    data['hygene'] = this.hygene;
    data['accies_type'] = this.acciesType;
    data['status'] = this.status;
    data['reasone'] = this.reasone;
    data['wallet'] = this.wallet;
    data['otp'] = this.otp;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['roles'] = this.roles;
    data['account_details'] = this.accountDetails;
    data['benef_name'] = this.benefName;
    data['merchant_agrrement'] = this.merchantAgrrement;
    data['device_token'] = this.deviceToken;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

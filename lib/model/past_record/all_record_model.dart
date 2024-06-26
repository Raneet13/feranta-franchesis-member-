class Allrecord {
  int? status;
  dynamic error;
  Response? response;

  Allrecord({this.status, this.error, this.response});

  Allrecord.fromJson(Map<String, dynamic> json) {
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
  List<UserList>? userList;

  Response({this.success, this.userList});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['userList'] != null) {
      userList = <UserList>[];
      json['userList'].forEach((v) {
        userList!.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.userList != null) {
      data['userList'] = this.userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
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
  dynamic details;
  String? acName;
  String? bankName;
  String? accNo;
  String? ifsc;
  String? expYear;
  dynamic centerRedgProof;
  dynamic gst;
  dynamic gstImage;
  String? adharFont;
  String? adharBack;
  String? adharNo;
  String? userType;
  String? isDriver;
  String? licenseNo;
  String? licenseExpireDate;
  String? licenseImg;
  String? cityId;
  dynamic areaId;
  String? stateId;
  String? pin;
  String? address1;
  String? address2;
  String? branchName;
  String? block;
  String? ditrict;
  String? fatherName;
  dynamic spouseName;
  String? motherName;
  String? nomineeName;
  String? nomineeRltn;
  String? nomineeAdd;
  String? nomineeDob;
  String? dob;
  String? bloodGroup;
  String? cheque;
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
  dynamic franchiseId;
  String? isAdmin;
  String? createdBy;
  String? createdDate;
  String? updatedDate;

  UserList(
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
      this.licenseExpireDate,
      this.licenseImg,
      this.cityId,
      this.areaId,
      this.stateId,
      this.pin,
      this.address1,
      this.address2,
      this.branchName,
      this.block,
      this.ditrict,
      this.fatherName,
      this.spouseName,
      this.motherName,
      this.nomineeName,
      this.nomineeRltn,
      this.nomineeAdd,
      this.nomineeDob,
      this.dob,
      this.bloodGroup,
      this.cheque,
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
      this.franchiseId,
      this.isAdmin,
      this.createdBy,
      this.createdDate,
      this.updatedDate});

  UserList.fromJson(Map<String, dynamic> json) {
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
    licenseExpireDate = json['license_expire_date'];
    licenseImg = json['license_img'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    stateId = json['state_id'];
    pin = json['pin'];
    address1 = json['address1'];
    address2 = json['address2'];
    branchName = json['branch_name'];
    block = json['block'];
    ditrict = json['ditrict'];
    fatherName = json['father_name'];
    spouseName = json['spouse_name'];
    motherName = json['mother_name'];
    nomineeName = json['nominee_name'];
    nomineeRltn = json['nominee_rltn'];
    nomineeAdd = json['nominee_add'];
    nomineeDob = json['nominee_dob'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    cheque = json['cheque'];
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
    franchiseId = json['franchise_id'];
    isAdmin = json['is_admin'];
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
    data['license_expire_date'] = this.licenseExpireDate;
    data['license_img'] = this.licenseImg;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['state_id'] = this.stateId;
    data['pin'] = this.pin;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['branch_name'] = this.branchName;
    data['block'] = this.block;
    data['ditrict'] = this.ditrict;
    data['father_name'] = this.fatherName;
    data['spouse_name'] = this.spouseName;
    data['mother_name'] = this.motherName;
    data['nominee_name'] = this.nomineeName;
    data['nominee_rltn'] = this.nomineeRltn;
    data['nominee_add'] = this.nomineeAdd;
    data['nominee_dob'] = this.nomineeDob;
    data['dob'] = this.dob;
    data['blood_group'] = this.bloodGroup;
    data['cheque'] = this.cheque;
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
    data['franchise_id'] = this.franchiseId;
    data['is_admin'] = this.isAdmin;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

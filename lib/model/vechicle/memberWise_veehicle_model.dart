class MemberWiseVehicleListModel {
  int? status;
  dynamic error;
  Response? response;

  MemberWiseVehicleListModel({this.status, this.error, this.response});

  MemberWiseVehicleListModel.fromJson(Map<String, dynamic> json) {
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
  List<Driverlist>? driverlist;

  Response({this.success, this.driverlist});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['driverlist'] != null) {
      driverlist = <Driverlist>[];
      json['driverlist'].forEach((v) {
        driverlist!.add(new Driverlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.driverlist != null) {
      data['driverlist'] = this.driverlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Driverlist {
  String? id;
  String? fullName;
  String? contactNo;

  Driverlist({this.id, this.fullName, this.contactNo});

  Driverlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['contact_no'] = this.contactNo;
    return data;
  }
}

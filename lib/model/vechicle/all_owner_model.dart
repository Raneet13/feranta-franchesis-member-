class OwnerModel {
  int? status;
  dynamic error;
  Response? response;

  OwnerModel({this.status, this.error, this.response});

  OwnerModel.fromJson(Map<String, dynamic> json) {
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
  List<Ownerlist>? ownerlist;

  Response({this.success, this.ownerlist});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['ownerlist'] != null) {
      ownerlist = <Ownerlist>[];
      json['ownerlist'].forEach((v) {
        ownerlist!.add(new Ownerlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.ownerlist != null) {
      data['ownerlist'] = this.ownerlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ownerlist {
  String? id;
  String? fullName;
  String? contactNo;

  Ownerlist({this.id, this.fullName, this.contactNo});

  Ownerlist.fromJson(Map<String, dynamic> json) {
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

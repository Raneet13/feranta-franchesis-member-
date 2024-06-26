class CheckInoutHistoryModel {
  int? status;
  dynamic error;
  Response? response;

  CheckInoutHistoryModel({this.status, this.error, this.response});

  CheckInoutHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Checklist>? checklist;

  Response({this.success, this.checklist});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['checklist'] != null) {
      checklist = <Checklist>[];
      json['checklist'].forEach((v) {
        checklist!.add(new Checklist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.checklist != null) {
      data['checklist'] = this.checklist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Checklist {
  String? id;
  String? memberId;
  String? type;
  String? image;
  String? date;
  String? time;
  String? createdAt;

  Checklist(
      {this.id,
      this.memberId,
      this.type,
      this.image,
      this.date,
      this.time,
      this.createdAt});

  Checklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    type = json['type'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['type'] = this.type;
    data['image'] = this.image;
    data['date'] = this.date;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    return data;
  }
}

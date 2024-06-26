class asignDriverOtp {
  int? status;
  dynamic error;
  Response? response;

  asignDriverOtp({this.status, this.error, this.response});

  asignDriverOtp.fromJson(Map<String, dynamic> json) {
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
  int? otp;

  Response({this.success, this.otp});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['otp'] = this.otp;
    return data;
  }
}

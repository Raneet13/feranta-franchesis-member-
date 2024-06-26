class MasterModel {
  int? status;
  dynamic error;
  Response? response;

  MasterModel({this.status, this.error, this.response});

  MasterModel.fromJson(Map<String, dynamic> json) {
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
  List<VehicleType>? vehicleType;
  List<State>? state;
  List<City>? city;
  List<Pincode>? pincode;
  List<BloodGroup>? bloodGroup;
  List<Districts>? districts;
  List<Blocks>? blocks;

  Response(
      {this.message,
      this.vehicleType,
      this.state,
      this.city,
      this.pincode,
      this.bloodGroup,
      this.districts,
      this.blocks});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['vehicle_type'] != null) {
      vehicleType = <VehicleType>[];
      json['vehicle_type'].forEach((v) {
        vehicleType!.add(new VehicleType.fromJson(v));
      });
    }
    if (json['state'] != null) {
      state = <State>[];
      json['state'].forEach((v) {
        state!.add(new State.fromJson(v));
      });
    }
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
    if (json['pincode'] != null) {
      pincode = <Pincode>[];
      json['pincode'].forEach((v) {
        pincode!.add(new Pincode.fromJson(v));
      });
    }
    if (json['blood_group'] != null) {
      bloodGroup = <BloodGroup>[];
      json['blood_group'].forEach((v) {
        bloodGroup!.add(new BloodGroup.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(new Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.vehicleType != null) {
      data['vehicle_type'] = this.vehicleType!.map((v) => v.toJson()).toList();
    }
    if (this.state != null) {
      data['state'] = this.state!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    if (this.pincode != null) {
      data['pincode'] = this.pincode!.map((v) => v.toJson()).toList();
    }
    if (this.bloodGroup != null) {
      data['blood_group'] = this.bloodGroup!.map((v) => v.toJson()).toList();
    }
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    if (this.blocks != null) {
      data['blocks'] = this.blocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleType {
  String? id;
  String? typeName;
  String? status;
  String? createdAt;

  VehicleType({this.id, this.typeName, this.status, this.createdAt});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class State {
  String? stateId;
  String? stateName;
  String? stateStatus;
  String? createdDate;
  String? updatedDate;

  State(
      {this.stateId,
      this.stateName,
      this.stateStatus,
      this.createdDate,
      this.updatedDate});

  State.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    stateStatus = json['state_status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['state_status'] = this.stateStatus;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

class City {
  String? cityId;
  String? cityName;
  String? stateId;
  dynamic status;
  String? createdDate;
  String? updatedDate;

  City(
      {this.cityId,
      this.cityName,
      this.stateId,
      this.status,
      this.createdDate,
      this.updatedDate});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    stateId = json['state_id'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['state_id'] = this.stateId;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

class Pincode {
  String? pinId;
  String? stateId;
  String? cityId;
  String? pincode;
  dynamic status;
  String? createdDate;
  String? updatedDate;

  Pincode(
      {this.pinId,
      this.stateId,
      this.cityId,
      this.pincode,
      this.status,
      this.createdDate,
      this.updatedDate});

  Pincode.fromJson(Map<String, dynamic> json) {
    pinId = json['pin_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin_id'] = this.pinId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

class BloodGroup {
  String? id;
  String? bloodGroup;

  BloodGroup({this.id, this.bloodGroup});

  BloodGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}

class Districts {
  String? id;
  String? districtName;

  Districts({this.id, this.districtName});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_name'] = this.districtName;
    return data;
  }
}

class Blocks {
  String? id;
  String? blockName;

  Blocks({this.id, this.blockName});

  Blocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockName = json['block_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['block_name'] = this.blockName;
    return data;
  }
}

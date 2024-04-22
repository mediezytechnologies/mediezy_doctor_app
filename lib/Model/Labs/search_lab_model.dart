class SearchLabModel {
  SearchLabModel({
      this.success, 
      this.laboratory, 
      this.code, 
      this.message,});

  SearchLabModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['Laboratory'] != null) {
      laboratory = [];
      json['Laboratory'].forEach((v) {
        laboratory?.add(Laboratory.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  List<Laboratory>? laboratory;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (laboratory != null) {
      map['Laboratory'] = laboratory?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Laboratory {
  Laboratory({
      this.id, 
      this.userId, 
      this.laboratory, 
      this.laboratoryimage, 
      this.mobileNo, 
      this.location, 
      this.favoriteStatus,});

  Laboratory.fromJson(dynamic json) {
    id = json['id'];
    userId = json['UserId'];
    laboratory = json['Laboratory'];
    laboratoryimage = json['Laboratoryimage'];
    mobileNo = json['mobileNo'];
    location = json['location'];
    favoriteStatus = json['favoriteStatus'];
  }
  int? id;
  int? userId;
  String? laboratory;
  String? laboratoryimage;
  String? mobileNo;
  String? location;
  int? favoriteStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['UserId'] = userId;
    map['Laboratory'] = laboratory;
    map['Laboratoryimage'] = laboratoryimage;
    map['mobileNo'] = mobileNo;
    map['location'] = location;
    map['favoriteStatus'] = favoriteStatus;
    return map;
  }

}
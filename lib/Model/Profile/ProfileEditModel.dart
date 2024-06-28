// profile_edit_model.dart

class ProfileEditModel {
  ProfileEditModel({
    this.success,
    this.userId,
    this.docter,
    this.code,
    this.message,
  });

  ProfileEditModel.fromJson(dynamic json) {
    success = json['success'];
    userId = json['UserId'];
    docter = json['Docter'] != null ? Docter.fromJson(json['Docter']) : null;
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  int? userId;
  Docter? docter;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['UserId'] = userId;
    if (docter != null) {
      map['Docter'] = docter?.toJson();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }
}

class Docter {
  Docter({
    this.id,
    this.firstname,
    this.lastname,
    this.docterImage,
    this.mobileNo,
    this.gender,
    this.location,
    this.email,
    this.specializationId,
    this.specificationId,
    this.subspecificationId,
    this.about,
    this.servicesAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.isApprove,
  });

  Docter.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    docterImage = json['docter_image'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    location = json['location'];
    email = json['email'];
    specializationId = json['specialization_id'];
    specificationId = json['specification_id'];
    subspecificationId = json['subspecification_id'];
    about = json['about'];
    servicesAt = json['Services_at'];
    userId = json['UserId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApprove = json['is_approve'];
  }
  int? id;
  String? firstname;
  String? lastname;
  String? docterImage;
  String? mobileNo;
  String? gender;
  String? location;
  String? email;
  String? specializationId;
  String? specificationId;
  String? subspecificationId;
  String? about;
  String? servicesAt;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? isApprove;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['docter_image'] = docterImage;
    map['mobileNo'] = mobileNo;
    map['gender'] = gender;
    map['location'] = location;
    map['email'] = email;
    map['specialization_id'] = specializationId;
    map['specification_id'] = specificationId;
    map['subspecification_id'] = subspecificationId;
    map['about'] = about;
    map['Services_at'] = servicesAt;
    map['UserId'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_approve'] = isApprove;
    return map;
  }
}

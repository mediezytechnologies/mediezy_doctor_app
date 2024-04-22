class SignupModel {
  SignupModel({
      this.success, 
      this.docters, 
      this.code, 
      this.message,});

  SignupModel.fromJson(dynamic json) {
    success = json['success'];
    docters = json['Docters'] != null ? Docters.fromJson(json['Docters']) : null;
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  Docters? docters;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (docters != null) {
      map['Docters'] = docters?.toJson();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Docters {
  Docters({
      this.firstname, 
      this.lastname, 
      this.mobileNo, 
      this.email, 
      this.location, 
      this.specificationId, 
      this.subspecificationId, 
      this.specializationId, 
      this.about, 
      this.servicesAt, 
      this.gender, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Docters.fromJson(dynamic json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    location = json['location'];
    specificationId = json['specification_id'];
    subspecificationId = json['subspecification_id'];
    specializationId = json['specialization_id'];
    about = json['about'];
    servicesAt = json['Services_at'];
    gender = json['gender'];
    userId = json['UserId'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? firstname;
  String? lastname;
  String? mobileNo;
  String? email;
  dynamic location;
  dynamic specificationId;
  dynamic subspecificationId;
  dynamic specializationId;
  dynamic about;
  dynamic servicesAt;
  String? gender;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['mobileNo'] = mobileNo;
    map['email'] = email;
    map['location'] = location;
    map['specification_id'] = specificationId;
    map['subspecification_id'] = subspecificationId;
    map['specialization_id'] = specializationId;
    map['about'] = about;
    map['Services_at'] = servicesAt;
    map['gender'] = gender;
    map['UserId'] = userId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}
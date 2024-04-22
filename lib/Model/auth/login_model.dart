class LoginModel {
  LoginModel({
      this.doctor, 
      this.token, 
      this.role,});

  LoginModel.fromJson(dynamic json) {
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    token = json['token'];
    role = json['role'];
  }
  Doctor? doctor;
  String? token;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    map['token'] = token;
    map['role'] = role;
    return map;
  }

}

class Doctor {
  Doctor({
      this.id, 
      this.firstname, 
      this.email, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.userRole, 
      this.mobileNo, 
      this.secondname,});

  Doctor.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userRole = json['user_role'];
    mobileNo = json['mobileNo'];
    secondname = json['secondname'];
  }
  int? id;
  String? firstname;
  String? email;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? userRole;
  dynamic mobileNo;
  String? secondname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_role'] = userRole;
    map['mobileNo'] = mobileNo;
    map['secondname'] = secondname;
    return map;
  }

}
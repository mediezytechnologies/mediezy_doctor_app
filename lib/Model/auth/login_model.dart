class LoginModel {
  LoginModel({
    this.doctor,
    this.token,
    this.role,
  });

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
    this.age,
    this.dateofbirth,
    this.dob,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userRole,
    this.mobileNo,
    this.secondname,
    this.registrationStatus,
    this.providerName,
    this.providerId,
    this.fcmToken,
    this.mediezyDoctorId,
    this.doctorImage,
  });

  Doctor.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    email = json['email'];
    age = json['age'];
    dateofbirth = json['dateofbirth'];
    dob = json['dob'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userRole = json['user_role'];
    mobileNo = json['mobileNo'];
    secondname = json['secondname'];
    registrationStatus = json['registration_status'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    fcmToken = json['fcm_token'];
    mediezyDoctorId = json['mediezy_doctor_id'];
    doctorImage = json['docter_image'];
  }
  int? id;
  String? firstname;
  String? email;
  dynamic age;
  String? dateofbirth;
  dynamic dob;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  String? updatedAt;
  String? userRole;
  String? mobileNo;
  String? secondname;
  int? registrationStatus;
  dynamic providerName;
  dynamic providerId;
  dynamic fcmToken;
  String? mediezyDoctorId;
  String? doctorImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['email'] = email;
    map['age'] = age;
    map['dateofbirth'] = dateofbirth;
    map['dob'] = dob;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_role'] = userRole;
    map['mobileNo'] = mobileNo;
    map['secondname'] = secondname;
    map['registration_status'] = registrationStatus;
    map['provider_name'] = providerName;
    map['provider_id'] = providerId;
    map['fcm_token'] = fcmToken;
    map['fcm_token'] = mediezyDoctorId;
    map['fcm_token'] = doctorImage;
    return map;
  }
}

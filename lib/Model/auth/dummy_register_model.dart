class DummyRegisterModel {
  DummyRegisterModel({
      this.message, 
      this.doctor,});

  DummyRegisterModel.fromJson(dynamic json) {
    message = json['message'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }
  String? message;
  Doctor? doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    return map;
  }

}

class Doctor {
  Doctor({
      this.firstName, 
      this.lastName, 
      this.mobileNumber, 
      this.location, 
      this.email, 
      this.hospitalName, 
      this.specialization, 
      this.updatedAt, 
      this.createdAt, 
      this.doctorId, 
      this.doctorImageUrl,});

  Doctor.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    location = json['location'];
    email = json['email'];
    hospitalName = json['hospital_name'];
    specialization = json['specialization'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    doctorId = json['doctor_id '];
    doctorImageUrl = json['doctor_image_url'];
  }
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? location;
  String? email;
  String? hospitalName;
  String? specialization;
  String? updatedAt;
  String? createdAt;
  int? doctorId;
  dynamic doctorImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['mobile_number'] = mobileNumber;
    map['location'] = location;
    map['email'] = email;
    map['hospital_name'] = hospitalName;
    map['specialization'] = specialization;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['doctor_id '] = doctorId;
    map['doctor_image_url'] = doctorImageUrl;
    return map;
  }

}
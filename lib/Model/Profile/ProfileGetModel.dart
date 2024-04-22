class ProfileGetModel {
  ProfileGetModel({
      this.success, 
      this.doctorDetails, 
      this.code, 
      this.message,});

  ProfileGetModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['Doctor Details'] != null) {
      doctorDetails = [];
      json['Doctor Details'].forEach((v) {
        doctorDetails?.add(DoctorDetails.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  List<DoctorDetails>? doctorDetails;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (doctorDetails != null) {
      map['Doctor Details'] = doctorDetails?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class DoctorDetails {
  DoctorDetails({
      this.id, 
      this.mediezyDoctorId, 
      this.userId, 
      this.firstname, 
      this.secondname, 
      this.specialization, 
      this.docterImage, 
      this.about, 
      this.location, 
      this.gender, 
      this.emailID, 
      this.mobileNumber, 
      this.mainHospital, 
      this.specifications, 
      this.subspecifications, 
      this.clinics, 
      this.favoriteStatus,});

  DoctorDetails.fromJson(dynamic json) {
    id = json['id'];
    mediezyDoctorId = json['mediezy_doctor_id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    about = json['About'];
    location = json['Location'];
    gender = json['Gender'];
    emailID = json['emailID'];
    mobileNumber = json['Mobile Number'];
    mainHospital = json['MainHospital'];
    specifications = json['specifications'] != null ? json['specifications'].cast<String>() : [];
    subspecifications = json['subspecifications'] != null ? json['subspecifications'].cast<String>() : [];
    if (json['clinics'] != null) {
      clinics = [];
      json['clinics'].forEach((v) {
        clinics?.add(Clinics.fromJson(v));
      });
    }
    favoriteStatus = json['favoriteStatus'];
  }
  int? id;
  String? mediezyDoctorId;
  int? userId;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? about;
  String? location;
  String? gender;
  String? emailID;
  String? mobileNumber;
  String? mainHospital;
  List<String>? specifications;
  List<String>? subspecifications;
  List<Clinics>? clinics;
  int? favoriteStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mediezy_doctor_id'] = mediezyDoctorId;
    map['UserId'] = userId;
    map['firstname'] = firstname;
    map['secondname'] = secondname;
    map['Specialization'] = specialization;
    map['DocterImage'] = docterImage;
    map['About'] = about;
    map['Location'] = location;
    map['Gender'] = gender;
    map['emailID'] = emailID;
    map['Mobile Number'] = mobileNumber;
    map['MainHospital'] = mainHospital;
    map['specifications'] = specifications;
    map['subspecifications'] = subspecifications;
    if (clinics != null) {
      map['clinics'] = clinics?.map((v) => v.toJson()).toList();
    }
    map['favoriteStatus'] = favoriteStatus;
    return map;
  }

}

class Clinics {
  Clinics({
      this.clinicId, 
      this.clinicName, 
      this.clinicStartTime, 
      this.clinicEndTime, 
      this.clinicAddress, 
      this.clinicLocation, 
      this.clinicMainImage, 
      this.clinicDescription, 
      this.totalTokenCount, 
      this.availableTokenCount, 
      this.nextAvailableTokenTime,});

  Clinics.fromJson(dynamic json) {
    clinicId = json['clinic_id'];
    clinicName = json['clinic_name'];
    clinicStartTime = json['clinic_start_time'];
    clinicEndTime = json['clinic_end_time'];
    clinicAddress = json['clinic_address'];
    clinicLocation = json['clinic_location'];
    clinicMainImage = json['clinic_main_image'];
    clinicDescription = json['clinic_description'];
    totalTokenCount = json['total_token_Count'];
    availableTokenCount = json['available_token_count'];
    nextAvailableTokenTime = json['next_available_token_time'];
  }
  int? clinicId;
  String? clinicName;
  dynamic clinicStartTime;
  dynamic clinicEndTime;
  String? clinicAddress;
  String? clinicLocation;
  String? clinicMainImage;
  String? clinicDescription;
  int? totalTokenCount;
  int? availableTokenCount;
  dynamic nextAvailableTokenTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinic_id'] = clinicId;
    map['clinic_name'] = clinicName;
    map['clinic_start_time'] = clinicStartTime;
    map['clinic_end_time'] = clinicEndTime;
    map['clinic_address'] = clinicAddress;
    map['clinic_location'] = clinicLocation;
    map['clinic_main_image'] = clinicMainImage;
    map['clinic_description'] = clinicDescription;
    map['total_token_Count'] = totalTokenCount;
    map['available_token_count'] = availableTokenCount;
    map['next_available_token_time'] = nextAvailableTokenTime;
    return map;
  }

}
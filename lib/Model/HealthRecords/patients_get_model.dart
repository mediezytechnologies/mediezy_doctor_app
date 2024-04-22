class PatientsGetModel {
  PatientsGetModel({
      this.status, 
      this.patientData, 
      this.patientCount,});

  PatientsGetModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['patient_data'] != null) {
      patientData = [];
      json['patient_data'].forEach((v) {
        patientData?.add(PatientData.fromJson(v));
      });
    }
    patientCount = json['patient_count'];
  }
  bool? status;
  List<PatientData>? patientData;
  int? patientCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (patientData != null) {
      map['patient_data'] = patientData?.map((v) => v.toJson()).toList();
    }
    map['patient_count'] = patientCount;
    return map;
  }

}

class PatientData {
  PatientData({
      this.id, 
      this.userId, 
      this.firstname, 
      this.lastname, 
      this.gender, 
      this.age, 
      this.mediezyPatientId, 
      this.userImage,
      this.displayAge,
  });

  PatientData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    age = json['age'];
    mediezyPatientId = json['mediezy_patient_id'];
    userImage = json['user_image'];
    displayAge = json['displayAge'];
  }
  int? id;
  int? userId;
  String? firstname;
  dynamic lastname;
  String? gender;
  int? age;
  String? mediezyPatientId;
  dynamic userImage;
  String? displayAge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['UserId'] = userId;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['gender'] = gender;
    map['age'] = age;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['user_image'] = userImage;
    map['displayAge'] = displayAge;
    return map;
  }

}
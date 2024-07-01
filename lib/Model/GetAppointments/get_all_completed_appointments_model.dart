class GetAllCompletedAppointmentsModel {
  GetAllCompletedAppointmentsModel({
      this.success, 
      this.appointments, 
      this.code, 
      this.message,});

  GetAllCompletedAppointmentsModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['Appointments'] != null) {
      appointments = [];
      json['Appointments'].forEach((v) {
        appointments?.add(Appointments.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  List<Appointments>? appointments;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (appointments != null) {
      map['Appointments'] = appointments?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Appointments {
  Appointments({
      this.id, 
      this.patientId, 
      this.userId, 
      this.mediezyPatientId, 
      this.patientName, 
      this.tokenNumber, 
      this.gender, 
      this.userImage, 
      this.age, 
      this.displayAge, 
      this.scheduleType, 
      this.startingtime, 
      this.mainSymptoms, 
      this.otherSymptoms, 
      this.onlineStatus,});

  Appointments.fromJson(dynamic json) {
    id = json['id'];
    patientId = json['patient_id'];
    userId = json['user_id'];
    mediezyPatientId = json['mediezy_patient_id'];
    patientName = json['PatientName'];
    tokenNumber = json['TokenNumber'];
    gender = json['gender'];
    userImage = json['user_image'];
    age = json['Age'];
    displayAge = json['displayAge'];
    scheduleType = json['schedule_type'];
    startingtime = json['Startingtime'];
    mainSymptoms = json['main_symptoms'] != null ? MainSymptoms.fromJson(json['main_symptoms']) : null;
    if (json['other_symptoms'] != null) {
      otherSymptoms = [];
      json['other_symptoms'].forEach((v) {
        otherSymptoms?.add(OtherSymptoms.fromJson(v));
      });
    }
    onlineStatus = json['online_status'];
  }
  int? id;
  int? patientId;
  int? userId;
  String? mediezyPatientId;
  String? patientName;
  int? tokenNumber;
  String? gender;
  dynamic userImage;
  int? age;
  String? displayAge;
  String? scheduleType;
  String? startingtime;
  MainSymptoms? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  String? onlineStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['patient_id'] = patientId;
    map['user_id'] = userId;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['PatientName'] = patientName;
    map['TokenNumber'] = tokenNumber;
    map['gender'] = gender;
    map['user_image'] = userImage;
    map['Age'] = age;
    map['displayAge'] = displayAge;
    map['schedule_type'] = scheduleType;
    map['Startingtime'] = startingtime;
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.toJson();
    }
    if (otherSymptoms != null) {
      map['other_symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
    map['online_status'] = onlineStatus;
    return map;
  }

}

class OtherSymptoms {
  OtherSymptoms({
      this.symtoms,});

  OtherSymptoms.fromJson(dynamic json) {
    symtoms = json['symtoms'];
  }
  String? symtoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symtoms'] = symtoms;
    return map;
  }

}

class MainSymptoms {
  MainSymptoms({
      this.mainsymptoms,});

  MainSymptoms.fromJson(dynamic json) {
    mainsymptoms = json['Mainsymptoms'];
  }
  String? mainsymptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Mainsymptoms'] = mainsymptoms;
    return map;
  }

}
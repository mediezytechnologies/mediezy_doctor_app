class GetAllAppointmentsModel {
  GetAllAppointmentsModel({
      this.success, 
      this.appointments, 
      this.code, 
      this.message,});

  GetAllAppointmentsModel.fromJson(dynamic json) {
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
      this.mediezyPatientId, 
      this.patientName, 
      this.tokenNumber, 
      this.userImage, 
      this.age, 
      this.isReached, 
      this.scheduleType, 
      this.startingtime, 
      this.mainSymptoms, 
      this.otherSymptoms, 
      this.onlineStatus,});

  Appointments.fromJson(dynamic json) {
    id = json['id'];
    mediezyPatientId = json['mediezy_patient_id'];
    patientName = json['PatientName'];
    tokenNumber = json['TokenNumber'];
    userImage = json['user_image'];
    age = json['Age'];
    isReached = json['is_reached'];
    scheduleType = json['schedule_type'];
    startingtime = json['Startingtime'];
    if (json['main_symptoms'] != null) {
      mainSymptoms = [];
      json['main_symptoms'].forEach((v) {
        mainSymptoms?.add(MainSymptoms.fromJson(v));
      });
    }
    if (json['other_symptoms'] != null) {
      otherSymptoms = [];
      json['other_symptoms'].forEach((v) {
        otherSymptoms?.add(OtherSymptoms.fromJson(v));
      });
    }
    onlineStatus = json['online_status'];
  }
  int? id;
  String? mediezyPatientId;
  String? patientName;
  int? tokenNumber;
  dynamic userImage;
  String? age;
  dynamic isReached;
  int? scheduleType;
  String? startingtime;
  List<MainSymptoms>? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  String? onlineStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['PatientName'] = patientName;
    map['TokenNumber'] = tokenNumber;
    map['user_image'] = userImage;
    map['Age'] = age;
    map['is_reached'] = isReached;
    map['schedule_type'] = scheduleType;
    map['Startingtime'] = startingtime;
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.map((v) => v.toJson()).toList();
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
      this.id, 
      this.symtoms,});

  OtherSymptoms.fromJson(dynamic json) {
    id = json['id'];
    symtoms = json['symtoms'];
  }
  int? id;
  String? symtoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symtoms'] = symtoms;
    return map;
  }

}

class MainSymptoms {
  MainSymptoms({
      this.id, 
      this.symtoms,});

  MainSymptoms.fromJson(dynamic json) {
    id = json['id'];
    symtoms = json['symtoms'];
  }
  int? id;
  dynamic symtoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symtoms'] = symtoms;
    return map;
  }

}
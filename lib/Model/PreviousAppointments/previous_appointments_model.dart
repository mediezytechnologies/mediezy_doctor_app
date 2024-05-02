class PreviousAppointmentsModel {
  PreviousAppointmentsModel({
      this.success, 
      this.previousAppointments, 
      this.code, 
      this.message,});

  PreviousAppointmentsModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['Previous Appointments'] != null) {
      previousAppointments = [];
      json['Previous Appointments'].forEach((v) {
        previousAppointments?.add(PreviousAppointments.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  List<PreviousAppointments>? previousAppointments;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (previousAppointments != null) {
      map['Previous Appointments'] = previousAppointments?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class PreviousAppointments {
  PreviousAppointments({
      this.appointmentId, 
      this.date,
      this.mediezyPatientId,
      this.patientName, 
      this.tokenNumber, 
      this.patientId, 
      this.userImage, 
      this.age, 
      this.scheduleType, 
      this.startingtime, 
      this.mainSymptoms, 
      this.otherSymptoms,});

  PreviousAppointments.fromJson(dynamic json) {
    appointmentId = json['appointment_id'];
    date = json['date'];
    mediezyPatientId = json['mediezy_patient_id'];
    patientName = json['PatientName'];
    tokenNumber = json['TokenNumber'];
    patientId = json['patient_id'];
    userImage = json['user_image'];
    age = json['Age'];
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
  }
  int? appointmentId;
  String? date;
  String? mediezyPatientId;
  String? patientName;
  int? tokenNumber;
  int? patientId;
  String? userImage;
  int? age;
  String? scheduleType;
  String? startingtime;
  List<MainSymptoms>? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointment_id'] = appointmentId;
    map['date'] = appointmentId;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['PatientName'] = patientName;
    map['TokenNumber'] = tokenNumber;
    map['patient_id'] = patientId;
    map['user_image'] = userImage;
    map['Age'] = age;
    map['schedule_type'] = scheduleType;
    map['Startingtime'] = startingtime;
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.map((v) => v.toJson()).toList();
    }
    if (otherSymptoms != null) {
      map['other_symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
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
    mainsymptoms = json['mainsymptoms'];
  }
  String? mainsymptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mainsymptoms'] = mainsymptoms;
    return map;
  }

}
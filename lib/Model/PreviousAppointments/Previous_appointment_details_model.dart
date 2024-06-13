class PreviousAppointmentDetailsModel {
  PreviousAppointmentDetailsModel({
      this.status, 
      this.previousappointmentdetails,});

  PreviousAppointmentDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['previous appointment details'] != null) {
      previousappointmentdetails = [];
      json['previous appointment details'].forEach((v) {
        previousappointmentdetails?.add(PreviousAppointmentDetails.fromJson(v));
      });
    }
  }
  bool? status;
  List<PreviousAppointmentDetails>? previousappointmentdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (previousappointmentdetails != null) {
      map['previous appointment details'] = previousappointmentdetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PreviousAppointmentDetails {
  PreviousAppointmentDetails({
      this.tokenNumber, 
      this.date, 
      this.tokenStartTime, 
      this.checkoutTime, 
      this.symptomStartTime, 
      this.symptomFrequency, 
      this.prescriptionImage, 
      this.scheduleType, 
      this.notes, 
      this.patientName, 
      this.patientAge, 
      this.patientId, 
      this.patientUserId, 
      this.mainSymptoms, 
      this.otherSymptoms, 
      this.treatmentTaken, 
      this.surgeryDetails, 
      this.treatmentTakenDetails, 
      this.labName, 
      this.labTest, 
      this.scanName, 
      this.scanTest, 
      this.surgeryName, 
      this.mediezyPatientId, 
      this.patientUserImage, 
      this.vitals, 
      this.allergies, 
      this.doctorMedicines, 
      this.patientMedicines,});

  PreviousAppointmentDetails.fromJson(dynamic json) {
    tokenNumber = json['token_number'];
    date = json['date'];
    tokenStartTime = json['token_start_time'];
    checkoutTime = json['checkout_time'];
    symptomStartTime = json['symptom_start_time'];
    symptomFrequency = json['symptom_frequency'];
    prescriptionImage = json['prescription_image'];
    scheduleType = json['schedule_type'];
    notes = json['notes'];
    patientName = json['patient_name'];
    patientAge = json['patient_age'];
    patientId = json['patient_id'];
    patientUserId = json['patient_user_id'];
    mainSymptoms = json['main_symptoms'] != null ? MainSymptoms.fromJson(json['main_symptoms']) : null;
    if (json['other_symptoms'] != null) {
      otherSymptoms = [];
      json['other_symptoms'].forEach((v) {
        otherSymptoms?.add(OtherSymptoms.fromJson(v));
      });
    }
    treatmentTaken = json['treatment_taken'] != null ? json['treatment_taken'].cast<String>() : [];
    surgeryDetails = json['surgery_details'];
    treatmentTakenDetails = json['treatment_taken_details'];
    labName = json['lab_name'];
    labTest = json['lab_test'] != null ? json['lab_test'].cast<String>() : [];
    scanName = json['scan_name'];
    scanTest = json['scan_test'] != null ? json['scan_test'].cast<String>() : [];
    surgeryName = json['surgery_name'] != null ? json['surgery_name'].cast<String>() : [];
    mediezyPatientId = json['mediezy_patient_id'];
    patientUserImage = json['patient_user_image'];
    vitals = json['vitals'] != null ? Vitals.fromJson(json['vitals']) : null;
    if (json['allergies'] != null) {
      allergies = [];
      json['allergies'].forEach((v) {
        allergies?.add(Allergies.fromJson(v));
      });
    }
    if (json['doctor_medicines'] != null) {
      doctorMedicines = [];
      json['doctor_medicines'].forEach((v) {
        doctorMedicines?.add(DoctorMedicines.fromJson(v));
      });
    }
    if (json['patient_medicines'] != null) {
      patientMedicines = [];
      json['patient_medicines'].forEach((v) {
        patientMedicines?.add(PatientMedicines.fromJson(v));
      });
    }
  }
  int? tokenNumber;
  String? date;
  String? tokenStartTime;
  String? checkoutTime;
  String? symptomStartTime;
  String? symptomFrequency;
  dynamic prescriptionImage;
  String? scheduleType;
  String? notes;
  String? patientName;
  int? patientAge;
  int? patientId;
  int? patientUserId;
  MainSymptoms? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  List<String>? treatmentTaken;
  String? surgeryDetails;
  String? treatmentTakenDetails;
  String? labName;
  List<String>? labTest;
  String? scanName;
  List<String>? scanTest;
  List<String>? surgeryName;
  String? mediezyPatientId;
  String? patientUserImage;
  Vitals? vitals;
  List<Allergies>? allergies;
  List<DoctorMedicines>? doctorMedicines;
  List<PatientMedicines>? patientMedicines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_number'] = tokenNumber;
    map['date'] = date;
    map['token_start_time'] = tokenStartTime;
    map['checkout_time'] = checkoutTime;
    map['symptom_start_time'] = symptomStartTime;
    map['symptom_frequency'] = symptomFrequency;
    map['prescription_image'] = prescriptionImage;
    map['schedule_type'] = scheduleType;
    map['notes'] = notes;
    map['patient_name'] = patientName;
    map['patient_age'] = patientAge;
    map['patient_id'] = patientId;
    map['patient_user_id'] = patientUserId;
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.toJson();
    }
    if (otherSymptoms != null) {
      map['other_symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
    map['treatment_taken'] = treatmentTaken;
    map['surgery_details'] = surgeryDetails;
    map['treatment_taken_details'] = treatmentTakenDetails;
    map['lab_name'] = labName;
    map['lab_test'] = labTest;
    map['scan_name'] = scanName;
    map['scan_test'] = scanTest;
    map['surgery_name'] = surgeryName;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['patient_user_image'] = patientUserImage;
    if (vitals != null) {
      map['vitals'] = vitals?.toJson();
    }
    if (allergies != null) {
      map['allergies'] = allergies?.map((v) => v.toJson()).toList();
    }
    if (doctorMedicines != null) {
      map['doctor_medicines'] = doctorMedicines?.map((v) => v.toJson()).toList();
    }
    if (patientMedicines != null) {
      map['patient_medicines'] = patientMedicines?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PatientMedicines {
  PatientMedicines({
      this.medicineName, 
      this.illness,});

  PatientMedicines.fromJson(dynamic json) {
    medicineName = json['medicine_name'];
    illness = json['illness'];
  }
  String? medicineName;
  String? illness;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicine_name'] = medicineName;
    map['illness'] = illness;
    return map;
  }

}

class DoctorMedicines {
  DoctorMedicines({
      this.medicineName, 
      this.dosage, 
      this.noOfDays, 
      this.noon, 
      this.night, 
      this.evening, 
      this.morning, 
      this.type, 
      this.notes, 
      this.illness, 
      this.medicalStoreName, 
      this.interval, 
      this.timeSection,});

  DoctorMedicines.fromJson(dynamic json) {
    medicineName = json['medicine_name'];
    dosage = json['Dosage'];
    noOfDays = json['NoOfDays'];
    noon = json['Noon'];
    night = json['night'];
    evening = json['evening'];
    morning = json['morning'];
    type = json['type'];
    notes = json['notes'];
    illness = json['illness'];
    medicalStoreName = json['medical_store_name'];
    interval = json['interval'];
    timeSection = json['time_section'];
  }
  String? medicineName;
  String? dosage;
  String? noOfDays;
  int? noon;
  int? night;
  int? evening;
  int? morning;
  int? type;
  dynamic notes;
  dynamic illness;
  String? medicalStoreName;
  String? interval;
  String? timeSection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicine_name'] = medicineName;
    map['Dosage'] = dosage;
    map['NoOfDays'] = noOfDays;
    map['Noon'] = noon;
    map['night'] = night;
    map['evening'] = evening;
    map['morning'] = morning;
    map['type'] = type;
    map['notes'] = notes;
    map['illness'] = illness;
    map['medical_store_name'] = medicalStoreName;
    map['interval'] = interval;
    map['time_section'] = timeSection;
    return map;
  }

}

class Allergies {
  Allergies({
      this.allergyName, 
      this.allergyDetails,});

  Allergies.fromJson(dynamic json) {
    allergyName = json['allergy_name'];
    allergyDetails = json['allergy_details'];
  }
  String? allergyName;
  String? allergyDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allergy_name'] = allergyName;
    map['allergy_details'] = allergyDetails;
    return map;
  }

}

class Vitals {
  Vitals({
      this.height, 
      this.weight, 
      this.temperature, 
      this.spo2, 
      this.sys, 
      this.dia, 
      this.heartRate, 
      this.temperatureType,});

  Vitals.fromJson(dynamic json) {
    height = json['height'];
    weight = json['weight'];
    temperature = json['temperature'];
    spo2 = json['spo2'];
    sys = json['sys'];
    dia = json['dia'];
    heartRate = json['heart_rate'];
    temperatureType = json['temperature_type'];
  }
  String? height;
  String? weight;
  String? temperature;
  String? spo2;
  String? sys;
  String? dia;
  String? heartRate;
  String? temperatureType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = height;
    map['weight'] = weight;
    map['temperature'] = temperature;
    map['spo2'] = spo2;
    map['sys'] = sys;
    map['dia'] = dia;
    map['heart_rate'] = heartRate;
    map['temperature_type'] = temperatureType;
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
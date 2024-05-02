class GetCompletedAppointmentsHealthRecordModel {
  GetCompletedAppointmentsHealthRecordModel({
    this.status,
    this.appointmentDetails,
  });

  GetCompletedAppointmentsHealthRecordModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['appointment_details'] != null) {
      appointmentDetails = [];
      json['appointment_details'].forEach((v) {
        appointmentDetails?.add(AppointmentDetails.fromJson(v));
      });
    }
  }

  bool? status;
  List<AppointmentDetails>? appointmentDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (appointmentDetails != null) {
      map['appointment_details'] =
          appointmentDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AppointmentDetails {
  AppointmentDetails({
    this.tokenNumber,
    this.date,
    this.tokenStartTime,
    this.symptomStartTime,
    this.symptomFrequency,
    this.prescriptionImage,
    this.scheduleType,
    this.notes,
    this.patientName,
    this.patientAge,
    this.patientId,
    this.patientUserId,
    this.treatmentTaken,
    this.doctorImage,
    this.doctorName,
    this.clinicName,
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
    this.mainSymptoms,
    this.otherSymptoms,
  });

  AppointmentDetails.fromJson(dynamic json) {
    tokenNumber = json['token_number'];
    date = json['date'];
    tokenStartTime = json['token_start_time'];
    symptomStartTime = json['symptom_start_time'];
    symptomFrequency = json['symptom_frequency'];
    prescriptionImage = json['prescription_image'];
    scheduleType = json['schedule_type'];
    notes = json['notes'];
    patientName = json['patient_name'];
    patientAge = json['patient_age'];
    patientId = json['patient_id'];
    patientUserId = json['patient_user_id'];
    treatmentTaken = json['treatment_taken'];
    doctorImage = json['doctor_image'];
    doctorName = json['doctor_name'];
    clinicName = json['clinic_name'];
    labName = json['lab_name'];
    labTest = json['lab_test'];
    scanName = json['scan_name'];
    scanTest = json['scan_test'];
    surgeryName = json['surgery_name'];
    mediezyPatientId = json['mediezy_patient_id'];
    patientUserImage = json['patient_user_image'];
    if (json['vitals'] != null) {
      vitals = [];
      json['vitals'].forEach((v) {
        vitals?.add(Vitals.fromJson(v));
      });
    }
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
    mainSymptoms = json['main_symptoms'] != null
        ? MainSymptoms.fromJson(json['main_symptoms'])
        : null;
    if (json['other_symptoms'] != null) {
      otherSymptoms = [];
      json['other_symptoms'].forEach((v) {
        otherSymptoms?.add(OtherSymptoms.fromJson(v));
      });
    }
  }

  int? tokenNumber;
  String? date;
  String? tokenStartTime;
  String? symptomStartTime;
  String? symptomFrequency;
  String? prescriptionImage;
  String? scheduleType;
  String? notes;
  String? patientName;
  int? patientAge;
  int? patientId;
  int? patientUserId;
  String? treatmentTaken;
  String? doctorImage;
  String? doctorName;
  String? clinicName;
  String? labName;
  String? labTest;
  String? scanName;
  String? scanTest;
  String? surgeryName;
  String? mediezyPatientId;
  String? patientUserImage;
  List<Vitals>? vitals;
  List<Allergies>? allergies;
  List<DoctorMedicines>? doctorMedicines;
  MainSymptoms? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_number'] = tokenNumber;
    map['date'] = date;
    map['token_start_time'] = tokenStartTime;
    map['symptom_start_time'] = symptomStartTime;
    map['symptom_frequency'] = symptomFrequency;
    map['prescription_image'] = prescriptionImage;
    map['schedule_type'] = scheduleType;
    map['notes'] = notes;
    map['patient_name'] = patientName;
    map['patient_age'] = patientAge;
    map['patient_id'] = patientId;
    map['patient_user_id'] = patientUserId;
    map['treatment_taken'] = treatmentTaken;
    map['doctor_image'] = doctorImage;
    map['doctor_name'] = doctorName;
    map['clinic_name'] = clinicName;
    map['lab_name'] = labName;
    map['lab_test'] = labTest;
    map['scan_name'] = scanName;
    map['scan_test'] = scanTest;
    map['surgery_name'] = surgeryName;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['patient_user_image'] = patientUserImage;
    if (vitals != null) {
      map['vitals'] = vitals?.map((v) => v.toJson()).toList();
    }
    if (allergies != null) {
      map['allergies'] = allergies?.map((v) => v.toJson()).toList();
    }
    if (doctorMedicines != null) {
      map['doctor_medicines'] =
          doctorMedicines?.map((v) => v.toJson()).toList();
    }
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.toJson();
    }
    if (otherSymptoms != null) {
      map['other_symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OtherSymptoms {
  OtherSymptoms({
    this.symtoms,
  });

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
    this.mainsymptoms,
  });

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
    this.medicalStoreName,
  });

  DoctorMedicines.fromJson(dynamic json) {
    medicineName = json['medicine_name'];
    dosage = json['Dosage'];
    noOfDays = json['NoOfDays'];
    noon = json['Noon'];
    night = json['night'];
    evening = json['evening'];
    morning = json['morning'];
    type = json['type'];
    medicalStoreName = json['medical_store_name'];
  }

  String? medicineName;
  String? dosage;
  String? noOfDays;
  int? noon;
  int? night;
  int? evening;
  int? morning;
  int? type;
  dynamic medicalStoreName;

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
    map['medical_store_name'] = medicalStoreName;
    return map;
  }
}

class Allergies {
  Allergies({
    this.allergyName,
    this.allergyDetails,
  });

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
    this.temperatureType,
  });

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

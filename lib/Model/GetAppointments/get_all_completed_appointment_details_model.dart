class GetAllCompletedAppointmentDetailsModel {
  bool? status;
  List<AppointmentDetails>? appointmentDetails;

  GetAllCompletedAppointmentDetailsModel(
      {this.status, this.appointmentDetails});

  GetAllCompletedAppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['appointment_details'] != null) {
      appointmentDetails = <AppointmentDetails>[];
      json['appointment_details'].forEach((v) {
        appointmentDetails!.add(AppointmentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (appointmentDetails != null) {
      data['appointment_details'] =
          appointmentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentDetails {
  int? tokenNumber;
  String? date;
  String? tokenStartTime;
  String? checkoutTime;
  String? symptomStartTime;
  String? symptomFrequency;
  String? prescriptionImage;
  String? scheduleType;
  int? reviewAfter;
  String? notes;
  String? medicalShopName;
  String? patientName;
  int? patientAge;
  int? patientId;
  int? patientUserId;
  List<String>? treatmentTaken;
  String? treatmentTakenDetails;
  String? labName;
  List<String>? labTest;
  String? scanName;
  List<String>? scanTest;
  List<String>? surgeryName;
  String? surgeryDetails;
  String? mediezyPatientId;
  String? patientUserImage;
  Vitals? vitals;
  List<Allergies>? allergies;
  List<DoctorMedicines>? doctorMedicines;
  List<PatientMedicines>? patientMedicines;
  MainSymptoms? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;

  AppointmentDetails(
      {this.tokenNumber,
      this.date,
      this.tokenStartTime,
      this.checkoutTime,
      this.symptomStartTime,
      this.symptomFrequency,
      this.prescriptionImage,
      this.scheduleType,
      this.reviewAfter,
      this.notes,
      this.medicalShopName,
      this.patientName,
      this.patientAge,
      this.patientId,
      this.patientUserId,
      this.treatmentTaken,
      this.treatmentTakenDetails,
      this.labName,
      this.labTest,
      this.scanName,
      this.scanTest,
      this.surgeryName,
      this.surgeryDetails,
      this.mediezyPatientId,
      this.patientUserImage,
      this.vitals,
      this.allergies,
      this.doctorMedicines,
      this.patientMedicines,
      this.mainSymptoms,
      this.otherSymptoms});

  AppointmentDetails.fromJson(Map<String, dynamic> json) {
    tokenNumber = json['token_number'];
    date = json['date'];
    tokenStartTime = json['token_start_time'];
    checkoutTime = json['checkout_time'];
    symptomStartTime = json['symptom_start_time'];
    symptomFrequency = json['symptom_frequency'];
    prescriptionImage = json['prescription_image'];
    scheduleType = json['schedule_type'];
    reviewAfter = json['review_after'];
    notes = json['notes'];
    medicalShopName = json['medical_shop_name'];
    patientName = json['patient_name'];
    patientAge = json['patient_age'];
    patientId = json['patient_id'];
    patientUserId = json['patient_user_id'];
    treatmentTaken = json['treatment_taken'].cast<String>();
    treatmentTakenDetails = json['treatment_taken_details'];
    labName = json['lab_name'];
    labTest = json['lab_test'].cast<String>();
    scanName = json['scan_name'];
    scanTest = json['scan_test'].cast<String>();
    surgeryName = json['surgery_name'].cast<String>();
    surgeryDetails = json['surgery_details'];
    mediezyPatientId = json['mediezy_patient_id'];
    patientUserImage = json['patient_user_image'];
    vitals = json['vitals'] != null ? Vitals.fromJson(json['vitals']) : null;
    if (json['allergies'] != null) {
      allergies = <Allergies>[];
      json['allergies'].forEach((v) {
        allergies!.add(Allergies.fromJson(v));
      });
    }
    if (json['doctor_medicines'] != null) {
      doctorMedicines = <DoctorMedicines>[];
      json['doctor_medicines'].forEach((v) {
        doctorMedicines!.add(DoctorMedicines.fromJson(v));
      });
    }
    if (json['patient_medicines'] != null) {
      patientMedicines = <PatientMedicines>[];
      json['patient_medicines'].forEach((v) {
        patientMedicines!.add(PatientMedicines.fromJson(v));
      });
    }
    mainSymptoms = json['main_symptoms'] != null
        ? MainSymptoms.fromJson(json['main_symptoms'])
        : null;
    if (json['other_symptoms'] != null) {
      otherSymptoms = <OtherSymptoms>[];
      json['other_symptoms'].forEach((v) {
        otherSymptoms!.add(OtherSymptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_number'] = tokenNumber;
    data['date'] = date;
    data['token_start_time'] = tokenStartTime;
    data['checkout_time'] = checkoutTime;
    data['symptom_start_time'] = symptomStartTime;
    data['symptom_frequency'] = symptomFrequency;
    data['prescription_image'] = prescriptionImage;
    data['schedule_type'] = scheduleType;
    data['review_after'] = reviewAfter;
    data['notes'] = notes;
    data['medical_shop_name'] = medicalShopName;
    data['patient_name'] = patientName;
    data['patient_age'] = patientAge;
    data['patient_id'] = patientId;
    data['patient_user_id'] = patientUserId;
    data['treatment_taken'] = treatmentTaken;
    data['treatment_taken_details'] = treatmentTakenDetails;
    data['lab_name'] = labName;
    data['lab_test'] = labTest;
    data['scan_name'] = scanName;
    data['scan_test'] = scanTest;
    data['surgery_name'] = surgeryName;
    data['surgery_details'] = surgeryDetails;
    data['mediezy_patient_id'] = mediezyPatientId;
    data['patient_user_image'] = patientUserImage;
    if (vitals != null) {
      data['vitals'] = vitals!.toJson();
    }
    if (allergies != null) {
      data['allergies'] = allergies!.map((v) => v.toJson()).toList();
    }
    if (doctorMedicines != null) {
      data['doctor_medicines'] =
          doctorMedicines!.map((v) => v.toJson()).toList();
    }
    if (patientMedicines != null) {
      data['patient_medicines'] =
          patientMedicines!.map((v) => v.toJson()).toList();
    }
    if (mainSymptoms != null) {
      data['main_symptoms'] = mainSymptoms!.toJson();
    }
    if (otherSymptoms != null) {
      data['other_symptoms'] = otherSymptoms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vitals {
  String? height;
  String? weight;
  String? temperature;
  String? spo2;
  String? sys;
  String? dia;
  String? heartRate;
  String? temperatureType;

  Vitals(
      {this.height,
      this.weight,
      this.temperature,
      this.spo2,
      this.sys,
      this.dia,
      this.heartRate,
      this.temperatureType});

  Vitals.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    temperature = json['temperature'];
    spo2 = json['spo2'];
    sys = json['sys'];
    dia = json['dia'];
    heartRate = json['heart_rate'];
    temperatureType = json['temperature_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['temperature'] = temperature;
    data['spo2'] = spo2;
    data['sys'] = sys;
    data['dia'] = dia;
    data['heart_rate'] = heartRate;
    data['temperature_type'] = temperatureType;
    return data;
  }
}

class Allergies {
  String? allergyName;
  String? allergyDetails;

  Allergies({this.allergyName, this.allergyDetails});

  Allergies.fromJson(Map<String, dynamic> json) {
    allergyName = json['allergy_name'];
    allergyDetails = json['allergy_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allergy_name'] = allergyName;
    data['allergy_details'] = allergyDetails;
    return data;
  }
}

class DoctorMedicines {
  String? medicineName;
  String? dosage;
  String? noOfDays;
  int? noon;
  int? night;
  int? evening;
  int? morning;
  int? type;
  String? notes;
  String? illness;
  String? medicalStoreName;
  String? interval;
  String? timeSection;

  DoctorMedicines(
      {this.medicineName,
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
      this.timeSection});

  DoctorMedicines.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_name'] = medicineName;
    data['Dosage'] = dosage;
    data['NoOfDays'] = noOfDays;
    data['Noon'] = noon;
    data['night'] = night;
    data['evening'] = evening;
    data['morning'] = morning;
    data['type'] = type;
    data['notes'] = notes;
    data['illness'] = illness;
    data['medical_store_name'] = medicalStoreName;
    data['interval'] = interval;
    data['time_section'] = timeSection;
    return data;
  }
}

class PatientMedicines {
  String? medicineName;
  String? illness;

  PatientMedicines({this.medicineName, this.illness});

  PatientMedicines.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicine_name'];
    illness = json['illness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_name'] = medicineName;
    data['illness'] = illness;
    return data;
  }
}

class MainSymptoms {
  String? mainsymptoms;

  MainSymptoms({this.mainsymptoms});

  MainSymptoms.fromJson(Map<String, dynamic> json) {
    mainsymptoms = json['Mainsymptoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Mainsymptoms'] = mainsymptoms;
    return data;
  }
}

class OtherSymptoms {
  String? symtoms;

  OtherSymptoms({this.symtoms});

  OtherSymptoms.fromJson(Map<String, dynamic> json) {
    symtoms = json['symtoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symtoms'] = symtoms;
    return data;
  }
}

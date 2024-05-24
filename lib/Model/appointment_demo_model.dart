class AppointmentDemoModel {
  AppointmentDemoModel({
      this.status, 
      this.bookingData, 
      this.message,});

  AppointmentDemoModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['booking_data'] != null) {
      bookingData = [];
      json['booking_data'].forEach((v) {
        bookingData?.add(BookingData.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<BookingData>? bookingData;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (bookingData != null) {
      map['booking_data'] = bookingData?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class BookingData {
  BookingData({
      this.isCheckedout, 
      this.isCheckedin, 
      this.tokenId, 
      this.tokenBookingId, 
      this.tokenNumber, 
      this.doctorId, 
      this.bookedPersonId, 
      this.patientName, 
      this.age, 
      this.date, 
      this.tokenTime, 
      this.appoinmentforId, 
      this.whenitstart, 
      this.whenitcomes, 
      this.attachment, 
      this.notes, 
      this.clinicId, 
      this.newDoctorId, 
      this.patientId, 
      this.patient, 
      this.mainSymptoms, 
      this.otherSymptoms, 
      this.medicine, 
      this.vitals, 
      this.onlineStatus, 
      this.treatmentTaken, 
      this.surgeryName, 
      this.surgeryDetails, 
      this.treatmentTakenDetails, 
      this.allergiesDetails, 
      this.doctorAppBooking, 
      this.medicineDetails, 
      this.mediezyPatientId, 
      this.userImage, 
      this.firstIndexStatus,});

  BookingData.fromJson(dynamic json) {
    isCheckedout = json['is_checkedout'];
    isCheckedin = json['is_checkedin'];
    tokenId = json['token_id'];
    tokenBookingId = json['token_booking_id'];
    tokenNumber = json['TokenNumber'];
    doctorId = json['doctor_id'];
    bookedPersonId = json['BookedPerson_id'];
    patientName = json['PatientName'];
    age = json['age'];
    date = json['date'];
    tokenTime = json['TokenTime'];
    appoinmentforId = json['Appoinmentfor_id'];
    whenitstart = json['whenitstart'];
    whenitcomes = json['whenitcomes'];
    attachment = json['attachment'];
    notes = json['notes'];
    clinicId = json['clinic_id'];
    newDoctorId = json['newDoctorId'];
    patientId = json['patient_id'];
    patient = json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    if (json['Main_Symptoms'] != null) {
      mainSymptoms = [];
      json['Main_Symptoms'].forEach((v) {
        mainSymptoms?.add(MainSymptoms.fromJson(v));
      });
    }
    if (json['Other_Symptoms'] != null) {
      otherSymptoms = [];
      json['Other_Symptoms'].forEach((v) {
        otherSymptoms?.add(OtherSymptoms.fromJson(v));
      });
    }
    if (json['medicine'] != null) {
      medicine = [];
      json['medicine'].forEach((v) {
        medicine?.add(Medicine.fromJson(v));
      });
    }
    vitals = json['vitals'] != null ? Vitals.fromJson(json['vitals']) : null;
    onlineStatus = json['online_status'];
    treatmentTaken = json['treatment_taken'] != null ? json['treatment_taken'].cast<String>() : [];
    surgeryName = json['surgery_name'] != null ? json['surgery_name'].cast<String>() : [];
    surgeryDetails = json['surgery_details'];
    treatmentTakenDetails = json['treatment_taken_details'];
    if (json['allergies_details'] != null) {
      allergiesDetails = [];
      json['allergies_details'].forEach((v) {
        allergiesDetails?.add(AllergiesDetails.fromJson(v));
      });
    }
    doctorAppBooking = json['doctor_app_booking'];
    if (json['medicine_details'] != null) {
      medicineDetails = [];
      json['medicine_details'].forEach((v) {
        medicineDetails?.add(MedicineDetails.fromJson(v));
      });
    }
    mediezyPatientId = json['mediezy_patient_id'];
    userImage = json['user_image'];
    firstIndexStatus = json['first_index_status'];
  }
  int? isCheckedout;
  int? isCheckedin;
  int? tokenId;
  int? tokenBookingId;
  String? tokenNumber;
  int? doctorId;
  int? bookedPersonId;
  String? patientName;
  String? age;
  String? date;
  String? tokenTime;
  String? appoinmentforId;
  String? whenitstart;
  String? whenitcomes;
  dynamic attachment;
  dynamic notes;
  int? clinicId;
  int? newDoctorId;
  int? patientId;
  Patient? patient;
  List<MainSymptoms>? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  List<Medicine>? medicine;
  Vitals? vitals;
  String? onlineStatus;
  List<String>? treatmentTaken;
  List<String>? surgeryName;
  String? surgeryDetails;
  String? treatmentTakenDetails;
  List<AllergiesDetails>? allergiesDetails;
  bool? doctorAppBooking;
  List<MedicineDetails>? medicineDetails;
  String? mediezyPatientId;
  String? userImage;
  int? firstIndexStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_checkedout'] = isCheckedout;
    map['is_checkedin'] = isCheckedin;
    map['token_id'] = tokenId;
    map['token_booking_id'] = tokenBookingId;
    map['TokenNumber'] = tokenNumber;
    map['doctor_id'] = doctorId;
    map['BookedPerson_id'] = bookedPersonId;
    map['PatientName'] = patientName;
    map['age'] = age;
    map['date'] = date;
    map['TokenTime'] = tokenTime;
    map['Appoinmentfor_id'] = appoinmentforId;
    map['whenitstart'] = whenitstart;
    map['whenitcomes'] = whenitcomes;
    map['attachment'] = attachment;
    map['notes'] = notes;
    map['clinic_id'] = clinicId;
    map['newDoctorId'] = newDoctorId;
    map['patient_id'] = patientId;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    if (mainSymptoms != null) {
      map['Main_Symptoms'] = mainSymptoms?.map((v) => v.toJson()).toList();
    }
    if (otherSymptoms != null) {
      map['Other_Symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
    if (medicine != null) {
      map['medicine'] = medicine?.map((v) => v.toJson()).toList();
    }
    if (vitals != null) {
      map['vitals'] = vitals?.toJson();
    }
    map['online_status'] = onlineStatus;
    map['treatment_taken'] = treatmentTaken;
    map['surgery_name'] = surgeryName;
    map['surgery_details'] = surgeryDetails;
    map['treatment_taken_details'] = treatmentTakenDetails;
    if (allergiesDetails != null) {
      map['allergies_details'] = allergiesDetails?.map((v) => v.toJson()).toList();
    }
    map['doctor_app_booking'] = doctorAppBooking;
    if (medicineDetails != null) {
      map['medicine_details'] = medicineDetails?.map((v) => v.toJson()).toList();
    }
    map['mediezy_patient_id'] = mediezyPatientId;
    map['user_image'] = userImage;
    map['first_index_status'] = firstIndexStatus;
    return map;
  }

}

class MedicineDetails {
  MedicineDetails({
      this.medicineName, 
      this.illness,});

  MedicineDetails.fromJson(dynamic json) {
    medicineName = json['medicine_name'];
    illness = json['illness'];
  }
  String? medicineName;
  dynamic illness;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicine_name'] = medicineName;
    map['illness'] = illness;
    return map;
  }

}

class AllergiesDetails {
  AllergiesDetails({
      this.allergyId, 
      this.allergyName, 
      this.allergyDetails,});

  AllergiesDetails.fromJson(dynamic json) {
    allergyId = json['allergy_id'];
    allergyName = json['allergy_name'];
    allergyDetails = json['allergy_details'];
  }
  int? allergyId;
  String? allergyName;
  String? allergyDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allergy_id'] = allergyId;
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
      this.temperatureType, 
      this.spo2, 
      this.sys, 
      this.dia, 
      this.heartRate,});

  Vitals.fromJson(dynamic json) {
    height = json['height'];
    weight = json['weight'];
    temperature = json['temperature'];
    temperatureType = json['temperature_type'];
    spo2 = json['spo2'];
    sys = json['sys'];
    dia = json['dia'];
    heartRate = json['heart_rate'];
  }
  String? height;
  String? weight;
  String? temperature;
  String? temperatureType;
  String? spo2;
  String? sys;
  String? dia;
  String? heartRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = height;
    map['weight'] = weight;
    map['temperature'] = temperature;
    map['temperature_type'] = temperatureType;
    map['spo2'] = spo2;
    map['sys'] = sys;
    map['dia'] = dia;
    map['heart_rate'] = heartRate;
    return map;
  }

}

class Medicine {
  Medicine({
      this.id, 
      this.mediezyDoctorId, 
      this.userId, 
      this.docterId, 
      this.patientId, 
      this.medicalShopId, 
      this.medicineId, 
      this.medicineName, 
      this.dosage, 
      this.interval, 
      this.timeSection, 
      this.noOfDays, 
      this.noon, 
      this.night, 
      this.createdAt, 
      this.updatedAt, 
      this.tokenId, 
      this.morning, 
      this.type, 
      this.notes, 
      this.illness, 
      this.evening, 
      this.tokenNumber, 
      this.medicineType,});

  Medicine.fromJson(dynamic json) {
    id = json['id'];
    mediezyDoctorId = json['mediezy_doctor_id'];
    userId = json['user_id'];
    docterId = json['docter_id'];
    patientId = json['patient_id'];
    medicalShopId = json['medical_shop_id'];
    medicineId = json['medicine_id'];
    medicineName = json['medicineName'];
    dosage = json['Dosage'];
    interval = json['interval'];
    timeSection = json['time_section'];
    noOfDays = json['NoOfDays'];
    noon = json['Noon'];
    night = json['night'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tokenId = json['token_id'];
    morning = json['morning'];
    type = json['type'];
    notes = json['notes'];
    illness = json['illness'];
    evening = json['evening'];
    tokenNumber = json['token_number'];
    medicineType = json['medicine_type'];
  }
  int? id;
  dynamic mediezyDoctorId;
  int? userId;
  int? docterId;
  int? patientId;
  dynamic medicalShopId;
  dynamic medicineId;
  String? medicineName;
  String? dosage;
  String? interval;
  String? timeSection;
  String? noOfDays;
  int? noon;
  int? night;
  String? createdAt;
  String? updatedAt;
  int? tokenId;
  int? morning;
  int? type;
  dynamic notes;
  dynamic illness;
  int? evening;
  int? tokenNumber;
  int? medicineType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mediezy_doctor_id'] = mediezyDoctorId;
    map['user_id'] = userId;
    map['docter_id'] = docterId;
    map['patient_id'] = patientId;
    map['medical_shop_id'] = medicalShopId;
    map['medicine_id'] = medicineId;
    map['medicineName'] = medicineName;
    map['Dosage'] = dosage;
    map['interval'] = interval;
    map['time_section'] = timeSection;
    map['NoOfDays'] = noOfDays;
    map['Noon'] = noon;
    map['night'] = night;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['token_id'] = tokenId;
    map['morning'] = morning;
    map['type'] = type;
    map['notes'] = notes;
    map['illness'] = illness;
    map['evening'] = evening;
    map['token_number'] = tokenNumber;
    map['medicine_type'] = medicineType;
    return map;
  }

}

class OtherSymptoms {
  OtherSymptoms({
      this.id, 
      this.name,});

  OtherSymptoms.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class MainSymptoms {
  MainSymptoms({
      this.id, 
      this.name,});

  MainSymptoms.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class Patient {
  Patient({
      this.dateofbirth, 
      this.age,});

  Patient.fromJson(dynamic json) {
    dateofbirth = json['dateofbirth'];
    age = json['age'];
  }
  String? dateofbirth;
  String? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateofbirth'] = dateofbirth;
    map['age'] = age;
    return map;
  }

}
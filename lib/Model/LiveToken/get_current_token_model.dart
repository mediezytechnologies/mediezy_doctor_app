class GetCurrentTokenModel {
  GetCurrentTokenModel({
      this.message, 
      this.tokens,});

  GetCurrentTokenModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['tokens'] != null) {
      tokens = [];
      json['tokens'].forEach((v) {
        tokens?.add(Tokens.fromJson(v));
      });
    }
  }
  String? message;
  List<Tokens>? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (tokens != null) {
      map['tokens'] = tokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Tokens {
  Tokens({
      this.id, 
      this.bookedPersonId, 
      this.doctorId, 
      this.patientName, 
      this.gender, 
      this.age, 
      this.mobileNo, 
      this.appoinmentforId, 
      this.date, 
      this.tokenNumber, 
      this.bookingtime, 
      this.isCheckIn, 
      this.isCompleted, 
      this.isCanceled, 
      this.whenitstart, 
      this.whenitcomes, 
      this.regularmedicine, 
      this.patientId, 
      this.clinicId, 
      this.newTokenId, 
      this.scheduleType, 
      this.isReached, 
      this.rescheduleType, 
      this.height, 
      this.weight, 
      this.temperature, 
      this.spo2, 
      this.sys, 
      this.dia, 
      this.heartRate, 
      this.temperatureType, 
      this.labtestId, 
      this.scanTest, 
      this.scanId, 
      this.scantestId, 
      this.mainSymptoms, 
      this.otherSymptoms, 
      this.medicine, 
      this.patientData, 
      this.tokenTime, 
      this.mediezyPatientId, 
      this.userImage, 
      this.displayAge, 
      this.firstIndexStatus,});

  Tokens.fromJson(dynamic json) {
    id = json['id'];
    bookedPersonId = json['BookedPerson_id'];
    doctorId = json['doctor_id'];
    patientName = json['PatientName'];
    gender = json['gender'];
    age = json['age'];
    mobileNo = json['MobileNo'];
    appoinmentforId = json['Appoinmentfor_id'];
    date = json['date'];
    tokenNumber = json['TokenNumber'];
    bookingtime = json['Bookingtime'];
    isCheckIn = json['Is_checkIn'];
    isCompleted = json['Is_completed'];
    isCanceled = json['Is_canceled'];
    whenitstart = json['whenitstart'];
    whenitcomes = json['whenitcomes'];
    regularmedicine = json['regularmedicine'];
    patientId = json['patient_id'];
    clinicId = json['clinic_id'];
    newTokenId = json['new_token_id'];
    scheduleType = json['schedule_type'];
    isReached = json['is_reached'];
    rescheduleType = json['reschedule_type'];
    height = json['height'];
    weight = json['weight'];
    temperature = json['temperature'];
    spo2 = json['spo2'];
    sys = json['sys'];
    dia = json['dia'];
    heartRate = json['heart_rate'];
    temperatureType = json['temperature_type'];
    labtestId = json['labtest_id'];
    scanTest = json['scan_test'];
    scanId = json['scan_id'];
    scantestId = json['scantest_id'];
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
    if (json['medicine'] != null) {
      medicine = [];
      json['medicine'].forEach((v) {
        medicine?.add(Medicine.fromJson(v));
      });
    }
    patientData = json['patient_data'] != null ? PatientData.fromJson(json['patient_data']) : null;
    tokenTime = json['TokenTime'];
    mediezyPatientId = json['mediezy_patient_id'];
    userImage = json['user_image'];
    displayAge = json['displayAge'];
    firstIndexStatus = json['first_index_status'];
  }
  int? id;
  int? bookedPersonId;
  int? doctorId;
  String? patientName;
  String? gender;
  String? age;
  String? mobileNo;
  String? appoinmentforId;
  String? date;
  String? tokenNumber;
  String? bookingtime;
  int? isCheckIn;
  int? isCompleted;
  int? isCanceled;
  String? whenitstart;
  String? whenitcomes;
  dynamic regularmedicine;
  int? patientId;
  int? clinicId;
  int? newTokenId;
  int? scheduleType;
  dynamic isReached;
  int? rescheduleType;
  String? height;
  String? weight;
  String? temperature;
  String? spo2;
  String? sys;
  String? dia;
  String? heartRate;
  String? temperatureType;
  String? labtestId;
  String? scanTest;
  int? scanId;
  String? scantestId;
  List<MainSymptoms>? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  List<Medicine>? medicine;
  PatientData? patientData;
  String? tokenTime;
  String? mediezyPatientId;
  String? userImage;
  String? displayAge;
  int? firstIndexStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['BookedPerson_id'] = bookedPersonId;
    map['doctor_id'] = doctorId;
    map['PatientName'] = patientName;
    map['gender'] = gender;
    map['age'] = age;
    map['MobileNo'] = mobileNo;
    map['Appoinmentfor_id'] = appoinmentforId;
    map['date'] = date;
    map['TokenNumber'] = tokenNumber;
    map['Bookingtime'] = bookingtime;
    map['Is_checkIn'] = isCheckIn;
    map['Is_completed'] = isCompleted;
    map['Is_canceled'] = isCanceled;
    map['whenitstart'] = whenitstart;
    map['whenitcomes'] = whenitcomes;
    map['regularmedicine'] = regularmedicine;
    map['patient_id'] = patientId;
    map['clinic_id'] = clinicId;
    map['new_token_id'] = newTokenId;
    map['schedule_type'] = scheduleType;
    map['is_reached'] = isReached;
    map['reschedule_type'] = rescheduleType;
    map['height'] = height;
    map['weight'] = weight;
    map['temperature'] = temperature;
    map['spo2'] = spo2;
    map['sys'] = sys;
    map['dia'] = dia;
    map['heart_rate'] = heartRate;
    map['temperature_type'] = temperatureType;
    map['labtest_id'] = labtestId;
    map['scan_test'] = scanTest;
    map['scan_id'] = scanId;
    map['scantest_id'] = scantestId;
    if (mainSymptoms != null) {
      map['main_symptoms'] = mainSymptoms?.map((v) => v.toJson()).toList();
    }
    if (otherSymptoms != null) {
      map['other_symptoms'] = otherSymptoms?.map((v) => v.toJson()).toList();
    }
    if (medicine != null) {
      map['medicine'] = medicine?.map((v) => v.toJson()).toList();
    }
    if (patientData != null) {
      map['patient_data'] = patientData?.toJson();
    }
    map['TokenTime'] = tokenTime;
    map['mediezy_patient_id'] = mediezyPatientId;
    map['user_image'] = userImage;
    map['displayAge'] = displayAge;
    map['first_index_status'] = firstIndexStatus;
    return map;
  }

}

class PatientData {
  PatientData({
      this.labName, 
      this.medicalShopName, 
      this.notes, 
      this.prescriptionImage, 
      this.reviewAfter, 
      this.labtest, 
      this.scanTest, 
      this.scanName,});

  PatientData.fromJson(dynamic json) {
    labName = json['lab_name'];
    medicalShopName = json['medical_shop_name'];
    notes = json['notes'];
    prescriptionImage = json['prescription_image'];
    reviewAfter = json['review_after'];
    labtest = json['labtest'] != null ? json['labtest'].cast<String>() : [];
    scanTest = json['scan_test'] != null ? json['scan_test'].cast<String>() : [];
    scanName = json['scan_name'];
  }
  String? labName;
  String? medicalShopName;
  String? notes;
  dynamic prescriptionImage;
  int? reviewAfter;
  List<String>? labtest;
  List<String>? scanTest;
  String? scanName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lab_name'] = labName;
    map['medical_shop_name'] = medicalShopName;
    map['notes'] = notes;
    map['prescription_image'] = prescriptionImage;
    map['review_after'] = reviewAfter;
    map['labtest'] = labtest;
    map['scan_test'] = scanTest;
    map['scan_name'] = scanName;
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
  int? medicalShopId;
  int? medicineId;
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
      this.mainsymptoms,});

  MainSymptoms.fromJson(dynamic json) {
    id = json['id'];
    mainsymptoms = json['Mainsymptoms'];
  }
  int? id;
  String? mainsymptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Mainsymptoms'] = mainsymptoms;
    return map;
  }

}
class PreviousAppointmentsModel {
  bool? success;
  List<PreviousAppointments>? previousAppointments;
  int? code;
  String? message;

  PreviousAppointmentsModel(
      {this.success, this.previousAppointments, this.code, this.message});

  PreviousAppointmentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Previous Appointments'] != null) {
      previousAppointments = <PreviousAppointments>[];
      json['Previous Appointments'].forEach((v) {
        previousAppointments!.add(PreviousAppointments.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (previousAppointments != null) {
      data['Previous Appointments'] =
          previousAppointments!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class PreviousAppointments {
  int? id;
  int? bookedPersonId;
  int? doctorId;
  String? patientName;
  String? gender;
  String? age;
  String? mobileNo;
  String? date;
  String? tokenNumber;
  String? tokenTime;
  String? bookingtime;
  String? whenitstart;
  String? whenitcomes;
  String? regularmedicine;
  String? amount;
  String? paymentmethod;
  int? patientId;
  String? attachment;
  int? clinicId;
  String? notes;
  String? endTokenTime;
  int? labId;
  String? labtest;
  int? medicalshopId;
  String? prescriptionImage;
  int? reviewAfter;
  String? reviewdate;
  String? laboratoryName;
  String? medicalshopName;
  List<Appoinmentfor1>? appoinmentfor1;
  List<Appoinmentfor2>? appoinmentfor2;
  PatientDetails? patientDetails;
  List<Medicines>? medicines;

  PreviousAppointments(
      {this.id,
        this.bookedPersonId,
        this.doctorId,
        this.patientName,
        this.gender,
        this.age,
        this.mobileNo,
        this.date,
        this.tokenNumber,
        this.tokenTime,
        this.bookingtime,
        this.whenitstart,
        this.whenitcomes,
        this.regularmedicine,
        this.amount,
        this.paymentmethod,
        this.patientId,
        this.attachment,
        this.clinicId,
        this.notes,
        this.endTokenTime,
        this.labId,
        this.labtest,
        this.medicalshopId,
        this.prescriptionImage,
        this.reviewAfter,
        this.reviewdate,
        this.laboratoryName,
        this.medicalshopName,
        this.appoinmentfor1,
        this.appoinmentfor2,
        this.patientDetails,
        this.medicines});

  PreviousAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookedPersonId = json['BookedPerson_id'];
    doctorId = json['doctor_id'];
    patientName = json['PatientName'];
    gender = json['gender'];
    age = json['age'];
    mobileNo = json['MobileNo'];
    date = json['date'];
    tokenNumber = json['TokenNumber'];
    tokenTime = json['TokenTime'];
    bookingtime = json['Bookingtime'];
    whenitstart = json['whenitstart'];
    whenitcomes = json['whenitcomes'];
    regularmedicine = json['regularmedicine'];
    amount = json['amount'];
    paymentmethod = json['paymentmethod'];
    patientId = json['patient_id'];
    attachment = json['attachment'];
    clinicId = json['clinic_id'];
    notes = json['notes'];
    endTokenTime = json['EndTokenTime'];
    labId = json['lab_id'];
    labtest = json['labtest'];
    medicalshopId = json['medicalshop_id'];
    prescriptionImage = json['prescription_image'];
    reviewAfter = json['ReviewAfter'];
    reviewdate = json['Reviewdate'];
    laboratoryName = json['laboratory_name'];
    medicalshopName = json['medicalshop_name'];
    if (json['Appoinmentfor1'] != null) {
      appoinmentfor1 = <Appoinmentfor1>[];
      json['Appoinmentfor1'].forEach((v) {
        appoinmentfor1!.add(Appoinmentfor1.fromJson(v));
      });
    }
    if (json['Appoinmentfor2'] != null) {
      appoinmentfor2 = <Appoinmentfor2>[];
      json['Appoinmentfor2'].forEach((v) {
        appoinmentfor2!.add(Appoinmentfor2.fromJson(v));
      });
    }
    patientDetails = json['patient_details'] != null
        ? PatientDetails.fromJson(json['patient_details'])
        : null;
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['BookedPerson_id'] = bookedPersonId;
    data['doctor_id'] = doctorId;
    data['PatientName'] = patientName;
    data['gender'] = gender;
    data['age'] = age;
    data['MobileNo'] = mobileNo;
    data['date'] = date;
    data['TokenNumber'] = tokenNumber;
    data['TokenTime'] = tokenTime;
    data['Bookingtime'] = bookingtime;
    data['whenitstart'] = whenitstart;
    data['whenitcomes'] = whenitcomes;
    data['regularmedicine'] = regularmedicine;
    data['amount'] = amount;
    data['paymentmethod'] = paymentmethod;
    data['patient_id'] = patientId;
    data['attachment'] = attachment;
    data['clinic_id'] = clinicId;
    data['notes'] = notes;
    data['EndTokenTime'] = endTokenTime;
    data['lab_id'] = labId;
    data['labtest'] = labtest;
    data['medicalshop_id'] = medicalshopId;
    data['prescription_image'] = prescriptionImage;
    data['ReviewAfter'] = reviewAfter;
    data['Reviewdate'] = reviewdate;
    data['laboratory_name'] = laboratoryName;
    data['medicalshop_name'] = medicalshopName;
    if (appoinmentfor1 != null) {
      data['Appoinmentfor1'] =
          appoinmentfor1!.map((v) => v.toJson()).toList();
    }
    if (appoinmentfor2 != null) {
      data['Appoinmentfor2'] =
          appoinmentfor2!.map((v) => v.toJson()).toList();
    }
    if (patientDetails != null) {
      data['patient_details'] = patientDetails!.toJson();
    }
    if (medicines != null) {
      data['medicines'] = medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appoinmentfor1 {
  String? symtoms;

  Appoinmentfor1({this.symtoms});

  Appoinmentfor1.fromJson(Map<String, dynamic> json) {
    symtoms = json['symtoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symtoms'] = symtoms;
    return data;
  }
}

class Appoinmentfor2 {
  String? symtoms;

  Appoinmentfor2({this.symtoms});

  Appoinmentfor2.fromJson(Map<String, dynamic> json) {
    symtoms = json['symtoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symtoms'] = symtoms;
    return data;
  }
}

class PatientDetails {
  int? id;
  int? userId;

  PatientDetails({this.id, this.userId});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    return data;
  }
}

class Medicines {
  int? id;
  int? userId;
  int? docterId;
  String? medicineName;
  String? dosage;
  String? noOfDays;
  int? noon;
  int? night;
  String? createdAt;
  String? updatedAt;
  int? tokenId;
  int? morning;
  int? type;
  String? notes;

  Medicines(
      {this.id,
        this.userId,
        this.docterId,
        this.medicineName,
        this.dosage,
        this.noOfDays,
        this.noon,
        this.night,
        this.createdAt,
        this.updatedAt,
        this.tokenId,
        this.morning,
        this.type,
        this.notes});

  Medicines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    docterId = json['docter_id'];
    medicineName = json['medicineName'];
    dosage = json['Dosage'];
    noOfDays = json['NoOfDays'];
    noon = json['Noon'];
    night = json['night'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tokenId = json['token_id'];
    morning = json['morning'];
    type = json['type'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['docter_id'] = docterId;
    data['medicineName'] = medicineName;
    data['Dosage'] = dosage;
    data['NoOfDays'] = noOfDays;
    data['Noon'] = noon;
    data['night'] = night;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token_id'] = tokenId;
    data['morning'] = morning;
    data['type'] = type;
    data['notes'] = notes;
    return data;
  }
}
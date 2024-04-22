class GetPrescriptionViewModel {
  GetPrescriptionViewModel({
      this.status, 
      this.prescriptions,});

  GetPrescriptionViewModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['prescriptions'] != null) {
      prescriptions = [];
      json['prescriptions'].forEach((v) {
        prescriptions?.add(Prescriptions.fromJson(v));
      });
    }
  }
  bool? status;
  List<Prescriptions>? prescriptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (prescriptions != null) {
      map['prescriptions'] = prescriptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Prescriptions {
  Prescriptions({
      this.id, 
      this.userId, 
      this.status, 
      this.createdAt, 
      this.documentPath, 
      this.patientPrescription,});

  Prescriptions.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    documentPath = json['document_path'];
    if (json['patient_prescription'] != null) {
      patientPrescription = [];
      json['patient_prescription'].forEach((v) {
        patientPrescription?.add(PatientPrescription.fromJson(v));
      });
    }
  }
  int? id;
  int? userId;
  int? status;
  String? createdAt;
  String? documentPath;
  List<PatientPrescription>? patientPrescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['document_path'] = documentPath;
    if (patientPrescription != null) {
      map['patient_prescription'] = patientPrescription?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PatientPrescription {
  PatientPrescription({
      this.id, 
      this.userId, 
      this.patientId, 
      this.documentId, 
      this.date, 
      this.fileName, 
      this.doctorName, 
      this.notes, 
      this.createdAt, 
      this.updatedAt,});

  PatientPrescription.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    documentId = json['document_id'];
    date = json['date'];
    fileName = json['file_name'];
    doctorName = json['doctor_name'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  int? patientId;
  int? documentId;
  String? date;
  String? fileName;
  String? doctorName;
  dynamic notes;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['patient_id'] = patientId;
    map['document_id'] = documentId;
    map['date'] = date;
    map['file_name'] = fileName;
    map['doctor_name'] = doctorName;
    map['notes'] = notes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
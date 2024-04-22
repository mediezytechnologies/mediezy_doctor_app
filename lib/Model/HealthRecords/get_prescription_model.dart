class GetPrescriptionModel {
  bool? status;
  List<DocumentData>? documentData;

  GetPrescriptionModel({this.status, this.documentData});

  GetPrescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['document_data'] != null) {
      documentData = <DocumentData>[];
      json['document_data'].forEach((v) {
        documentData!.add(DocumentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (documentData != null) {
      data['document_data'] =
          documentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentData {
  int? id;
  int? userId;
  int? status;
  int? patientId;
  int? type;
  String? createdAt;
  String? updatedAt;
  String? documentPath;
  String? date;
  String? patient;
  String? hoursAgo;
  List<PatientPrescription>? patientPrescription;

  DocumentData(
      {this.id,
        this.userId,
        this.status,
        this.patientId,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.documentPath,
        this.date,
        this.patient,
        this.hoursAgo,
        this.patientPrescription});

  DocumentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    patientId = json['patient_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documentPath = json['document_path'];
    date = json['date'];
    patient = json['patient'];
    hoursAgo = json['hours_ago'];
    if (json['patient_prescription'] != null) {
      patientPrescription = <PatientPrescription>[];
      json['patient_prescription'].forEach((v) {
        patientPrescription!.add(PatientPrescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['status'] = status;
    data['patient_id'] = patientId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['document_path'] = documentPath;
    data['date'] = date;
    data['patient'] = patient;
    data['hours_ago'] = hoursAgo;
    if (patientPrescription != null) {
      data['patient_prescription'] =
          patientPrescription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientPrescription {
  int? id;
  int? documentId;
  String? date;
  String? doctorName;
  String? notes;
  String? admittedFor;
  String? hospitalName;
  String? name;

  PatientPrescription(
      {this.id,
        this.documentId,
        this.date,
        this.doctorName,
        this.notes,
        this.admittedFor,
        this.hospitalName,
        this.name});

  PatientPrescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentId = json['document_id'];
    date = json['date'];
    doctorName = json['doctor_name'];
    notes = json['notes'];
    admittedFor = json['admitted_for'];
    hospitalName = json['hospital_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['document_id'] = documentId;
    data['date'] = date;
    data['doctor_name'] = doctorName;
    data['notes'] = notes;
    data['admitted_for'] = admittedFor;
    data['hospital_name'] = hospitalName;
    data['name'] = name;
    return data;
  }
}
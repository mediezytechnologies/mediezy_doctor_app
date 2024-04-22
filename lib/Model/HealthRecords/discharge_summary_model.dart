class DischargeSummaryModel {
  bool? status;
  List<DocumentData>? documentData;

  DischargeSummaryModel({this.status, this.documentData});

  DischargeSummaryModel.fromJson(Map<String, dynamic> json) {
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
  List<DischargeSummary>? dischargeSummary;

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
        this.dischargeSummary});

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
    if (json['discharge_summary'] != null) {
      dischargeSummary = <DischargeSummary>[];
      json['discharge_summary'].forEach((v) {
        dischargeSummary!.add(DischargeSummary.fromJson(v));
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
    if (dischargeSummary != null) {
      data['discharge_summary'] =
          dischargeSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DischargeSummary {
  int? id;
  int? documentId;
  String? date;
  String? doctorName;
  String? notes;
  String? admittedFor;
  String? hospitalName;
  String? name;

  DischargeSummary(
      {this.id,
        this.documentId,
        this.date,
        this.doctorName,
        this.notes,
        this.admittedFor,
        this.hospitalName,
        this.name});

  DischargeSummary.fromJson(Map<String, dynamic> json) {
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
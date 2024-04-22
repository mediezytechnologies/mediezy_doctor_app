class GetUploadedScanReportModel {
  bool? status;
  List<DocumentData>? documentData;

  GetUploadedScanReportModel({this.status, this.documentData});

  GetUploadedScanReportModel.fromJson(Map<String, dynamic> json) {
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
  List<ScanReport>? scanReport;

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
        this.scanReport});

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
    if (json['scan_report'] != null) {
      scanReport = <ScanReport>[];
      json['scan_report'].forEach((v) {
        scanReport!.add(ScanReport.fromJson(v));
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
    if (scanReport != null) {
      data['scan_report'] = scanReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScanReport {
  int? id;
  int? documentId;
  String? date;
  String? testName;
  String? doctorName;
  String? labName;
  String? notes;
  String? admittedFor;
  String? hospitalName;
  String? name;

  ScanReport(
      {this.id,
        this.documentId,
        this.date,
        this.testName,
        this.doctorName,
        this.labName,
        this.notes,
        this.admittedFor,
        this.hospitalName,
        this.name});

  ScanReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentId = json['document_id'];
    date = json['date'];
    testName = json['test_name'];
    doctorName = json['doctor_name'];
    labName = json['lab_name'];
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
    data['test_name'] = testName;
    data['doctor_name'] = doctorName;
    data['lab_name'] = labName;
    data['notes'] = notes;
    data['admitted_for'] = admittedFor;
    data['hospital_name'] = hospitalName;
    data['name'] = name;
    return data;
  }
}
class TimeLineModel {
  TimeLineModel({
      this.status, 
      this.timeLine,});

  TimeLineModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['time_line'] != null) {
      timeLine = [];
      json['time_line'].forEach((v) {
        timeLine?.add(TimeLine.fromJson(v));
      });
    }
  }
  bool? status;
  List<TimeLine>? timeLine;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (timeLine != null) {
      map['time_line'] = timeLine?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TimeLine {
  TimeLine({
      this.id, 
      this.userId, 
      this.status, 
      this.createdAt, 
      this.documentPath, 
      this.labReport,});

  TimeLine.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    documentPath = json['document_path'];
    if (json['lab_report'] != null) {
      labReport = [];
      json['lab_report'].forEach((v) {
        labReport?.add(LabReport.fromJson(v));
      });
    }
  }
  int? id;
  int? userId;
  int? status;
  String? createdAt;
  String? documentPath;
  List<LabReport>? labReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['document_path'] = documentPath;
    if (labReport != null) {
      map['lab_report'] = labReport?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LabReport {
  LabReport({
      this.id, 
      this.userId, 
      this.patientId, 
      this.documentId, 
      this.testName, 
      this.date, 
      this.labName, 
      this.fileName, 
      this.doctorName, 
      this.notes, 
      this.createdAt, 
      this.updatedAt,});

  LabReport.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    documentId = json['document_id'];
    testName = json['test_name'];
    date = json['date'];
    labName = json['lab_name'];
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
  String? testName;
  String? date;
  String? labName;
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
    map['test_name'] = testName;
    map['date'] = date;
    map['lab_name'] = labName;
    map['file_name'] = fileName;
    map['doctor_name'] = doctorName;
    map['notes'] = notes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
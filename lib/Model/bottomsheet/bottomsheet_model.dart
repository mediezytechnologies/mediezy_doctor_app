class BottomsheetModel {
  BottomsheetModel({
      this.success, 
      this.message, 
      this.schedule,});

  BottomsheetModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['schedule'] != null) {
      schedule = [];
      json['schedule'].forEach((v) {
        schedule?.add(Schedule.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Schedule>? schedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (schedule != null) {
      map['schedule'] = schedule?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Schedule {
  Schedule({
      this.scheduleId, 
      this.scheduleType, 
      this.endDate, 
      this.clinicId, 
      this.clinicName, 
      this.daysRemaining, 
      this.status,});

  Schedule.fromJson(dynamic json) {
    scheduleId = json['schedule_id'];
    scheduleType = json['schedule_type'];
    endDate = json['end_date'];
    clinicId = json['clinic_id'];
    clinicName = json['clinic_name'];
    daysRemaining = json['days_remaining'];
    status = json['status'];
  }
  int? scheduleId;
  int? scheduleType;
  String? endDate;
  int? clinicId;
  String? clinicName;
  int? daysRemaining;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['schedule_id'] = scheduleId;
    map['schedule_type'] = scheduleType;
    map['end_date'] = endDate;
    map['clinic_id'] = clinicId;
    map['clinic_name'] = clinicName;
    map['days_remaining'] = daysRemaining;
    map['status'] = status;
    return map;
  }

}
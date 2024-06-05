class BottomSheetModel {
  BottomSheetModel({
      this.success, 
      this.message, 
      this.schedule,});

  BottomSheetModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    schedule = json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
  }
  bool? success;
  String? message;
  Schedule? schedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (schedule != null) {
      map['schedule'] = schedule?.toJson();
    }
    return map;
  }

}

class Schedule {
  Schedule({
      this.scheduleId, 
      this.scheduleType, 
      this.endDate, 
      this.clinicName, 
      this.status, 
      this.daysRemaining,});

  Schedule.fromJson(dynamic json) {
    scheduleId = json['schedule_id'];
    scheduleType = json['schedule_type'];
    endDate = json['end_date'];
    clinicName = json['clinic_name'];
    status = json['status'];
    daysRemaining = json['days_remaining'];
  }
  int? scheduleId;
  int? scheduleType;
  String? endDate;
  String? clinicName;
  int? status;
  int? daysRemaining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['schedule_id'] = scheduleId;
    map['schedule_type'] = scheduleType;
    map['end_date'] = endDate;
    map['clinic_name'] = clinicName;
    map['status'] = status;
    map['days_remaining'] = daysRemaining;
    return map;
  }

}
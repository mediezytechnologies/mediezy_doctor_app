class BottomsheetModel {
  bool? success;
  String? message;
  List<Schedule>? schedule;

  BottomsheetModel({this.success, this.message, this.schedule});

  BottomsheetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  String? startDate;
  int? scheduleId;
  int? scheduleType;
  String? endDate;
  int? clinicId;
  String? clinicName;
  int? totalScheduleDays;
  int? daysRemaining;
  int? status;

  Schedule(
      {this.startDate,
      this.scheduleId,
      this.scheduleType,
      this.endDate,
      this.clinicId,
      this.clinicName,
      this.totalScheduleDays,
      this.daysRemaining,
      this.status});

  Schedule.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    scheduleId = json['schedule_id'];
    scheduleType = json['schedule_type'];
    endDate = json['end_date'];
    clinicId = json['clinic_id'];
    clinicName = json['clinic_name'];
    totalScheduleDays = json['total_schedule_days'];
    daysRemaining = json['days_remaining'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['schedule_id'] = scheduleId;
    data['schedule_type'] = scheduleType;
    data['end_date'] = endDate;
    data['clinic_id'] = clinicId;
    data['clinic_name'] = clinicName;
    data['total_schedule_days'] = totalScheduleDays;
    data['days_remaining'] = daysRemaining;
    data['status'] = status;
    return data;
  }
}

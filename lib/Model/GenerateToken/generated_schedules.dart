class GeneratedSchedulesModel {
  List<Schedules>? schedules;

  GeneratedSchedulesModel({this.schedules});

  GeneratedSchedulesModel.fromJson(Map<String, dynamic> json) {
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (schedules != null) {
      data['schedules'] = schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedules {
  int? scheduleId;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  int? eachTokenDuration;
  int? scheduleType;
  String? selectedDays;
  String? clinicName;

  Schedules(
      {this.scheduleId,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.eachTokenDuration,
      this.scheduleType,
      this.selectedDays,
      this.clinicName});

  Schedules.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    eachTokenDuration = json['each_token_duration'];
    scheduleType = json['schedule_type'];
    selectedDays = json['selected_days'];
    clinicName = json['clinic_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule_id'] = scheduleId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['each_token_duration'] = eachTokenDuration;
    data['schedule_type'] = scheduleType;
    data['selected_days'] = selectedDays;
    data['clinic_name'] = clinicName;
    return data;
  }
}

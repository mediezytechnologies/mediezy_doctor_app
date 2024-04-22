class GetAllEarlyModel {
  GetAllEarlyModel({
      this.status, 
      this.data, 
      this.message,});

  GetAllEarlyModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<Data>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.rescheduleDuration, 
      this.scheduleDate, 
      this.scheduleType, 
      this.rescheduleId, 
      this.rescheduleType,});

  Data.fromJson(dynamic json) {
    rescheduleDuration = json['reschedule_duration'];
    scheduleDate = json['schedule_date'];
    scheduleType = json['schedule_type'];
    rescheduleId = json['reschedule_id'];
    rescheduleType = json['reschedule_type'];
  }
  String? rescheduleDuration;
  String? scheduleDate;
  String? scheduleType;
  int? rescheduleId;
  int? rescheduleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reschedule_duration'] = rescheduleDuration;
    map['schedule_date'] = scheduleDate;
    map['schedule_type'] = scheduleType;
    map['reschedule_id'] = rescheduleId;
    map['reschedule_type'] = rescheduleType;
    return map;
  }

}
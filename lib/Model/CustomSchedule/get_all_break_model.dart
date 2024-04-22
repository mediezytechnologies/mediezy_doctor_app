class GetAllBreakModel {
  GetAllBreakModel({
      this.status, 
      this.data, 
      this.message,});

  GetAllBreakModel.fromJson(dynamic json) {
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
      this.doctorBreakTime, 
      this.breakFromDate, 
      this.breakToDate, 
      this.breakStartTime, 
      this.breakEndTime, 
      this.scheduleType, 
      this.rescheduleId,});

  Data.fromJson(dynamic json) {
    doctorBreakTime = json['doctor_break_time'];
    breakFromDate = json['break_from_date'];
    breakToDate = json['break_to_date'];
    breakStartTime = json['break_start_time'];
    breakEndTime = json['break_end_time'];
    scheduleType = json['schedule_type'];
    rescheduleId = json['reschedule_id'];
  }
  String? doctorBreakTime;
  String? breakFromDate;
  String? breakToDate;
  String? breakStartTime;
  String? breakEndTime;
  String? scheduleType;
  int? rescheduleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_break_time'] = doctorBreakTime;
    map['break_from_date'] = breakFromDate;
    map['break_to_date'] = breakToDate;
    map['break_start_time'] = breakStartTime;
    map['break_end_time'] = breakEndTime;
    map['schedule_type'] = scheduleType;
    map['reschedule_id'] = rescheduleId;
    return map;
  }

}
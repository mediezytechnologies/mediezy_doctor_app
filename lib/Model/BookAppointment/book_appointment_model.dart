class BookAppointmentModel {
  BookAppointmentModel({
      this.success, 
      this.tokenBooking, 
      this.code, 
      this.message,});

  BookAppointmentModel.fromJson(dynamic json) {
    success = json['success'];
    tokenBooking = json['TokenBooking'] != null ? TokenBooking.fromJson(json['TokenBooking']) : null;
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  TokenBooking? tokenBooking;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (tokenBooking != null) {
      map['TokenBooking'] = tokenBooking?.toJson();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class TokenBooking {
  TokenBooking({
      this.tokenId, 
      this.doctorId, 
      this.patientId, 
      this.clinicId, 
      this.scheduleId, 
      this.tokenNumber, 
      this.tokenStartTime, 
      this.tokenEndTime, 
      this.tokenScheduledDate, 
      this.actualTokenDuration, 
      this.assignedTokenDuration, 
      this.scheduleType, 
      this.doctorLateTime, 
      this.doctorEarlyTime, 
      this.doctorBreakTime, 
      this.tokenUpTo, 
      this.createdAt, 
      this.updatedAt, 
      this.tokenBookingStatus, 
      this.isCheckedin, 
      this.isCheckedout, 
      this.checkinTime, 
      this.checkoutTime, 
      this.tokenBookingId,});

  TokenBooking.fromJson(dynamic json) {
    tokenId = json['token_id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    clinicId = json['clinic_id'];
    scheduleId = json['schedule_id'];
    tokenNumber = json['token_number'];
    tokenStartTime = json['token_start_time'];
    tokenEndTime = json['token_end_time'];
    tokenScheduledDate = json['token_scheduled_date'];
    actualTokenDuration = json['actual_token_duration'];
    assignedTokenDuration = json['assigned_token_duration'];
    scheduleType = json['schedule_type'];
    doctorLateTime = json['doctor_late_time'];
    doctorEarlyTime = json['doctor_early_time'];
    doctorBreakTime = json['doctor_break_time'];
    tokenUpTo = json['token_up_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tokenBookingStatus = json['token_booking_status'];
    isCheckedin = json['is_checkedin'];
    isCheckedout = json['is_checkedout'];
    checkinTime = json['checkin_time'];
    checkoutTime = json['checkout_time'];
    tokenBookingId = json['token_booking_id'];
  }
  int? tokenId;
  int? doctorId;
  dynamic patientId;
  int? clinicId;
  int? scheduleId;
  int? tokenNumber;
  String? tokenStartTime;
  String? tokenEndTime;
  String? tokenScheduledDate;
  dynamic actualTokenDuration;
  String? assignedTokenDuration;
  String? scheduleType;
  dynamic doctorLateTime;
  dynamic doctorEarlyTime;
  dynamic doctorBreakTime;
  dynamic tokenUpTo;
  String? createdAt;
  String? updatedAt;
  int? tokenBookingStatus;
  dynamic isCheckedin;
  dynamic isCheckedout;
  dynamic checkinTime;
  dynamic checkoutTime;
  int? tokenBookingId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_id'] = tokenId;
    map['doctor_id'] = doctorId;
    map['patient_id'] = patientId;
    map['clinic_id'] = clinicId;
    map['schedule_id'] = scheduleId;
    map['token_number'] = tokenNumber;
    map['token_start_time'] = tokenStartTime;
    map['token_end_time'] = tokenEndTime;
    map['token_scheduled_date'] = tokenScheduledDate;
    map['actual_token_duration'] = actualTokenDuration;
    map['assigned_token_duration'] = assignedTokenDuration;
    map['schedule_type'] = scheduleType;
    map['doctor_late_time'] = doctorLateTime;
    map['doctor_early_time'] = doctorEarlyTime;
    map['doctor_break_time'] = doctorBreakTime;
    map['token_up_to'] = tokenUpTo;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['token_booking_status'] = tokenBookingStatus;
    map['is_checkedin'] = isCheckedin;
    map['is_checkedout'] = isCheckedout;
    map['checkin_time'] = checkinTime;
    map['checkout_time'] = checkoutTime;
    map['token_booking_id'] = tokenBookingId;
    return map;
  }

}
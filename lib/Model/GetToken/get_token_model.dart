class GetTokenModel {
  GetTokenModel({
      this.status, 
      this.schedule, 
      this.message,});

  GetTokenModel.fromJson(dynamic json) {
    status = json['status'];
    schedule = json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
    message = json['message'];
  }
  bool? status;
  Schedule? schedule;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (schedule != null) {
      map['schedule'] = schedule?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

class Schedule {
  Schedule({
      this.schedule1, 
      this.schedule2, 
      this.schedule3,});

  Schedule.fromJson(dynamic json) {
    if (json['schedule_1'] != null) {
      schedule1 = [];
      json['schedule_1'].forEach((v) {
        schedule1?.add(Schedule1.fromJson(v));
      });
    }
    if (json['schedule_2'] != null) {
      schedule2 = [];
      json['schedule_2'].forEach((v) {
        schedule2?.add(Schedule2.fromJson(v));
      });
    }
    if (json['schedule_3'] != null) {
      schedule3 = [];
      json['schedule_3'].forEach((v) {
        schedule3?.add(Schedule3.fromJson(v));
      });
    }
  }
  List<Schedule1>? schedule1;
  List<Schedule2>? schedule2;
  List<Schedule3>? schedule3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (schedule1 != null) {
      map['schedule_1'] = schedule1?.map((v) => v.toJson()).toList();
    }
    if (schedule2 != null) {
      map['schedule_2'] = schedule2?.map((v) => v.toJson()).toList();
    }
    if (schedule3 != null) {
      map['schedule_3'] = schedule3?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Schedule3 {
  Schedule3({
      this.tokenId, 
      this.scheduleId, 
      this.tokenNumber, 
      this.scheduleType, 
      this.isReserved, 
      this.isBooked, 
      this.isDeleted, 
      this.formattedStartTime, 
      this.isTimeout,});

  Schedule3.fromJson(dynamic json) {
    tokenId = json['token_id'];
    scheduleId = json['schedule_id'];
    tokenNumber = json['token_number'];
    scheduleType = json['schedule_type'];
    isReserved = json['is_reserved'];
    isBooked = json['is_booked'];
    isDeleted = json['is_deleted'];
    formattedStartTime = json['formatted_start_time'];
    isTimeout = json['is_timeout'];
  }
  int? tokenId;
  int? scheduleId;
  int? tokenNumber;
  String? scheduleType;
  int? isReserved;
  int? isBooked;
  int? isDeleted;
  String? formattedStartTime;
  int? isTimeout;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_id'] = tokenId;
    map['schedule_id'] = scheduleId;
    map['token_number'] = tokenNumber;
    map['schedule_type'] = scheduleType;
    map['is_reserved'] = isReserved;
    map['is_booked'] = isBooked;
    map['is_deleted'] = isDeleted;
    map['formatted_start_time'] = formattedStartTime;
    map['is_timeout'] = isTimeout;
    return map;
  }

}

class Schedule2 {
  Schedule2({
      this.tokenId, 
      this.scheduleId, 
      this.tokenNumber, 
      this.scheduleType, 
      this.isReserved, 
      this.isBooked, 
      this.isDeleted, 
      this.formattedStartTime, 
      this.isTimeout,});

  Schedule2.fromJson(dynamic json) {
    tokenId = json['token_id'];
    scheduleId = json['schedule_id'];
    tokenNumber = json['token_number'];
    scheduleType = json['schedule_type'];
    isReserved = json['is_reserved'];
    isBooked = json['is_booked'];
    isDeleted = json['is_deleted'];
    formattedStartTime = json['formatted_start_time'];
    isTimeout = json['is_timeout'];
  }
  int? tokenId;
  int? scheduleId;
  int? tokenNumber;
  String? scheduleType;
  int? isReserved;
  int? isBooked;
  int? isDeleted;
  String? formattedStartTime;
  int? isTimeout;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_id'] = tokenId;
    map['schedule_id'] = scheduleId;
    map['token_number'] = tokenNumber;
    map['schedule_type'] = scheduleType;
    map['is_reserved'] = isReserved;
    map['is_booked'] = isBooked;
    map['is_deleted'] = isDeleted;
    map['formatted_start_time'] = formattedStartTime;
    map['is_timeout'] = isTimeout;
    return map;
  }

}

class Schedule1 {
  Schedule1({
      this.tokenId, 
      this.scheduleId, 
      this.tokenNumber, 
      this.scheduleType, 
      this.isReserved, 
      this.isBooked, 
      this.isDeleted, 
      this.formattedStartTime, 
      this.isTimeout,});

  Schedule1.fromJson(dynamic json) {
    tokenId = json['token_id'];
    scheduleId = json['schedule_id'];
    tokenNumber = json['token_number'];
    scheduleType = json['schedule_type'];
    isReserved = json['is_reserved'];
    isBooked = json['is_booked'];
    isDeleted = json['is_deleted'];
    formattedStartTime = json['formatted_start_time'];
    isTimeout = json['is_timeout'];
  }
  int? tokenId;
  int? scheduleId;
  int? tokenNumber;
  String? scheduleType;
  int? isReserved;
  int? isBooked;
  int? isDeleted;
  String? formattedStartTime;
  int? isTimeout;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_id'] = tokenId;
    map['schedule_id'] = scheduleId;
    map['token_number'] = tokenNumber;
    map['schedule_type'] = scheduleType;
    map['is_reserved'] = isReserved;
    map['is_booked'] = isBooked;
    map['is_deleted'] = isDeleted;
    map['formatted_start_time'] = formattedStartTime;
    map['is_timeout'] = isTimeout;
    return map;
  }

}
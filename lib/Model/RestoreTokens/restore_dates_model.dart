class RestoreDatesModel {
  RestoreDatesModel({
      this.status, 
      this.data,});

  RestoreDatesModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.doctorId, 
      this.clinicId, 
      this.fullDate, 
      this.month, 
      this.dayInText, 
      this.day,});

  Data.fromJson(dynamic json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    fullDate = json['full_date'];
    month = json['month'];
    dayInText = json['dayInText'];
    day = json['day'];
  }
  int? doctorId;
  int? clinicId;
  String? fullDate;
  String? month;
  String? dayInText;
  int? day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_id'] = doctorId;
    map['clinic_id'] = clinicId;
    map['full_date'] = fullDate;
    map['month'] = month;
    map['dayInText'] = dayInText;
    map['day'] = day;
    return map;
  }

}
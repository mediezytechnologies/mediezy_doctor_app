class GetAllLeavesModel {
  GetAllLeavesModel({
    this.status,
    this.leavesData,
    this.message,
  });

  GetAllLeavesModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['leaves_data'] != null) {
      leavesData = [];
      json['leaves_data'].forEach((v) {
        leavesData?.add(LeavesData.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<LeavesData>? leavesData;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (leavesData != null) {
      map['leaves_data'] = leavesData?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class LeavesData {
  LeavesData({this.id, this.docterId, this.hospitalId, this.date, this.status});

  LeavesData.fromJson(dynamic json) {
    id = json['id'];
    docterId = json['docter_id'];
    hospitalId = json['hospital_id'];
    date = json['date'];
    status = json["status"];
  }
  int? id;
  int? docterId;
  int? hospitalId;
  String? date;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['docter_id'] = docterId;
    map['hospital_id'] = hospitalId;
    map['date'] = date;
    map['status'] = status;

    return map;
  }
}

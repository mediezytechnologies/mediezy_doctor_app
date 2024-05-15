class GetAllMedicinesModel {
  GetAllMedicinesModel({
      this.success, 
      this.medicines,});

  GetAllMedicinesModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['medicines'] != null) {
      medicines = [];
      json['medicines'].forEach((v) {
        medicines?.add(Medicines.fromJson(v));
      });
    }
  }
  bool? success;
  List<Medicines>? medicines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (medicines != null) {
      map['medicines'] = medicines?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Medicines {
  Medicines({
      this.medicineName, 
      this.id, 
      this.favStatus,});

  Medicines.fromJson(dynamic json) {
    medicineName = json['medicine_name'];
    id = json['id'];
    favStatus = json['fav_status'];
  }
  String? medicineName;
  int? id;
  int? favStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medicine_name'] = medicineName;
    map['id'] = id;
    map['fav_status'] = favStatus;
    return map;
  }

}
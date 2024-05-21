class GetAllMedicinesModel {
  GetAllMedicinesModel({
      this.success, 
      this.medicineHistory, 
      this.medicines,});

  GetAllMedicinesModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['medicine_history'] != null) {
      medicineHistory = [];
      json['medicine_history'].forEach((v) {
        medicineHistory?.add(MedicineHistory.fromJson(v));
      });
    }
    if (json['medicines'] != null) {
      medicines = [];
      json['medicines'].forEach((v) {
        medicines?.add(Medicines.fromJson(v));
      });
    }
  }
  bool? success;
  List<MedicineHistory>? medicineHistory;
  List<Medicines>? medicines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (medicineHistory != null) {
      map['medicine_history'] = medicineHistory?.map((v) => v.toJson()).toList();
    }
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

class MedicineHistory {
  MedicineHistory({
      this.id, 
      this.medicineName, 
      this.createdAt,});

  MedicineHistory.fromJson(dynamic json) {
    id = json['id'];
    medicineName = json['medicine_name'];
    createdAt = json['created_at'];
  }
  int? id;
  String? medicineName;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['medicine_name'] = medicineName;
    map['created_at'] = createdAt;
    return map;
  }

}
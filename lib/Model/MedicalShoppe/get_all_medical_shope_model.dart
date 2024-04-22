class GetAllMedicalShopeModel {
  GetAllMedicalShopeModel({
      this.success, 
      this.medicalShop, 
      this.code, 
      this.message,});

  GetAllMedicalShopeModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['MedicalShop'] != null) {
      medicalShop = [];
      json['MedicalShop'].forEach((v) {
        medicalShop?.add(MedicalShop.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  List<MedicalShop>? medicalShop;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (medicalShop != null) {
      map['MedicalShop'] = medicalShop?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class MedicalShop {
  MedicalShop({
      this.id, 
      this.medicalShop, 
      this.medicalShopimage, 
      this.mobileNo, 
      this.location, 
      this.favoriteStatus,});

  MedicalShop.fromJson(dynamic json) {
    id = json['id'];
    medicalShop = json['MedicalShop'];
    medicalShopimage = json['MedicalShopimage'];
    mobileNo = json['mobileNo'];
    location = json['location'];
    favoriteStatus = json['favoriteStatus'];
  }
  int? id;
  String? medicalShop;
  String? medicalShopimage;
  String? mobileNo;
  String? location;
  int? favoriteStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['MedicalShop'] = medicalShop;
    map['MedicalShopimage'] = medicalShopimage;
    map['mobileNo'] = mobileNo;
    map['location'] = location;
    map['favoriteStatus'] = favoriteStatus;
    return map;
  }

}
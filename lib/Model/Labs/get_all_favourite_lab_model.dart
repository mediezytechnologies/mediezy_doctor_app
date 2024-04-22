class GetAllFavouriteLabModel {
  GetAllFavouriteLabModel({
      this.status, 
      this.message, 
      this.favoriteLabs,});

  GetAllFavouriteLabModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['favoriteLabs'] != null) {
      favoriteLabs = [];
      json['favoriteLabs'].forEach((v) {
        favoriteLabs?.add(FavoriteLabs.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<FavoriteLabs>? favoriteLabs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (favoriteLabs != null) {
      map['favoriteLabs'] = favoriteLabs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FavoriteLabs {
  FavoriteLabs({
      this.id, 
      this.userId, 
      this.laboratory, 
      this.laboratoryimage, 
      this.mobileNo, 
      this.location,});

  FavoriteLabs.fromJson(dynamic json) {
    id = json['id'];
    userId = json['UserId'];
    laboratory = json['Laboratory'];
    laboratoryimage = json['Laboratoryimage'];
    mobileNo = json['mobileNo'];
    location = json['location'];
  }
  int? id;
  int? userId;
  String? laboratory;
  String? laboratoryimage;
  String? mobileNo;
  String? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['UserId'] = userId;
    map['Laboratory'] = laboratory;
    map['Laboratoryimage'] = laboratoryimage;
    map['mobileNo'] = mobileNo;
    map['location'] = location;
    return map;
  }

}
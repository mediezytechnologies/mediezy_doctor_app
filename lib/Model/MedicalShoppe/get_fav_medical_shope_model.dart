class GetAllFavouriteMedicalStoresModel {
  bool? status;
  String? message;
  List<Favoritemedicalshop>? favoritemedicalshop;

  GetAllFavouriteMedicalStoresModel(
      {this.status, this.message, this.favoritemedicalshop});

  GetAllFavouriteMedicalStoresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['favoritemedicalshop'] != null) {
      favoritemedicalshop = <Favoritemedicalshop>[];
      json['favoritemedicalshop'].forEach((v) {
        favoritemedicalshop!.add(Favoritemedicalshop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (favoritemedicalshop != null) {
      data['favoritemedicalshop'] =
          favoritemedicalshop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favoritemedicalshop {
  int? id;
  int? userId;
  String? laboratory;
  String? laboratoryimage;
  String? mobileNo;
  String? location;

  Favoritemedicalshop(
      {this.id,
        this.userId,
        this.laboratory,
        this.laboratoryimage,
        this.mobileNo,
        this.location});

  Favoritemedicalshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    laboratory = json['Laboratory'];
    laboratoryimage = json['Laboratoryimage'];
    mobileNo = json['mobileNo'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['UserId'] = userId;
    data['Laboratory'] = laboratory;
    data['Laboratoryimage'] = laboratoryimage;
    data['mobileNo'] = mobileNo;
    data['location'] = location;
    return data;
  }
}

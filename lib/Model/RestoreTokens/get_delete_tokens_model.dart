class GetDeleteTokensModel {
  GetDeleteTokensModel({
      this.status, 
      this.data,});

  GetDeleteTokensModel.fromJson(dynamic json) {
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
      this.formatdate, 
      this.date, 
      this.time, 
      this.tokenId, 
      this.tokenNumber,});

  Data.fromJson(dynamic json) {
    formatdate = json['format date'];
    date = json['date'];
    time = json['time'];
    tokenId = json['token_id'];
    tokenNumber = json['token_number'];
  }
  String? formatdate;
  String? date;
  String? time;
  int? tokenId;
  int? tokenNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['format date'] = formatdate;
    map['date'] = date;
    map['time'] = time;
    map['token_id'] = tokenId;
    map['token_number'] = tokenNumber;
    return map;
  }

}
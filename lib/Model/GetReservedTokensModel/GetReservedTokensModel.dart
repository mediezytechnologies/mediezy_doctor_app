class GetReservedTokensModel {
  GetReservedTokensModel({
      this.status, 
      this.message, 
      this.getTokenDetails,});

  GetReservedTokensModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['getTokenDetails'] != null) {
      getTokenDetails = [];
      json['getTokenDetails'].forEach((v) {
        getTokenDetails?.add(GetTokenDetails.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<GetTokenDetails>? getTokenDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (getTokenDetails != null) {
      map['getTokenDetails'] = getTokenDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GetTokenDetails {
  GetTokenDetails({
      this.tokenId, 
      this.tokenNumber, 
      this.tokenStartTime,});

  GetTokenDetails.fromJson(dynamic json) {
    tokenId = json['token_id'];
    tokenNumber = json['token_number'];
    tokenStartTime = json['token_start_time'];
  }
  String? tokenId;
  String? tokenNumber;
  String? tokenStartTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_id'] = tokenId;
    map['token_number'] = tokenNumber;
    map['token_start_time'] = tokenStartTime;
    return map;
  }

}
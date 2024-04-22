class GenerateTokenErrorModel {
  GenerateTokenErrorModel({
      this.success, 
      this.message, 
      this.errors,});

  GenerateTokenErrorModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? success;
  String? message;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }

}

class Errors {
  Errors({
      this.eachTokenDuration,});

  Errors.fromJson(dynamic json) {
    eachTokenDuration = json['each_token_duration'] != null ? json['each_token_duration'].cast<String>() : [];
  }
  List<String>? eachTokenDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['each_token_duration'] = eachTokenDuration;
    return map;
  }

}
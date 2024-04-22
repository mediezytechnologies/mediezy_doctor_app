class LeaveCheckModel {
  LeaveCheckModel({
      this.status, 
      this.message, 
      this.bookedtokencount,});

  LeaveCheckModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    bookedtokencount = json['booked token count'];
  }
  bool? status;
  String? message;
  int? bookedtokencount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['booked token count'] = bookedtokencount;
    return map;
  }

}
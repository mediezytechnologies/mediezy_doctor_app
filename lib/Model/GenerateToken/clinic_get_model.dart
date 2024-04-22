class ClinicGetModel {
  ClinicGetModel({
      this.status, 
      this.message, 
      this.hospitalDetails,});

  ClinicGetModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['hospital_details'] != null) {
      hospitalDetails = [];
      json['hospital_details'].forEach((v) {
        hospitalDetails?.add(HospitalDetails.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<HospitalDetails>? hospitalDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (hospitalDetails != null) {
      map['hospital_details'] = hospitalDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class HospitalDetails {
  HospitalDetails({
      this.clinicId, 
      this.clinicName,});

  HospitalDetails.fromJson(dynamic json) {
    clinicId = json['clinic_id'];
    clinicName = json['clinic_name'];
  }
  int? clinicId;
  String? clinicName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinic_id'] = clinicId;
    map['clinic_name'] = clinicName;
    return map;
  }

}
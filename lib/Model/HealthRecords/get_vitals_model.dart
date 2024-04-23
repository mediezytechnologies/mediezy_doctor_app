class GetVitalsModel {
  bool? status;
  List<Vitals>? vitals;

  GetVitalsModel({this.status, this.vitals});

  GetVitalsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['vitals'] != null) {
      vitals = <Vitals>[];
      json['vitals'].forEach((v) {
        vitals!.add(Vitals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (vitals != null) {
      data['vitals'] = vitals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vitals {
  String? date;
  String? patientName;
  String? doctorFirstname;
  String? height;
  String? weight;
  String? temperature;
  String? spo2;
  String? sys;
  String? dia;
  String? heartRate;
  String? temperatureType;

  Vitals(
      {this.date,
        this.patientName,
        this.doctorFirstname,
        this.height,
        this.weight,
        this.temperature,
        this.spo2,
        this.sys,
        this.dia,
        this.heartRate,
        this.temperatureType});

  Vitals.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    patientName = json['patient_name'];
    doctorFirstname = json['doctor_firstname'];
    height = json['height'];
    weight = json['weight'];
    temperature = json['temperature'];
    spo2 = json['spo2'];
    sys = json['sys'];
    dia = json['dia'];
    heartRate = json['heart_rate'];
    temperatureType = json['temperature_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['patient_name'] = patientName;
    data['doctor_firstname'] = doctorFirstname;
    data['height'] = height;
    data['weight'] = weight;
    data['temperature'] = temperature;
    data['spo2'] = spo2;
    data['sys'] = sys;
    data['dia'] = dia;
    data['heart_rate'] = heartRate;
    data['temperature_type'] = temperatureType;
    return data;
  }
}

class GetSymptomsModel {
  GetSymptomsModel({
      this.symptoms,});

  GetSymptomsModel.fromJson(dynamic json) {
    if (json['symptoms'] != null) {
      symptoms = [];
      json['symptoms'].forEach((v) {
        symptoms?.add(Symptoms.fromJson(v));
      });
    }
  }
  List<Symptoms>? symptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (symptoms != null) {
      map['symptoms'] = symptoms?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Symptoms {
  Symptoms({
      this.id, 
      this.specializationId, 
      this.symtoms, 
      this.createdAt, 
      this.updatedAt,});

  Symptoms.fromJson(dynamic json) {
    id = json['id'];
    specializationId = json['specialization_id'];
    symtoms = json['symtoms'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? specializationId;
  String? symtoms;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['specialization_id'] = specializationId;
    map['symtoms'] = symtoms;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
class SearchLabTestModel {
  bool? status;
  String? message;
  List<LabTests>? labTests;

  SearchLabTestModel({this.status, this.message, this.labTests});

  SearchLabTestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Lab_Tests'] != null) {
      labTests = <LabTests>[];
      json['Lab_Tests'].forEach((v) {
        labTests!.add(LabTests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (labTests != null) {
      data['Lab_Tests'] = labTests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabTests {
  int? id;
  String? testName;
  int? favStatus;

  LabTests({this.id, this.testName, this.favStatus});

  LabTests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
    favStatus = json['fav_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['test_name'] = testName;
    data['fav_status'] = favStatus;
    return data;
  }
}

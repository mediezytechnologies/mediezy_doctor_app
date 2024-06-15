class SearchLabTestModel {
  bool? status;
  List<LabHistory>? labHistory;
  List<LabTests>? labTests;
  String? message;

  SearchLabTestModel(
      {this.status, this.labHistory, this.labTests, this.message});

  SearchLabTestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['lab_history'] != null) {
      labHistory = <LabHistory>[];
      json['lab_history'].forEach((v) {
        labHistory!.add(LabHistory.fromJson(v));
      });
    }
    if (json['Lab_Tests'] != null) {
      labTests = <LabTests>[];
      json['Lab_Tests'].forEach((v) {
        labTests!.add(LabTests.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (labHistory != null) {
      data['lab_history'] = labHistory!.map((v) => v.toJson()).toList();
    }
    if (labTests != null) {
      data['Lab_Tests'] = labTests!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class LabHistory {
  int? id;
  String? testName;

  LabHistory({this.id, this.testName});

  LabHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testName = json['test_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['test_name'] = testName;
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

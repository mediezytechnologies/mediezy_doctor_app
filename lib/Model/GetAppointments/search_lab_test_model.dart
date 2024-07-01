class SearchLabTestModel {
  bool? status;
  List<History>? history;
  List<Tests>? tests;
  String? message;

  SearchLabTestModel({this.status, this.history, this.tests, this.message});

  SearchLabTestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    if (json['tests'] != null) {
      tests = <Tests>[];
      json['tests'].forEach((v) {
        tests!.add(Tests.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    if (tests != null) {
      data['tests'] = tests!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class History {
  int? id;
  String? testName;

  History({this.id, this.testName});

  History.fromJson(Map<String, dynamic> json) {
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

class Tests {
  int? id;
  String? testName;
  int? favStatus;

  Tests({this.id, this.testName, this.favStatus});

  Tests.fromJson(Map<String, dynamic> json) {
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

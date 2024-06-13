import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Repositary/Api/ApiClient.dart';

class AddCheckinOrCheckoutModel {
  String? message;

  AddCheckinOrCheckoutModel({this.message});

  AddCheckinOrCheckoutModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}




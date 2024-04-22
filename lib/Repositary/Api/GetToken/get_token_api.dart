// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTokenApi {
  ApiClient apiClient = ApiClient();
  Future<GetTokenModel> getToken(
      {required String date, required String clinicId}) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/getDoctorTokenDetails/$date/$clinicId/$doctorId";
    // String basePath = "schedule/$date/1";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<< Get Token Worked >>>>>>");
    return GetTokenModel.fromJson(json.decode(response.body));
  }
}

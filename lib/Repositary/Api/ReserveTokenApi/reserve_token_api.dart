import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GetReservedTokensModel/GetReservedTokensModel.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReserveTokenApi {
  ApiClient apiClient = ApiClient();

  //add reserve token

  Future<String> addReserveToken({
    required String tokenNumber,
    required String fromDate,
    required String toDate,
    required String clinicId,
  }) async {
    String basePath = "doctor/doctorReserveTokens";

    final body = {
      "token_number": tokenNumber,
      "from_date": fromDate,
      "to_date": toDate,
      "clinic_id": clinicId,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    log(body.toString());
    log("<<<<<<<<<<Reserve Token response worked>>>>>>>>>>");
    return response.body;
  }

  //get reserved tokens

  Future<GetReservedTokensModel> getReservedTokens({
    required String fromDate,
    required String toDate,
    required String clinicId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');

    String basePath = "doctor/getReservedToKenDetails";

    final body = {
      "doctor_id": doctorId,
      "token_start_time": fromDate,
      "token_end_time": toDate,
      "clinic_id": clinicId,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Get Reserved Token response worked>>>>>>>>>>");
    return GetReservedTokensModel.fromJson(json.decode(response.body));
  }

  //un reserve token

  Future<String> unReserveToken({
    required String tokenNumber,
    required String fromDate,
    required String toDate,
    required String clinicId,
  }) async {
    String basePath = "doctor/getUnReservedToKenDetails";
    final body = {
      "token_number": tokenNumber,
      "from_date": fromDate,
      "to_date": toDate,
      "clinic_id": clinicId
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    log(body.toString());
    log("<<<<<<<<<<Un reserve Token response worked>>>>>>>>>>");
    return response.body;
  }
}

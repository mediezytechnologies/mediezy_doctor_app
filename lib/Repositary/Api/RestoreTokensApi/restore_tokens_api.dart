import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/get_delete_tokens_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/restore_dates_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestoreTokensApi {
  ApiClient apiClient = ApiClient();

  //get delete token dates

  Future<RestoreDatesModel> getDates({required String clinicId}) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "getAllDatesOfDeletedTokens";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    return RestoreDatesModel.fromJson(json.decode(response.body));
  }

  //get deleted tokens api

  Future<GetDeleteTokensModel> getDeletedTokens({
    required String clinicId,
    // required String date
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "getDeletedTokens";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      // "date": date,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log(response.body);
    return GetDeleteTokensModel.fromJson(json.decode(response.body));
  }

  // add restore token

  Future<String> addRestoreToken({required String tokenId}) async {
    String basePath = "restoreTokens";

    final body = {
      "token_id": tokenId,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    return response.body;
  }
}

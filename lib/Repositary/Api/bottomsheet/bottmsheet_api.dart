import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/bottomsheet/bottomsheet_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetApi {
  ApiClient apiClient = ApiClient();

  Future<BottomsheetModel> addBottomSheet() async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/check-schedule";

    final body = {"user_id": doctorId};

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    return BottomsheetModel.fromJson(json.decode(response.body));
  }
}

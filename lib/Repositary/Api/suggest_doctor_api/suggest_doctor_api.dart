// ignore_for_file: avoid_print

import 'package:http/http.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestDoctorApi {
  ApiClient apiClient = ApiClient();

  Future<String> doctorRecommend({
    required String doctorName,
    required String location,
    required String clinicName,
    required String specialization,
    required String phoneNumber,
  }) async {
    final preference = await SharedPreferences.getInstance();
    String doctorId = preference.getString('DoctorId').toString();
    String basePath = "patient/suggestDoctor";
    final body = {
      "user_id": doctorId,
      "name": doctorName,
      "place": location,
      "clinic_name": clinicName,
      "specialization": specialization,
      "mobile_number": phoneNumber
    };

    Response response =
    await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("DOCTOR RECOMMENDED BODY : $body");
    print("<<<<<<<<<< SEND DOCTOR RECOMMENDED WORKED SUCCESSFULLY>>>>>>>>>>");
    return response.body;
  }
}
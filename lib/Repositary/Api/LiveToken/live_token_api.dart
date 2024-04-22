import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/LiveToken/get_current_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCurrentTokenApi {
  ApiClient apiClient = ApiClient();

  //* get current token number and time
  Future<GetCurrentTokenModel> getCurrentToken({
    required String clinicId,
    required String scheduleType,
  }) async {
    String basePath = "Tokens/getcurrentTokens";

    final body = {
      "clinic_id": clinicId,
      "schedule_type": scheduleType,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< Get Current Token Worked >>>>>>");
    return GetCurrentTokenModel.fromJson(json.decode(response.body));
  }

  //* checkin or checkout

  Future<String> addCheckinOrCheckout({
    required String tokenNumber,
    required int isCheckIn,
    required int isCompleted,
    required String clinicId,
    required String isReached,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    String basePath = "doctor/getTokensCheckInCheckOut";

    final body = {
      "TokenNumber": tokenNumber,
      "is_checkedin": isCheckIn,
      "is_checkedout": isCompleted,
      "clinic_id": clinicId,
      "doctor_user_id": doctorId,
      "is_reached": isReached
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return response.body;
  }
}

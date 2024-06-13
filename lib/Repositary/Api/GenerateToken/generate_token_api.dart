import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GenerateToken/generated_schedules.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:mediezy_doctor/Repositary/Api/MultiFileApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateTokenApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient multiFileApiClient = MultiFileApiClient();

  //! clinic get api

  Future<ClinicGetModel> getClinic() async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "get-hospital-name/$id";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    return ClinicGetModel.fromJson(json.decode(response.body));
  }

  //! generate token api

  Future<String> getGenerateTokenFinal({
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String timeDuration,
    required String scheduleType,
    required String clinicId,
    required List<String> selecteddays,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "doctor/generateTokenSchedule";

    final body = {
      "doctor_id": id,
      "start_date": startDate,
      "end_date": endDate,
      "start_time": startTime,
      "end_time": endTime,
      "each_token_duration": timeDuration,
      "schedule_type": scheduleType,
      "clinic_id": clinicId,
      "selected_days": selecteddays,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Generate token final response worked>>>>>>>>>>");
    return response.body;
  }

  //! generated schedules

  Future<GeneratedSchedulesModel> getSchedules() async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "doctor/userSchedules";

    final body = {"user_id": id};

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    return GeneratedSchedulesModel.fromJson(json.decode(response.body));
  }
}

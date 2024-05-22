import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_break_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_early_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_late_model.dart';
import 'package:mediezy_doctor/Model/MessageShowModel/message_show_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomScheduleApi {
  ApiClient apiClient = ApiClient();

  //Late Custome Schedule

  Future<String> addLateSchedule({
    required String clinicId,
    required String date,
    required String scheduleType,
    required String timeDuration,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/doctorRequestForlate";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "schedule_date": date,
      "late_time_duration": timeDuration,
      "schedule_type": scheduleType
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<<Late Schedule response worked>>>>>>>>>>");
    return response.body;
  }

  //get all Late
  Future<GetAllLateModel> getAllLate({
    required String clinicId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/getAllDoctorReschedules/$doctorId/$clinicId/1";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);

    log("<<<<<<<<<< Get All Late worked>>>>>>>>>>");
    return GetAllLateModel.fromJson(json.decode(response.body));
  }

  //get all early
  Future<GetAllEarlyModel> getAllEarly({
    required String clinicId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/getAllDoctorReschedules/$doctorId/$clinicId/2";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);

    log("<<<<<<<<<< Get All Late worked>>>>>>>>>>");
    return GetAllEarlyModel.fromJson(json.decode(response.body));
  }

  //get all break
  Future<GetAllBreakModel> getAllBreak({
    required String clinicId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/getAllDoctorBreakRequests";
    final body = {"doctor_user_id": doctorId, "clinic_id": clinicId};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<< Get All Late worked>>>>>>>>>>");
    return GetAllBreakModel.fromJson(json.decode(response.body));
  }

  //Early Custome Schedule

  Future<MessageShowModel> addEarlySchedule({
    required String clinicId,
    required String date,
    required String scheduleType,
    required String timeDuration,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/doctorRequestForEarly";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "schedule_date": date,
      "early_time_duration": timeDuration,
      "schedule_type": scheduleType
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<<Early Schedule response worked>>>>>>>>>>");
    return MessageShowModel.fromJson(json.decode(response.body));
  }

  //Break Custome Schedule

  Future<String> getBetweenSchedule({
    required String clinicId,
    required String startDate,
    required String endDate,
    required String scheduleType,
    required String startTime,
    required String endTime,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/doctorRequestForBreak";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "break_start_date": startDate,
      "break_end_date": endDate,
      "break_start_time": startTime,
      "break_end_time": endTime,
      "schedule_type": scheduleType
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    log(body.toString());
    log("<<<<<<<<<<Break Schedule response worked>>>>>>>>>>");
    return response.body;
  }

  //delete late Custome Schedule

  Future<String> deleteLate({
    required String scheduleId,
  }) async {
    String basePath = "doctor/deleteDoctorLateReschedules";
    final body = {
      "reschedule_id": scheduleId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<<late delete response worked>>>>>>>>>>");
    return response.body;
  }

  //delete early schedule

  Future<String> deleteEarly({
    required String scheduleId,
  }) async {
    String basePath = "doctor/deleteDoctorEarlyReschedules";
    final body = {
      "reschedule_id": scheduleId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<early delete response worked>>>>>>");
    return response.body;
  }

  //delete Break Custome Schedule

  Future<String> deleteBreak({
    required String reScheduleId,
  }) async {
    String basePath = "doctor/deleteDoctorBreakRequests";
    final body = {
      "reschedule_id": reScheduleId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<<Break delete response worked>>>>>>>>>>");
    return response.body;
  }
}

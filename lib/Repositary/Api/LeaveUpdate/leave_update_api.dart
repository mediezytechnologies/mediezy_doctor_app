import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_leaves_model.dart';
import 'package:mediezy_doctor/Model/leave_check_model/leave_check_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveUpdateApi {
  ApiClient apiClient = ApiClient();

  // Leave Custome Schedule
  Future<String> getLeaveUpdate({
    required String clinicId,
    required String fromDate,
    required String toDate,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/doctorLeaveUpdate";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "from_date": fromDate,
      "to_date": toDate,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    log(body.toString());
    print(body);
    print(response.body);
    log("<<<<<<<<<<Leave Schedule response worked>>>>>>>>>>");
    return response.body;
  }

  // Delete leave Schedule
  Future<String> leaveDelete({
    required String clinicId,
    required String date,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/doctorleaveDelete";

    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "date": date,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: body);
    log(body.toString());
    log("<<<<<<<<<<Leave Schedule delete response worked>>>>>>>>>>");
    return response.body;
  }

  // Get All Leaves
  Future<GetAllLeavesModel> getAllLeaves({
    required String hospitalId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "docter/leaves";

    final body = {
      "doctor_id": doctorId,
      "hospital_id": hospitalId,
    };
log(body.toString());
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    log("<<<<<<<<<<Get All Leaves response worked>>>>>>>>>>");
    return GetAllLeavesModel.fromJson(json.decode(response.body));
  }

//get leave check

  Future<LeaveCheckModel> getCheckLeave({
    required String clinicId,
    required String fromDate,
    required String toDate,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/checkForExistingTokens";

    final body = {
      "clinic_id": clinicId,
      "doctor_user_id": doctorId,
      "from_date": fromDate,
      "to_date": toDate,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<< get check leave successfull>>>>>>");
    return LeaveCheckModel.fromJson(json.decode(response.body));
  }
}

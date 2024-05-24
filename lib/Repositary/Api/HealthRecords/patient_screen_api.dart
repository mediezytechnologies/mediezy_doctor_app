import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/HealthRecords/patients_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientScreenApi {
  ApiClient apiClient = ApiClient();

  //! Patients get api

  Future<PatientsGetModel> getPatients({required String clinicId}) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "docter/get_booked_patients";
    final body = {
      "doctor_id": doctorId,
      "clinic_id": clinicId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return PatientsGetModel.fromJson(json.decode(response.body));
  }

  //! search Patients get api

  Future<PatientsGetModel> getSearchPatients({
    required String searchQuery,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "docter/searchPatients";
    final body = {
      "doctor_id": doctorId,
      "search_name": searchQuery,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return PatientsGetModel.fromJson(json.decode(response.body));
  }

  //! Sorting Patients get api

  Future<PatientsGetModel> getSortingPatients(
      {required String sort,
      required String clinicId,
      required String fromDate,
      required String toDate}) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/getAllSortedPatients";
    final body = {
      "doctor_id": doctorId,
      "interval": sort,
      "clinic_id": clinicId,
      "from_date": fromDate,
      "to_date": toDate,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return PatientsGetModel.fromJson(json.decode(response.body));
  }
}

import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/HealthRecords/GetUploadedScanReportModel.dart';
import 'package:mediezy_doctor/Model/HealthRecords/completed_appointments_ht_rcd_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/discharge_summary_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_view_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/health_records_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/lab_report_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/time_line_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';

class HealthRecordsApi {
  ApiClient apiClient = ApiClient();

  //get all health records
  Future<HealthRecordsModel> getAllHealthRecords({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "user/get_uploaded_documents";
    final body = {
      "patient_id": patientId,
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return HealthRecordsModel.fromJson(json.decode(response.body));
  }

  //prescription get api

  Future<GetPrescriptionModel> getPrescription(
      {required String patientId, required String userId}) async {
    String basePath = "user/get_uploaded_documents";
    final body = {
      "patient_id": patientId,
      "user_id": userId,
      "type": "2",
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return GetPrescriptionModel.fromJson(json.decode(response.body));
  }

  //prescription view get api

  Future<GetPrescriptionViewModel> getPrescriptionView({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "user/get_prescriptions";
    final body = {
      "patient_id": patientId,
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return GetPrescriptionViewModel.fromJson(json.decode(response.body));
  }

  //Lab Report get api

  Future<LabReportModel> getLabReport({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "user/get_uploaded_documents";
    final body = {
      "patient_id": patientId,
      "user_id": userId,
      "type": "1",
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return LabReportModel.fromJson(json.decode(response.body));
  }

  //* get uploaded scan reports

  Future<GetUploadedScanReportModel> getAllUploadedScanReports(
      {required String patientId, required String userId}) async {
    String basePath = "user/get_uploaded_documents";
    final body = {"patient_id": patientId, "user_id": userId, "type": "4"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print("<<<<<< GET ALL UPLOADED SCAN REPORTS WORKED SUCCESSFULLY >>>>>>");
    return GetUploadedScanReportModel.fromJson(json.decode(response.body));
  }

  //time line get api

  Future<TimeLineModel> getTimeLine({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "user/reports_time_line";
    final body = {
      "patient_id": patientId,
      "user_id": userId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return TimeLineModel.fromJson(json.decode(response.body));
  }

  //* get completed appointments by patient id

  Future<GetCompletedAppointmentsHealthRecordModel>
      getCompletedAppointmentByPatientId({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "patient/getSortedPatientAppointments/$patientId/$userId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    return GetCompletedAppointmentsHealthRecordModel.fromJson(
        json.decode(response.body));
  }

  //* get uploaded discharge summary
  Future<DischargeSummaryModel> getAllUploadedDischargeSummary({
    required String patientId,
    required String userId,
  }) async {
    String basePath = "user/get_uploaded_documents";

    final body = {"patient_id": patientId, "user_id": userId, "type": "3"};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(
        "<<<<<< GET ALL UPLOADED DISCHARGE SUMMARY WORKED SUCCESSFULLY >>>>>>");
    return DischargeSummaryModel.fromJson(json.decode(response.body));
  }
}

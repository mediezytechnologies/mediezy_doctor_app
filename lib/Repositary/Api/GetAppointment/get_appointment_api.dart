import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointments_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/add_prescription_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/search_lab_test_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:mediezy_doctor/Repositary/Api/MultiFileApiClient2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/GetAppointments/get_all_medicines_model.dart';

class GetAppointmentApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient2 multiFileApiClient = MultiFileApiClient2();

  //! get all appointments as per date

  Future<GetAppointmentsModel> getAllApointments({
    required String date,
    required String clinicId,
    required String scheduleType,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "doctor/getAllUserAppointments";

    final body = {
      "userId": id,
      "date": date,
      "clinicId": clinicId,
      "schedule_type": scheduleType,
    };
    final startTime = DateTime.now();
    log('API call started at: $startTime');
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    // log("respose ste1 === : ${response.body}");
    //print("<<<<<< Get All Appointments Are Worked >>>>>>");
    final endTime = DateTime.now();
    log('API call ended at: $endTime');

    final duration = endTime.difference(startTime);
    log('API call duration: ${duration.inMilliseconds} ms');
    return GetAppointmentsModel.fromJson(json.decode(response.body));
  }

  //! Add prescription api

  Future<AddPrescriptionModel> getAddPresscription({
    required String medicineName,
    required String medicineId,
    required String dosage,
    required String noOfDays,
    required String type,
    required String night,
    required String morning,
    required String noon,
    required String bookedPersonId,
    required String tokenId,
    required String evening,
    required String medicalStoreId,
    required String timeSection,
    required String interval,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "docter/add_prescription";

    final body = {
      "medicine_name": medicineName,
      "medicine_id": medicineId,
      "token_id": tokenId,
      "dosage": dosage,
      "no_of_days": noOfDays,
      "type": type,
      "night": night,
      "morning": morning,
      "noon": noon,
      "doctor_id": id,
      "BookedPerson_id": bookedPersonId,
      "evening": evening,
      "medical_shop_id": medicalStoreId,
      "time_section": timeSection,
      "interval": interval,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    //print("<<<<<<<<<<Add prescription response worked>>>>>>>>>>");
    return AddPrescriptionModel.fromJson(json.decode(response.body));
  }

  //! edit prescription api

  Future<String> editPrescription({
    required String medicineId,
    required String medicineName,
    required String dosage,
    required String noOfDays,
    required String type,
    required String night,
    required String morning,
    required String noon,
    required String evening,
    required String timeSection,
    required String interval,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "patient/update_medicine";

    final body = {
      "medicine_id": medicineId,
      "medicine_name": medicineName,
      "dosage": dosage,
      "no_of_days": noOfDays,
      "type": type,
      "night": night,
      "morning": morning,
      "noon": noon,
      "doctor_id": id,
      "evening": evening,
      "time_section": timeSection,
      "interval": interval,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    //print(body);
    //print("<<<<<<<<<<Edit prescription response worked>>>>>>>>>>");
    return response.body;
  }

  //! get all completed appointments as per date

  Future<GetAllCompletedAppointmentsModel> getAllCompletedApointmentsAsPerDate({
    required String date,
    required String clinicId,
    required String scheduleType,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath =
        "doctor/getallcompletedappointments/$id/$date/$clinicId/$scheduleType";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    //print("<<<<<< Get All completed Appointments Are Worked >>>>>>");
    return GetAllCompletedAppointmentsModel.fromJson(
        json.decode(response.body));
  }

  //! delete medicine api

  Future<String> deleteMedicine({
    required String medicineId,
  }) async {
    String basePath = "docter/medicine/$medicineId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: null);
    //print("<<<<<< Delete medicine Worked >>>>>>");
    return response.body;
  }

  //! get Completed AppointmentDetails api

  Future<GetAllCompletedAppointmentDetailsModel>
      getAllCompletedAppointmentDetails({
    required String tokenId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "doctor/get_completed_appoitment_details";

    final body = {
      "appointment_id": tokenId,
      "user_id": doctorId,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Get all Completed AppointmentDetails response worked>>>>>>>>>>");
    return GetAllCompletedAppointmentDetailsModel.fromJson(
        json.decode(response.body));
  }

  //! Add Vitals Api

  Future<String> addVitals({
    required String tokenId,
    required String height,
    required String weight,
    required String temperature,
    required String temperatureType,
    required String spo2,
    required String sys,
    required String dia,
    required String heartRate,
  }) async {
    String basePath = "addVitals";

    final body = {
      "token_id": tokenId,
      "height": height,
      "weight": weight,
      "temperature": temperature,
      "temperature_type": temperatureType,
      "spo2": spo2,
      "sys": sys,
      "dia": dia,
      "heart_rate": heartRate
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    //print(body);
    return response.body;
  }

  //! edit Vitals Api

  Future<String> editVitals({
    required String tokenId,
    required String height,
    required String weight,
    required String temperature,
    required String temperatureType,
    required String spo2,
    required String sys,
    required String dia,
    required String heartRate,
  }) async {
    String basePath = "editVitals";

    final body = {
      "token_id": tokenId,
      "height": height,
      "weight": weight,
      "temperature": temperature,
      "temperature_type": temperatureType,
      "spo2": spo2,
      "sys": sys,
      "dia": dia,
      "heart_rate": heartRate
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    //print(body);
    return response.body;
  }

  //! delete Vitals Api

  Future<String> deleteVitals({
    required String tokenId,
  }) async {
    String basePath = "deleteVitals";

    final body = {
      "token_id": tokenId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: body);
    //print(body);
    return response.body;
  }

  //! search medicine

  Future<GetAllMedicinesModel> getAllMedicines({
    required String searchQuery,
  }) async {
    String basePath = "doctor/getMedicineBySearch";
    final body = {"medicine_name": searchQuery};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    //print(body);
    return GetAllMedicinesModel.fromJson(json.decode(response.body));
  }

//! delete recently search

  Future<String> deleteRecentlySearch({
    required String medicineId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/deleteMedicineHistory";
    final body = {
      "doctor_id": doctorId,
      "medicine_id": medicineId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: body);
    log(body.toString());
    return response.body;
  }

  //! update favourite medicine

  Future<String> updateFavouriteMedicine({
    required String medicineId,
  }) async {
    String basePath = "doctor/updateFavoriteMedicines";

    final body = {
      "medicine_id": medicineId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    //print(body);
    return response.body;
  }

  //! search lab test

  Future<SearchLabTestModel> getAllLabTest({
    required String searchQuery,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "lab-tests";
    final body = {"user_id": doctorId, "search": searchQuery};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    //print(body);
    return SearchLabTestModel.fromJson(json.decode(response.body));
  }

  //! update favourite lab test

  Future<String> updateFavouriteLabTest({
    required String labTestId,
  }) async {
    String basePath = "updateFavoriteLabs";

    final body = {
      "labtest_id": labTestId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return response.body;
  }

  //! delete recently search lab test

  Future<String> deleteRecentlySearchLabTest({
    required String labtestId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "doctor/deleteLabTestHistory";
    final body = {
      "doctor_id": doctorId,
      "labtest_id": labtestId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: body);
    log(body.toString());
    return response.body;
  }

  //! search scan test

  Future<SearchLabTestModel> getAllScanTest({
    required String searchQuery,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "scan-tests";
    final body = {"user_id": doctorId, "search": searchQuery};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return SearchLabTestModel.fromJson(json.decode(response.body));
  }

  //! update favourite scan test

  Future<String> updateFavouriteScanTest({
    required String scanTestId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    String basePath = "scan-tests/fav";

    final body = {
      "user_id": doctorId,
      "scan_test_id": scanTestId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return response.body;
  }

  //! delete recently search scan test

  Future<String> deleteRecentlySearchScanTest({
    required String historyId,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "scan-tests/delete";
    final body = {
      "doctor_id": doctorId,
      "scan_test_id": historyId,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return response.body;
  }
}

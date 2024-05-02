import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointments_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/add_prescription_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:mediezy_doctor/Repositary/Api/MultiFileApiClient2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppointmentApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient2 multiFileApiClient = MultiFileApiClient2();

  //!appointment details api

  Future<AppointmentDetailsPageModel> getAppointmentDetailsPage(
      {required String tokenId}) async {
    String basePath = "doctor/getAllAppointmentDetails/$tokenId";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    // print(body);
    log("respose === : ${response.body}");
    print("<<<<<<<<<<Book Appointment Details page response worked>>>>>>>>>>");
    return AppointmentDetailsPageModel.fromJson(json.decode(response.body));
  }

  //! Add prescription api

  Future<AddPrescriptionModel> getAddPresscription({
    required String medicineName,
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
    print(body);
    print("<<<<<<<<<<Add prescription response worked>>>>>>>>>>");
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
    print(body);
    print("<<<<<<<<<<Edit prescription response worked>>>>>>>>>>");
    return response.body;
  }

  //* get all appointments as per date

  Future<GetAllAppointmentsModel> getAllApointmentsAsPerDate({
    required String date,
    required String clinicId,
    required String scheduleType,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath =
        "doctor/getallappointments/$id/$date/$clinicId/$scheduleType";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
          log("respose ste1 === : ${response.body}");
    print("<<<<<< Get All Appointments Are Worked >>>>>>");
    return GetAllAppointmentsModel.fromJson(json.decode(response.body));
  }

  //* get all completed appointments as per date

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
    print("<<<<<< Get All completed Appointments Are Worked >>>>>>");
    return GetAllCompletedAppointmentsModel.fromJson(
        json.decode(response.body));
  }

  //delete medicine api

  Future<String> deleteMedicine({
    required String medicineId,
  }) async {
    String basePath = "docter/medicine/$medicineId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "DELETE", body: null);
    print("<<<<<< Delete medicine Worked >>>>>>");
    return response.body;
  }

  //! Save all appointment details api

  Future<String> addAllAppointmentDetails(
    File? attachment, {
    required String tokenId,
    required String labId,
    required String labTest,
    required String medicalshopId,
    required String reviewAfter,
    required String notes,
    required String scanId,
    required String scanTest,
  }) async {
    String basePath = "docter/AddTestDetails";

    final body = {
      "token_id": tokenId,
      "lab_id": labId,
      "labtest": labTest,
      "medical_shop_id": medicalshopId,
      "prescription_image": attachment,
      "ReviewAfter": reviewAfter,
      "notes": notes,
      "scan_id":   scanId,
      "scan_test": scanTest,
    };
    Response response = attachment == null
        ? await apiClient.invokeAPI(path: basePath, method: "POST", body: body)
        : await multiFileApiClient.uploadFiles(
            files: attachment, uploadPath: basePath, bodyData: body);
    print(body);
    print("<<<<<<<<<<Add All Appointments response worked>>>>>>>>>>");
    return response.body;
  }


  //* get all Completed AppointmentDetails

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
    print(body);
    print("<<<<<<<<<<Get all Completed AppointmentDetails response worked>>>>>>>>>>");
    return GetAllCompletedAppointmentDetailsModel.fromJson(
        json.decode(response.body));
  }

  //* Add Vitals Api

  Future<String> addVitals(
    {
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
    print(body);
    return response.body;
  }

  //* edit Vitals Api

  Future<String> editVitals(
      {
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
    print(body);
    return response.body;
  }


  //* delete Vitals Api

  Future<String> deleteVitals(
      {
        required String tokenId,
      }) async {
    String basePath = "deleteVitals";

    final body = {
      "token_id": tokenId,
    };
    Response response =
    await apiClient.invokeAPI(path: basePath, method: "DELETE", body: body);
    print(body);
    return response.body;
  }
}

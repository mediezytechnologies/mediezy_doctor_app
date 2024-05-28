import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentApi {
  ApiClient apiClient = ApiClient();

  Future<String> bookAppointment({
    required String patientName,
    required String clinicId,
    required String date,
    required String regularmedicine,
    required String whenitcomes,
    required String whenitstart,
    required String tokenTime,
    required String tokenNumber,
    required String gender,
    required String age,
    required String mobileNo,
    required String scheduleType,
    required List<String> appoinmentfor1,
    required List<int> appoinmentfor2,
  }) async {
    String basePath = "patient/patientBookGeneratedTokens";
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    final body = {
      "BookedPerson_id": doctorId,
      "PatientName": patientName,
      "date": date,
      "regularmedicine": regularmedicine,
      "whenitcomes": whenitcomes,
      "whenitstart": whenitstart,
      "TokenTime": tokenTime,
      "TokenNumber": tokenNumber,
      "MobileNo": mobileNo,
      "age": age,
      "gender": gender,
      "Appoinmentfor1": appoinmentfor1,
      "Appoinmentfor2": appoinmentfor2,
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "schedule_type": scheduleType,
      "reschedule_type": "0"
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Book Appointment Successfully>>>>>>>>>>");
    return response.body;
  }

  //! symptoms get api

  Future<GetSymptomsModel> getSymptoms() async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    String basePath = "symptoms/$doctorId";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<<<<<<Get Symtoms Successfully>>>>>>>>>>");
    return GetSymptomsModel.fromJson(json.decode(response.body));
  }
}

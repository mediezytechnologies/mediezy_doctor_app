import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/Previous_appointment_details_model.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviousAppointmentsApi {
  ApiClient apiClient = ApiClient();

  Future<PreviousAppointmentsModel> getAllPreviousAppointments({
    required String date,
    required String clinicId,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "previous-appointments";
    final body = {"doctor_id": id, "clinicId": clinicId, "date": date};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<Get all previous prescription response worked>>>>>>>>>>");
    return PreviousAppointmentsModel.fromJson(json.decode(response.body));
  }

  // previous appointment details api

  Future<PreviousAppointmentDetailsModel> getAllPreviousAppointmentDetails({
    required String patientId,
    required String appointmentId,
  }) async {
    String basePath = "PreviousPatient-AppoitmentsDetails";
    final body = {
      "booked_user_id": patientId,
      "appointment_id": appointmentId
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    return PreviousAppointmentDetailsModel.fromJson(json.decode(response.body));
  }
}

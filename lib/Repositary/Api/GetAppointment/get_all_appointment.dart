import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/GetAppointments/get_appointments_model.dart';

class GetAllAppointmentGetxService {
  static Future<List<BookingData>?> getAllAppointmentGetxService({
    required String date,
    required String clinicId,
    required String scheduleType,
  }) async {
    try {
     String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
      final token = preference.getString('token') ?? preference.getString('tokenD');
    String basePath = "${basePathUrl}doctor/getAllUserAppointments";
      var formData = {"userId": id,
      "date": date,
      "clinicId": clinicId,
      "schedule_type": scheduleType};

      var response = await Dio(BaseOptions( headers: {'Authorization': 'Bearer $token'},
      contentType: 'application/json',))
      .post("$basePath"
        , data: formData);
      GetAppointmentsModel? model = GetAppointmentsModel.fromJson(response.data);
      log(formData.toString());
      log(model.toString());
      log("res ${response.data}");
      return model.bookingData;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log("${e.response!.data}===========");
      log("${e.message}=fdsfg=fd");
    }
    return null;
  }
}

 
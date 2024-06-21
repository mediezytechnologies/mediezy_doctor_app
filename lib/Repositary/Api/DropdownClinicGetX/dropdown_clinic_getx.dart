import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/schedule_deopdown_model/schadule_dropdown_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalService {
  static Future<List<HospitalDetails>?> hospitalService() async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();
    log(">>>>>>>>>>>>>>>>>>>>?????????$doctorId");
    final token =
        preference.getString('token') ?? preference.getString('tokenD');
    log("tok $token!");
    log(" doc id : $doctorId");
    try {
      var response = await Dio(BaseOptions(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/x-www-form-urlencoded',
      )).get(
        // "https://test.mediezy.com/api/get-hospital-name/$doctorId",
        "${basePathUrl}get-hospital-name/$doctorId",
      );
      ClinicGetModel? model = ClinicGetModel.fromJson(response.data);
      log(doctorId);
      log(model.toString());
      log("res ${response.data}");
      return model.hospitalDetails;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log("6656566565656556565  dist");
      log("${e.response!.data}===========");
      log("${e.message}=fdsfg=fd");
    } catch (e) {
      log("$e");
    }
    return null;
  }
}

//controller..

class HospitalController extends GetxController {
  RxBool loding = true.obs;
  RxString initialIndex ="".obs;
  var scheduleIndex = '0'.obs;

  RxList<HospitalDetails>? hospitalDetails = <HospitalDetails>[].obs;

  Future<List<HospitalDetails>?> gethospitalService() async {
    try {
      var data = await HospitalService.hospitalService();
      update();
      loding.value = false;
      hospitalDetails!.value = data!;
      update();
      initialIndex.value = hospitalDetails!.first.clinicId.toString();
      update();
      return hospitalDetails!;
    } catch (e) {
      Get.snackbar('warnig', 'Please check Internet Connection');
      log(e.toString());
      log('catch bloc called');
      loding.value = false;
    }
    return null;
  }

  // schedule//=====
   var selectedDate = DateTime.now().obs;
  List<SchedulDropdowneModel> scheduleData = [
    SchedulDropdowneModel(scheduleId: '0', scheduleName: "All"),
    SchedulDropdowneModel(scheduleId: '1', scheduleName: "Schedule 1"),
    SchedulDropdowneModel(scheduleId: '2', scheduleName: "Schedule 2"),
    SchedulDropdowneModel(scheduleId: '3', scheduleName: "Schedule 3"),
  ];

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate.value);
    return formattedSelectedDate;
  }

  dropdownValueChanging(String value, String checkingValue) {
    if (checkingValue == initialIndex.value) {
      log("before  :: ${initialIndex.value}");
      initialIndex.value = value;
      //  update();
    } else if (checkingValue == '0') {
      scheduleIndex.value = value;
      log(scheduleIndex.toString());
      update();
    }
    update();
  }

  @override
  void onInit() {
    gethospitalService();

    update();

    super.onInit();
  }
}

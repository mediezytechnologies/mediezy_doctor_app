import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/GetAppointments/get_appointments_model.dart';
import '../Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../Api/GetAppointment/get_all_appointment.dart';

class GetAllAppointmentController extends GetxController {
  
  final HospitalController hospitalController = Get.put(HospitalController());
  RxBool loding = true.obs;
  var selectedIndex = 0.obs;
  RxList<BookingData> bookingData = <BookingData>[].obs;

 Future<void> getAllAppointmentGetxController({
  required String date,
  required String clinicId,
  required String scheduleType,
}) async {
  try {
    //loding.value = true;
    var data = await GetAllAppointmentGetxService.getAllAppointmentGetxService(
      date: date,
      clinicId: clinicId,
      scheduleType: scheduleType,
    );
    if (data != null) {
      bookingData.value = data;
      update(); // Add this line to notify listeners
    }
  } catch (e) {
    log('Error fetching medicine: $e');
  } finally {
    loding.value = false;
    update(); // Add this line to notify listeners
  }
}

  @override
  void onInit() {
    // getAllAppointmentGetxController( date: hospitalController.formatDate(),
    //       clinicId: hospitalController.initialIndex.value,
    //       scheduleType: hospitalController.scheduleIndex.value,);
    //getMedicine();
    super.onInit();
  }
}

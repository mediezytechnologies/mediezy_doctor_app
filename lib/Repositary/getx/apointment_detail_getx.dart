
import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import '../Api/BookAppointment/book_appointment_lab_dropdown.dart';

class BookingAppointmentLabController extends GetxController {
  RxBool loding = true.obs;
  String? initialIndex;
  var scheduleIndex = '0'.obs;

  RxList<Favoritemedicalshop>? hospitalDetails = <Favoritemedicalshop>[].obs;

  Future<List<Favoritemedicalshop>?> gethospitalService() async {
    try {
      var data = await BookAppointLabDropdown.getScanListService();
      update();
      loding.value = false;
      hospitalDetails!.value = data!;
      update();
      initialIndex = hospitalDetails!.first.id.toString();
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
  
  

  

  dropdownValueChanging(String value, String checkingValue) {
    if (checkingValue == initialIndex) {
      log("before  :: ${initialIndex!}");
      initialIndex = value;
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
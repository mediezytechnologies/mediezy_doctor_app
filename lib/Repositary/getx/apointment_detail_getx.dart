
import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import '../Api/BookAppointment/book_appointment_lab_dropdown.dart';

class BookingAppointmentLabController extends GetxController {
  RxBool loding = true.obs;
  String? initialIndex;
  var scheduleIndex = '0'.obs;
  var tempList=["Select scanning centre"];

  RxList<Favoritemedicalshop>? favoritemedicalshop = <Favoritemedicalshop>[].obs;

  Future<List<Favoritemedicalshop>?> gethospitalService() async {
    try {
      var data = await BookAppointLabDropdown.getScanListService();
      update();
      loding.value = false;
      favoritemedicalshop!.value = data!;
      update();
      tempList= favoritemedicalshop!.value;
     // initialIndex = favoritemedicalshop!.first.id.toString();
      update();
      return favoritemedicalshop!;
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
    if (checkingValue == "Select scanning centre") {
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
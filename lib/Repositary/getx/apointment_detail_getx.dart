import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/Labs/get_all_favourite_lab_model.dart';
import '../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import '../Api/BookAppointment/book_appointment_lab_dropdown.dart';

class BookingAppointmentLabController extends GetxController {
  RxBool loding = true.obs;
  RxBool scanLoding = true.obs;
  String? initialMedicalStoreIndex;
  String? initialSelectLabIndex;
  String? initialScaningCenerIndex;
  //var scheduleIndex = '0'.obs;
  final tempScanList = <Favoritemedicalshop>{
    Favoritemedicalshop(laboratory: "Select medical store", id: 0)
  }.obs;


  final tempLabList =
      <FavoriteLabs>{FavoriteLabs(laboratory: "Select lab", id: 0)}.obs;


  final tempScanCenterList = <FavoriteLabs>{
    FavoriteLabs(laboratory: "Select scanning centre", id: 0)
  }.obs;
  RxList<Favoritemedicalshop>? favoritemedicalshop =
      <Favoritemedicalshop>[].obs;
  RxList<FavoriteLabs>? favoriteLabs = <FavoriteLabs>[].obs;
//scan center center
  Future<List<Favoritemedicalshop>?> getMedicalStoreController() async {
    try {
      var data = await BookAppointLabDropdown.getMedicalStoreService();
     // update();
      loding.value = false;
      favoritemedicalshop!.value = data!;
      update();
      update();
      for (var element in favoritemedicalshop!) {
        log("id : ${element.id}}======  laboratory : ${element.laboratory}");
      }
      return favoritemedicalshop!;
    } catch (e) {
      Get.snackbar('warnig', 'Please check Internet Connection');
      log(e.toString());
      log('catch bloc called');
      loding.value = false;
    }
    return null;
  }

  //medical store
  Future<List<FavoriteLabs>?> getLablController() async {
    try {
      var data = await BookAppointLabDropdown.getScanLabService();
      update();
      scanLoding.value = false;
      favoriteLabs!.value = data!;
      update();
      update();

      return favoriteLabs!;
    } catch (e) {
      Get.snackbar('warnig', 'Please check Internet Connection');
      log(e.toString());
      log('catch bloc called');
      scanLoding.value = false;
    }
    return null;
  }
  

  addtoTembList() {
    tempScanList.addAll(favoritemedicalshop!);
    for (var temp in tempScanList) {
      log("111111 id : ${temp.id}}====== 11111111 laboratory : ${temp.laboratory}");
      initialMedicalStoreIndex = tempScanList.first.id.toString();
      log(initialMedicalStoreIndex.toString());
    }
    tempLabList.addAll(favoriteLabs!);
    for (var temp in tempLabList) {
      log("22222222 id : ${temp.id}}====== 222222222 laboratory : ${temp.laboratory}");
      initialSelectLabIndex = tempLabList.first.id.toString();
      log(initialSelectLabIndex.toString());
    }
    tempScanCenterList.addAll(favoriteLabs!);
    for (var temp in tempScanCenterList) {
      log("3333333 id : ${temp.id}}====== 33333333 laboratory : ${temp.laboratory}");
      initialScaningCenerIndex = tempScanCenterList.first.id.toString();
      log(initialScaningCenerIndex.toString());
    }
    log(tempScanList.toString());
    // initialIndex = tempScanList.first.id.toString();
    update();
  }

  // schedule//=====

  dropdownValueChanging(String value, String checkingValue) {
    if (checkingValue == initialMedicalStoreIndex) {
      log("111111");
      initialMedicalStoreIndex = value;
      //  update();
    } else if (checkingValue == initialSelectLabIndex) {
      log("222222");
      initialSelectLabIndex = value;
      log(initialSelectLabIndex.toString());
      update();
    } else if (checkingValue == initialScaningCenerIndex) {
      log("3333333");
      initialScaningCenerIndex = value;
      log(initialScaningCenerIndex.toString());
      update();
    }
    update();
  }

  @override
  void onInit() {
   getMedicalStoreController();
   getLablController();
    getLablController();
    addtoTembList();

    update();

    super.onInit();
  }
}

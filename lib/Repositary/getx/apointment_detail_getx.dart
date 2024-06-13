import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/Labs/get_all_favourite_lab_model.dart';
import '../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import '../Api/BookAppointment/book_appointment_lab_dropdown.dart';


class BookingAppointmentLabController extends GetxController {
  RxBool loading = true.obs;
  RxBool scanLoading = true.obs;
  RxString initialMedicalStoreIndex = "0".obs;
  RxString initialSelectLabIndex = "0".obs;
  RxString initialScaningCenerIndex = "0".obs;

  RxList<Favoritemedicalshop> favoritemedicalshop = <Favoritemedicalshop>[].obs;
  RxList<FavoriteLabs> favoriteLabs = <FavoriteLabs>[].obs;
  
  RxList<Favoritemedicalshop> tempScanList = <Favoritemedicalshop>[
    Favoritemedicalshop(laboratory: "Select medical store", id: 0)
  ].obs;

  RxList<FavoriteLabs> tempLabList = <FavoriteLabs>[
    FavoriteLabs(laboratory: "Select lab", id: 0)
  ].obs;

  RxList<FavoriteLabs> tempScanCenterList = <FavoriteLabs>[
    FavoriteLabs(laboratory: "Select scanning centre", id: 0)
  ].obs;

  Future<void> getMedicalStoreController() async {
    try {
      loading.value = true;
      var data = await BookAppointLabDropdown.getMedicalStoreService();
      favoritemedicalshop.value = data ?? [];
      updateTempScanList();
    } catch (e) {
      Get.snackbar('warning', 'Please check Internet Connection');
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> getLablController() async {
    try {
      scanLoading.value = true;
      var data = await BookAppointLabDropdown.getScanLabService();
      favoriteLabs.value = data ?? [];
      updateTempLabList();
      updateTempScanCenterList();
    } catch (e) {
      Get.snackbar('warning', 'Please check Internet Connection');
      log(e.toString());
    } finally {
      scanLoading.value = false;
    }
  }

  void updateTempScanList() {
    Set<Favoritemedicalshop> tempSet = {Favoritemedicalshop(laboratory: "Select medical store", id: 0)};
    tempSet.addAll(favoritemedicalshop);
    tempScanList.value = tempSet.toList();
    initialMedicalStoreIndex.value = tempScanList.first.id.toString();
  }

  void updateTempLabList() {
    Set<FavoriteLabs> tempSet = {FavoriteLabs(laboratory: "Select lab", id: 0)};
    tempSet.addAll(favoriteLabs);
    tempLabList.value = tempSet.toList();
    initialSelectLabIndex.value = tempLabList.first.id.toString();
  }

  void updateTempScanCenterList() {
    Set<FavoriteLabs> tempSet = {FavoriteLabs(laboratory: "Select scanning centre", id: 0)};
    tempSet.addAll(favoriteLabs);
    tempScanCenterList.value = tempSet.toList();
    initialScaningCenerIndex.value = tempScanCenterList.first.id.toString();
  }

  void resetToPreviousValue() {
    initialMedicalStoreIndex.value = tempScanList.first.id.toString();
    initialSelectLabIndex.value = tempLabList.first.id.toString();
    initialScaningCenerIndex.value = tempScanCenterList.first.id.toString();
  }

  void dropdownValueChanging(String value, String checkingValue) {
    if (checkingValue == initialMedicalStoreIndex.value) {
      initialMedicalStoreIndex.value = value;
    } else if (checkingValue == initialSelectLabIndex.value) {
      initialSelectLabIndex.value = value;
    } else if (checkingValue == initialScaningCenerIndex.value) {
      initialScaningCenerIndex.value = value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMedicalStoreController();
    getLablController();
  }
}
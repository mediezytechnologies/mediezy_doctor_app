import 'dart:developer';

import 'package:get/get.dart';

import '../../Model/Labs/get_all_favourite_lab_model.dart';
import '../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import '../Api/BookAppointment/book_appointment_lab_dropdown.dart';

// class BookingAppointmentLabController extends GetxController {
//   RxBool loding = true.obs;
//   RxBool scanLoding = true.obs;
//   String? initialMedicalStoreIndex;
//   String? initialSelectLabIndex;
//   String? initialScaningCenerIndex;

//   RxList<Favoritemedicalshop>? favoritemedicalshop =
//       <Favoritemedicalshop>[].obs;
//   RxList<FavoriteLabs>? favoriteLabs = <FavoriteLabs>[].obs;
//   final tempScanList = <Favoritemedicalshop>{
//     Favoritemedicalshop(laboratory: "Select medical store", id: 0)
//   }.obs;

//   final tempLabList =
//       <FavoriteLabs>{FavoriteLabs(laboratory: "Select lab", id: 0)}.obs;

//   final tempScanCenterList = <FavoriteLabs>{
//     FavoriteLabs(laboratory: "Select scanning centre", id: 0)
//   }.obs;

// //scan center center
//   Future<List<Favoritemedicalshop>?> getMedicalStoreController() async {
//     try {
//       var data = await BookAppointLabDropdown.getMedicalStoreService();
     
//       loding.value = false;
//       favoritemedicalshop!.value = data!;
//       update();
//       update();
//       for (var element in favoritemedicalshop!) {
//         log("id : ${element.id}}======  laboratory : ${element.laboratory}");
//       }
//       return favoritemedicalshop!;
//     } catch (e) {
//       Get.snackbar('warnig', 'Please check Internet Connection');
//       log(e.toString());
//       log('catch bloc called');
//       loding.value = false;
//     }
//     return null;
//   }

//   //medical store
//   Future<List<FavoriteLabs>?> getLablController() async {
//     try {
//       var data = await BookAppointLabDropdown.getScanLabService();
//       update();
//       scanLoding.value = false;
//       favoriteLabs!.value = data!;
//       update();
//       update();

//       return favoriteLabs!;
//     } catch (e) {
//       Get.snackbar('warnig', 'Please check Internet Connection');
//       log(e.toString());
//       log('catch bloc called');
//       scanLoding.value = false;
//     }
//     return null;
//   }
//   addtoTembList() async {
//   // Call API
//   await getMedicalStoreController();
//   await getLablController();

//   // List init
//   Set<Favoritemedicalshop> tempScanSet = Set<Favoritemedicalshop>.from(tempScanList);
//   tempScanSet.addAll(favoritemedicalshop!);
//   tempScanList.value = tempScanSet.toList();

//   initialMedicalStoreIndex = tempScanList.first.id.toString();

//   Set<FavoriteLabs> tempLabSet = Set<FavoriteLabs>.from(tempLabList);
//   tempLabSet.addAll(favoriteLabs!);
//   tempLabList.value = tempLabSet.toList();

//   initialSelectLabIndex = tempLabList.first.id.toString();

//   Set<FavoriteLabs> tempScanCenterSet = Set<FavoriteLabs>.from(tempScanCenterList);
//   tempScanCenterSet.addAll(favoriteLabs!);
//   tempScanCenterList.value = tempScanCenterSet.toList();

//   initialScaningCenerIndex = tempScanCenterList.first.id.toString();

//   update();
// }

//   // addtoTembList() {
//   //   //call api
//   //   getMedicalStoreController();
//   //   getLablController();

//   //   //list init
//   //   tempScanList.addAll(favoritemedicalshop!);
//   //   for (var temp in tempScanList) {
//   //     log("111111 id : ${temp.id}}====== 11111111 laboratory : ${temp.laboratory}");
//   //     initialMedicalStoreIndex = tempScanList.first.id.toString();
//   //     log(initialMedicalStoreIndex.toString());
//   //   }
//   //   tempLabList.addAll(favoriteLabs!);
//   //   for (var temp in tempLabList) {
//   //     log("22222222 id : ${temp.id}}====== 222222222 laboratory : ${temp.laboratory}");
//   //     initialSelectLabIndex = tempLabList.first.id.toString();
//   //     log(initialSelectLabIndex.toString());
//   //   }
//   //   tempScanCenterList.addAll(favoriteLabs!);
//   //   for (var temp in tempScanCenterList) {
//   //     log("3333333 id : ${temp.id}}====== 33333333 laboratory : ${temp.laboratory}");
//   //     initialScaningCenerIndex = tempScanCenterList.first.id.toString();
//   //     log(initialScaningCenerIndex.toString());
//   //   }
//   //   log(tempScanList.toString());
//   //   update();
//   // }

//   // dropdown checking//

//     //dropdown initial val
//     void resetToPreviousValue() {
//     initialMedicalStoreIndex =  "Select medical store";
//     initialSelectLabIndex = "Select lab";
//     initialScaningCenerIndex= "Select scanning centre";
//     update();
//   }

//   dropdownValueChanging(String value, String checkingValue) {
//     if (checkingValue == initialMedicalStoreIndex) {
//       log("111111");
//       initialMedicalStoreIndex = value;
//       log("111111 :  $initialMedicalStoreIndex");
//       update();
//     } else if (checkingValue == initialSelectLabIndex) {
//       log("222222");
//       initialSelectLabIndex = value;
//       log("222222 :  $initialSelectLabIndex");

//       update();
//     } else if (checkingValue == initialScaningCenerIndex) {
//       log("3333333");
//       initialScaningCenerIndex = value;
//       log("3333333 :  $initialScaningCenerIndex");
//       update();
//     }
//     update();
//   }


//   @override
//   void onInit() {
//     addtoTembList();

//     update();

//     super.onInit();
//   }
// }


// class BookingAppointmentLabController extends GetxController {
//    RxBool loding = true.obs;
//   RxBool scanLoding = true.obs;
//   String? initialMedicalStoreIndex;
//   String? initialSelectLabIndex;
//   String? initialScaningCenerIndex;

//   RxList<Favoritemedicalshop>? favoritemedicalshop = <Favoritemedicalshop>[].obs;
//   RxList<FavoriteLabs>? favoriteLabs = <FavoriteLabs>[].obs;
  
//   // Change these to RxList
//   final tempScanList = <Favoritemedicalshop>[
//     Favoritemedicalshop(laboratory: "Select medical store", id: 0)
//   ].obs;

//   final tempLabList = <FavoriteLabs>[
//     FavoriteLabs(laboratory: "Select lab", id: 0)
//   ].obs;

//   final tempScanCenterList = <FavoriteLabs>[
//     FavoriteLabs(laboratory: "Select scanning centre", id: 0)
//   ].obs;
//   Future<List<Favoritemedicalshop>?> getMedicalStoreController() async {
//     try {
//       var data = await BookAppointLabDropdown.getMedicalStoreService();
//       loding.value = false;
//       favoritemedicalshop!.value = data!;
//       update();
//       for (var element in favoritemedicalshop!) {
//         log("id : ${element.id}}======  laboratory : ${element.laboratory}");
//       }
//        log(' ${favoritemedicalshop!.length}e======================================');
//       log('======================================');
//       return favoritemedicalshop!;
//     } catch (e) {
//       Get.snackbar('warning', 'Please check Internet Connection');
//       log(e.toString());
//       log('catch bloc called');
//       loding.value = false;
//     }
//     return null;
//   }

//   Future<List<FavoriteLabs>?> getLablController() async {
//     try {
//       var data = await BookAppointLabDropdown.getScanLabService();
//       scanLoding.value = false;
//       favoriteLabs!.value = data!;
//       update();
//       return favoriteLabs!;
//     } catch (e) {
//       Get.snackbar('warning', 'Please check Internet Connection');
//       log(e.toString());
//       log('catch bloc called');
//       scanLoding.value = false;
//     }
//     return null;
//   }

//  addtoTembList() async {
//     // Call API
//     await getMedicalStoreController();
//     await getLablController();

//     // List init
//     Set<Favoritemedicalshop> tempScanSet = Set<Favoritemedicalshop>.from(tempScanList);
//     tempScanSet.addAll(favoritemedicalshop!);
//     tempScanList.value = tempScanSet.toList();

//     initialMedicalStoreIndex = tempScanList.first.id.toString();
//     log("Initial Medical Store Index: $initialMedicalStoreIndex");

//     Set<FavoriteLabs> tempLabSet = Set<FavoriteLabs>.from(tempLabList);
//     tempLabSet.addAll(favoriteLabs!);
//     tempLabList.value = tempLabSet.toList();

//     initialSelectLabIndex = tempLabList.first.id.toString();
//     log("Initial Select Lab Index: $initialSelectLabIndex");

//     Set<FavoriteLabs> tempScanCenterSet = Set<FavoriteLabs>.from(tempScanCenterList);
//     tempScanCenterSet.addAll(favoriteLabs!);
//     tempScanCenterList.value = tempScanCenterSet.toList();

//     initialScaningCenerIndex = tempScanCenterList.first.id.toString();
//     log("Initial Scanning Center Index: $initialScaningCenerIndex");

//     update();
//   }

//   void resetToPreviousValue() {
//     initialMedicalStoreIndex = tempScanList.first.id.toString();
//     initialSelectLabIndex = tempLabList.first.id.toString();
//     initialScaningCenerIndex = tempScanCenterList.first.id.toString();
//     update();
//   }

//   dropdownValueChanging(String value, String checkingValue) {
//     if (checkingValue == initialMedicalStoreIndex) {
//       log("Changing Medical Store");
//       initialMedicalStoreIndex = value;
//       log("New Medical Store Index: $initialMedicalStoreIndex");
//     } else if (checkingValue == initialSelectLabIndex) {
//       log("Changing Select Lab");
//       initialSelectLabIndex = value;
//       log("New Select Lab Index: $initialSelectLabIndex");
//     } else if (checkingValue == initialScaningCenerIndex) {
//       log("Changing Scanning Center");
//       initialScaningCenerIndex = value;
//       log("New Scanning Center Index: $initialScaningCenerIndex");
//     }
//     update();
//   }

//   @override
//   void onInit() {
//     addtoTembList();
//     super.onInit();
//   }
// }
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
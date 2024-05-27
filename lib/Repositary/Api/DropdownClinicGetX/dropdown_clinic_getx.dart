import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/schedule_deopdown_model/schadule_dropdown_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/appointment_demo_model.dart';

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
     "https://test.mediezy.com/api/get-hospital-name/$doctorId",
   //"https://mediezy.com/api/get-hospital-name/$doctorId",
      );
      ClinicGetModel? model = ClinicGetModel.fromJson(response.data);
      log(doctorId);
      log(model.toString());
      log("res ${response.data}");
      return model.hospitalDetails;
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
  String? initialIndex;
  var scheduleIndex = '0'.obs;
 
  RxList<HospitalDetails>? hospitalDetails = <HospitalDetails>[].obs;

  Future<List<HospitalDetails>?> gethospitalService() async {
    try {
      var data = await HospitalService.hospitalService();
      update();
      loding.value = false;
      hospitalDetails!.value = data!;
      update();
      initialIndex = hospitalDetails!.first.clinicId.toString();
      // log("initial index === ${initialIndex.toString()}");
      // log("initial date === ${formatDate()}");
      // log("initial value === ${scheduleIndex.value}");
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
  DateTime selectedDate = DateTime.now();
  List<SchedulDropdowneModel> scheduleData = [
    SchedulDropdowneModel(scheduleId: '0', scheduleName: "All"),
    SchedulDropdowneModel(scheduleId: '1', scheduleName: "Schedule 1"),
    SchedulDropdowneModel(scheduleId: '2', scheduleName: "Schedule 2"),
    SchedulDropdowneModel(scheduleId: '3', scheduleName: "Schedule 3"),
  ];




  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

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



// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../Model/GenerateToken/clinic_get_model.dart';

// class HospitalService {
//   static Future<List<HospitalDetails>?> hospitalService() async {
//     String? id;
//     final preference = await SharedPreferences.getInstance();
//     id = preference.getString('DoctorId').toString();
//     log(id);
//     final token = preference.getString('token') ??
//         preference.getString('tokenD') ??
//         "1114|1obyI5DJ6864AdalqYkFxqUMnKG2KLdbv2KSoQ0I2addae12";
//     // String basePath = ;
//     log("tok $token!");
//     try {
//       var response = await Dio(BaseOptions(
//         headers: {'Authorization': 'Bearer $token'},
//         contentType: 'application/x-www-form-urlencoded',
//       )).get(
//         "https://mediezy.com/api/get-hospital-name/2",
//       );
//       ClinicGetModel? model = ClinicGetModel.fromJson(response.data);
//       print(id);
//       log(model.toString());
//       log("res ${response.data}");
//       return model.hospitalDetails;
//     } on DioError catch (e) {
//       print("6656566565656556565  dist");
//       print("${e.response!.data}===========");
//       print("${e.message}=fdsfg=fd");
//     } catch (e) {
//       print("$e");
//     }
//     return null;
//   }
// }

// //controller..

// class HospitalController extends GetxController {
//   RxBool loding = true.obs;
//   String? initialIndex;
//   RxList<HospitalDetails>? hospitalDetails = <HospitalDetails>[].obs;

//   Future<List<HospitalDetails>?> gethospitalService() async {
//     try {
//       var data = await HospitalService.hospitalService();
//       loding.value = false;
//       hospitalDetails!.value = data!;
//       initialIndex = hospitalDetails!.first.clinicName.toString();
//       return hospitalDetails!;
//     } catch (e) {
//       Get.snackbar('warnig', 'Please check Internet Connection');
//       print(e);
//       print('catch bloc called');
//       loding.value = false;
//     }
//     return null;
//   }

//   dropdownValueChanging(String value, String checkingValue) {
//     if (checkingValue == initialIndex) {
//       log("before  :: ${initialIndex!}");
//       initialIndex = value;
//       log("after  :: ${initialIndex!}");
//       update();
//     }
//     update();
//   }

//   @override
//   void onInit() {
//     gethospitalService();

//     super.onInit();
//   }
// }

// class D extends StatefulWidget {
//   D({super.key});

//   @override
//   State<D> createState() => _DState();
// }

// class _DState extends State<D> {
//   final HospitalController controller = Get.put(HospitalController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           HospitalService.hospitalService();
//         },
//       ),
//       appBar: AppBar(),
//       body: Obx(() {
//         if (controller.loding.value) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return Column(
//           children: [
//             GetBuilder<HospitalController>(builder: (context) {
//               return DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   elevation: 6,
//                   borderRadius: BorderRadius.circular(20),
//                   // alignment: AlignmentDirectional.center,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600, color: Colors.black),
//                   value: controller.initialIndex,
//                   icon: const Icon(
//                     Icons.keyboard_arrow_down,
//                   ),
//                   items: controller.hospitalDetails!.map((e) {
//                     return DropdownMenuItem(
//                       child: Text(e.clinicName!),
//                       value: e.clinicName.toString(),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     log(newValue!);
//                     controller.dropdownValueChanging(
//                         newValue, controller.initialIndex!);
//                     // controller.initialIndex = value;
//                   },
//                 ),
//               );
//             }),
//           ],
//         );
//       }),
//     );
//   }
// }
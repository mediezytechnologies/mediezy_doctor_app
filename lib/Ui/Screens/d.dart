// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../Model/GenerateToken/clinic_get_model.dart';
//
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
//         "{https://mediezy.com/api/get-hospital-name/2}",
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
//
// //controller..
//
// class HospitalController extends GetxController {
//   RxBool loding = true.obs;
//   String? initialIndex;
//   RxList<HospitalDetails>? hospitalDetails = <HospitalDetails>[].obs;
//
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
//
//   dropdownValueChanging(String value, String checkingValue) {
//     if (checkingValue == initialIndex) {
//       log("before  :: ${initialIndex!}");
//       initialIndex = value;
//       log("after  :: ${initialIndex!}");
//       update();
//     }
//     update();
//   }
//
//   @override
//   void onInit() {
//     gethospitalService();
//
//     super.onInit();
//   }
// }
//
// class D extends StatefulWidget {
//   D({super.key});
//
//   @override
//   State<D> createState() => _DState();
// }
//
// class _DState extends State<D> {
//   final HospitalController controller = Get.put(HospitalController());
//
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
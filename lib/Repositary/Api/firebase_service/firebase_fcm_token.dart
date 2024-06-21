// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class NotificationService {
//   static Future<dynamic> fcmTokenData() async {
//         final preference = await SharedPreferences.getInstance();
//     String? fcmToken = preference.getString('fcmToken');
//      String?  doctorId = preference.getString('DoctorId').toString();
//     try {
//       log("fcm tok == $fcmToken");
//       log("doctorId  == $doctorId");
//       var response = await Dio().post(
//         "${basePathUrl}reciveFCMToken",
//         data: {
//           "fcm_token": fcmToken,
//           "user_id": doctorId,
//         },
//       );
//      log('===== ${response.data}');
//       return "FCM token updated successfully";
//       // ignore: deprecated_member_use
//     } on DioError catch (e) {
//       log(e.message.toString());
//     } catch (e) {
//       log(e.toString());
//     }
//     return null;
//   }
// }
// // class RemarkService {
// //   static Future<dynamic> remarkService({
// //     required String surveyId,
// //     required String remarks,
// //   }) async {
// //     String? token = GetLocalStorage.getUserIdAndToken('token');
// //     try {
// //       var response = await DioClient.dio.post(
// //         '/save_remark',
// //         data: {
// //           "survey_id": surveyId,
// //           "remarks": remarks,
// //         },
// //         options: Options(
// //           headers: {"Authorization": "Bearer $token"},
// //         ),
// //       );

// //       print(response.data);

// //       return "success";
// //     } on DioError catch (e) {
// //       print("Dio error");
// //       print("${e.error}==ii");
// //       print("${e.message}==ieeei");
// //       print("${e.response!.data}==errors");
// //       print(e.response!.statusMessage);
// //         Get.snackbar(
// //         'Warning',
// //        'SocketException',
// //         backgroundColor: yellow,
// //       );

// //       Get.snackbar(
// //         'Warning',
// //         e.response!.data['SocketException'].toString(),
// //         backgroundColor: yellow,
// //       );


// //       if (e.type == DioErrorType.other) {
// //         Get.snackbar(
// //           'Warning',
// //           'No internet connection.',
// //           backgroundColor: white,
// //         );

// //         return "No internet connection";
// //       }

// //       if (e.response != null) {
// //         return e.response!.data['message'];
// //       }
// //       return "flase";
// //     } catch (e) {
// //       print(e);
// //     } on SocketException {
// //       throw "no net work";
// //     }
// //     return null;
// //   }
// import 'dart:developer';
// import 'package:http_parser/http_parser.dart';

// import 'package:dio/dio.dart';
// import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditProfileApi {
//   Future<Map<String, dynamic>>? editProfileApi({
//     required String firstname,
//     required String secondname,
//     required String mobileNo,
//     String? attachment,
//   }) async {
//     final preference = await SharedPreferences.getInstance();
//     String? token =
//         preference.getString('token') ?? preference.getString('tokenD');
//     String? id;
//     id = preference.getString('DoctorId').toString();
//     String apiUrl = "${ApiClient.basePath}docter/doctor_update/$id";
//     MultipartFile? addMemberImage;
//     try {
//       if (attachment != null) {
//         log(attachment);
//         addMemberImage = await MultipartFile.fromFile(
//           attachment,
//           filename: attachment,
//           contentType: MediaType('image', 'jpg'),
//         );
//       }

//       FormData formData = FormData.fromMap({
//         "firstname": firstname,
//         "lastname": secondname,
//         "mobileNo": mobileNo,
//         "docter_image": attachment,
//       });
//       log("formData ============$addMemberImage");
//       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${formData.toString()}");

//       for (var field in formData.fields) {
//         log("${field.key}: ${field.value}");
//       }

//       for (var file in formData.files) {
//         log("${file.key}: ${file.value.filename}");
//       }

//       final response = await Dio(BaseOptions(
//         headers: {'Authorization': 'Bearer $token'},
//         contentType: 'application/json',
//       )).post(
//         apiUrl,
//         data: formData,
//       );
//       log(response.data.toString());

//       final result = response.data;

//       log("result : $result");

//       return response.data as Map<String, dynamic>;
//     } on DioException catch (e) {
//       log(e.toString());
//       log("Dio error");
//       log(e.response?.data);
//       log("${e.error}==ii");
//       log("${e.message}==ieeei");
//       log("${e.response!.data}==errors");
//       log(e.response!.statusMessage.toString());

//       return {};
//     } catch (e) {
//       log(e.toString());
//     }
//     return {};
//   }
// }

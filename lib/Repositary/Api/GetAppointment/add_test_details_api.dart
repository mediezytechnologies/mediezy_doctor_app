import 'dart:developer';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveaAllApontmentDetailsServicce {
  Future<Map<String, dynamic>>? addAllApontmentDetailsList({
    required String tokenId,
    required String labId,
    required List<String?> labTestId,
    required String medicalshopId,
    required String reviewAfter,
    required String notes,
    required String scanId,
    required List<String?> scanTestId,
    String? attachment,
  }) async {
    final preference = await SharedPreferences.getInstance();
    String? token =
        preference.getString('token') ?? preference.getString('tokenD');
    String apiUrl = "${ApiClient.basePath}docter/AddTestDetails";
    MultipartFile? addMemberImage;
    try {
      if (attachment != null) {
        log(attachment);
        addMemberImage = await MultipartFile.fromFile(
          attachment,
          filename: attachment,
          contentType: MediaType('image', 'jpg'),
        );
      }

      log("message:$scanTestId");
      FormData formData = FormData.fromMap({
        "token_id": tokenId,
        "lab_id": labId,
        "labtest_id[]": labTestId,
        "medical_shop_id": medicalshopId,
        "prescription_image": addMemberImage,
        "ReviewAfter": reviewAfter,
        "notes": notes,
        "scan_id": scanId,
        "scantest_id[]": scanTestId,
      });
      log("formData ============$addMemberImage");
      log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${formData.toString()}");

      for (var field in formData.fields) {
        log("${field.key}: ${field.value}");
      }

      for (var file in formData.files) {
        log("${file.key}: ${file.value.filename}");
      }

      final response = await Dio(BaseOptions(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/json',
      )).post(
        apiUrl,
        data: formData,
      );
      log(response.data.toString());

      final result = response.data;

      log("result : $result");

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log(e.toString());
      log("Dio error");
      log(e.response?.data);
      log("${e.error}==ii");
      log("${e.message}==ieeei");
      log("${e.response!.data}==errors");
      log(e.response!.statusMessage.toString());

      return {};
    } catch (e) {
      log(e.toString());
    }
    return {};
  }
}

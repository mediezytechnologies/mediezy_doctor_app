import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MultiFileApiClient {
  Future<http.Response> uploadFiles({
    required List<File> files,
    required String uploadPath,
    required Map<String, dynamic>? bodyData,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? prefs.getString('tokenD');
    Map<String, String> headerParams = {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
    };

    log('token: $token');
    log('Upload Path: $uploadPath');

    final String basePath = "https://mediezy.com/api/";

    var request =
        http.MultipartRequest('POST', Uri.parse(basePath + uploadPath));
    request.headers.addAll(headerParams);

    log("Request URL: ${request.url}");

    for (int i = 0; i < files.length; i++) {
      var multipartFile =
          await http.MultipartFile.fromPath("files", files[i].path);
      request.files.add(multipartFile);
    }

    if (bodyData != null) {
      bodyData.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        } else {
          request.fields[key] = value.toString();
        }
      });
    }

    try {
      http.StreamedResponse res = await request.send();
      log("Response: $res");

      http.Response responsed = await http.Response.fromStream(res);
      log("Response Status Code: ${responsed.statusCode}");
      log("Response Body: ${responsed.body}");

      final responseData = json.decode(responsed.body);

      if (responsed.statusCode == 200) {
        log('Success');
        log(responseData);
      } else {
        log('Error');
      }

      log("Reason: $res");
      return responsed;
    } catch (e) {
      log('Error during request: $e');
      return http.Response('Error during request: $e', 500);
    }
  }
}

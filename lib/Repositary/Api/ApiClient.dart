import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ApiException.dart';

class ApiClient {
 //static const String basePath = "https://mediezy.com/api/";
  static const String basePath = "https://test.mediezy.com/api/";

  String orignalToken = '';
  Future<Response> invokeAPI(
      {required String path,
      required String method,
      required Object? body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? prefs.getString('tokenD');

    print(prefs.getString('token'));
    print("Invoke Api worked");
    print(method);
    print(token);
    Map<String, String> headerParams = {};
    if (method == 'POST' || method == 'GET' || method == 'PATCH') {
      print("Methode POST OR GET");
      headerParams = {
        "authorization": "Bearer $token",
        'Accept': 'application/json',
        // 'Content-Type': 'application/json'
        "content-type": "multipart/form-data"
      };
      print(jsonEncode(body));
    }
    Response response;
    String url = basePath + path;
    print('========================================$url');

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: {
              "authorization": "Bearer $token",
              'Content-Type': 'application/json'
            },
            body: jsonEncode(body));
        break;
      case "PUT":
        response = await put(Uri.parse(url),
            headers: {
              'content-Type': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
              "authorization": "Bearer $token",
            },
            body: body);
        break;
      case "DELETE":
        response = await delete(Uri.parse(url),
            headers: {
              "authorization": "Bearer $token",
              'Content-Type': 'application/json'
            },
            body: jsonEncode(body));
        break;
      case "PATCH":
        response = await patch(Uri.parse(url),
            headers: {
              "authorization": "Bearer $token",
              'Content-Type': 'application/json'
            },
            body: jsonEncode(body));
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body,
        );
        break;
      case "PUT_":
        response = await post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      default:
        response = await get(Uri.parse(url), headers: nullableHeaderParams);
    }
    print('status of $path =>${response.statusCode}');
    print(response.body);
    print(response.headers);
    if (response.statusCode >= 400) {
      log('$path : ${response.statusCode} : ${response.body}');

      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers["content-type"];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}

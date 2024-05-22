import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileEditModel.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:mediezy_doctor/Repositary/Api/MultiFileApiClient3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileGetApi {
  ApiClient apiClient = ApiClient();
  MultiFileApiClient3 multiFileApiClient = MultiFileApiClient3();

  Future<ProfileGetModel> getProfileGet() async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    // String basePath = "docter/3";
    String basePath = "getDoctorProfileDetails/$id";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);

    log("doctor get response worked");
    return ProfileGetModel.fromJson(json.decode(response.body));
  }

  //profile edit api
  Future<ProfileEditModel> getProfileEdit({
    required String firstname,
    required String secondname,
    required String mobileNo,
    required File? attachment,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    // String basePath = "docter/3";
    String basePath = "docter/doctor_update/$id";

    final body = {
      "firstname": firstname,
      "lastname": secondname,
      "mobileNo": mobileNo,
      "docter_image": attachment,
    };

    Response response = attachment == null
        ? await apiClient.invokeAPI(path: basePath, method: "POST", body: body)
        : await multiFileApiClient.uploadFiles(
            files: attachment, uploadPath: basePath, bodyData: body);
    log(">>>>>>>>$body");
    log("doctor edit response worked");
    return ProfileEditModel.fromJson(json.decode(response.body));
  }
}

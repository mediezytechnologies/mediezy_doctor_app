import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileEditModel.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileGetApi {
  ApiClient apiClient = ApiClient();
  Future<ProfileGetModel> getProfileGet() async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    // String basePath = "docter/3";
    String basePath = "getDoctorProfileDetails/$id";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);

    print("doctor get response worked");
    return ProfileGetModel.fromJson(json.decode(response.body));
  }

  //profile edit api
  Future<ProfileEditModel> getProfileEdit({
    required String firstname,
    required String secondname,
    required String mobileNo,
  }) async {
    String? id;
    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    // String basePath = "docter/3";
    String basePath = "docter/$id";

    final body = {
      "firstname": firstname,
      "lastname": secondname,
      "mobileNo": mobileNo,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${body}");
    print("doctor edit response worked");
    return ProfileEditModel.fromJson(json.decode(response.body));
  }
}

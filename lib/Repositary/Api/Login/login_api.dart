import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/auth/login_model.dart';
import 'package:mediezy_doctor/Model/auth/sign_up_model.dart.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';

class LoginApi {
  ApiClient apiClient = ApiClient();
  Future<LoginModel> getLogin(
      {required String email, required String password}) async {
    String basePath = "auth/login";
    final body = {"email": email, "password": password};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Login Response Worked>>>>>>>>>>");
    return LoginModel.fromJson(json.decode(response.body));
  }

  //signup

  Future<SignupModel> getSignup({
    required String email,
    required String password,
    required String firstname,
    required String secondname,
    required String mobileNo,
  }) async {
    String basePath = "docter";
    final body = {
      "email": email,
      "password": password,
      "firstname": firstname,
      "secondname": secondname,
      "mobileNo": mobileNo,
      "location": "",
      "specification_id": "",
      "subspecification_id": "",
      "specialization_id": "",
      "about": "",
      "service_at": "",
      "gender": "male",
      "hospitals": "",
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Sign Up Response Worked>>>>>>>>>>");
    return SignupModel.fromJson(json.decode(response.body));
  }

  //dummy register api

  Future<String> addDummyRegister({
    required String email,
    required String firstname,
    required String dob,
    required String mobileNo,
    required String location,
    required String hospitalName,
    required String specialization,
    // required String doctorImage,
  }) async {
    String basePath = "docter/doctor_register";
    final body = {
      "email": email,
      "first_name": firstname,
      "dob": dob,
      "mobile_number": mobileNo,
      "location": location,
      "hospital_name": hospitalName,
      "specialization": specialization,
      // "doctor_image":doctorImage,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    return response.body;
  }

  // Future<String> addGuestRegister({
  //   required String email,
  //   required String name,
  //   required String mobileNo,
  // }) async {
  //   String basePath = "doctor/doctor_register_attempt";
  //   final body = {
  //     "email": email,
  //     "name": name,
  //     "mobile_number": mobileNo,
  //   };
  //   Response response =
  //       await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
  //   print(body);
  //   return response.body;
  // }

  //guest register api

  // Future<String> addGuestRegister(
  //     {required String email,
  //       required String firstname,
  //       required String dob,
  //       required String mobileNo,
  //       required String location,
  //       required String hospitalName,
  //       required String specialization,
  //       // required String doctorImage,
  //     }) async {
  //   String basePath = "docter/doctor_register";
  //   final body = {
  //     "email":email,
  //     "first_name":firstname,
  //     "dob":dob,
  //     "mobile_number":mobileNo,
  //     "location":location,
  //     "hospital_name":hospitalName,
  //     "specialization":specialization,
  //     // "doctor_image":doctorImage,
  //   };
  //   Response response =
  //   await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
  //   print(body);
  //   return response.body;
  // }
}

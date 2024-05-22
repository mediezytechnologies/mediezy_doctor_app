import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_labs_model.dart';
import 'package:mediezy_doctor/Model/Labs/search_lab_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabsApi {
  ApiClient apiClient = ApiClient();

  //get all labs
  Future<GetAllLabsModel> getAllLabs() async {
    String basePath = "medicalshop/Lab/getallLabandScanningCenter";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<< Get All Labs Worked >>>>>>");
    return GetAllLabsModel.fromJson(json.decode(response.body));
  }

//add favourites lab

  Future<String> addLabFavourites({
    required String labId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    final body = {"lab_id": labId, "doctor_id": doctorId};
    String basePath = "medicalshop/Lab/addfavLab";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Favourites Lab Added  Successfully>>>>>>>>>>");
    return response.body;
  }

  //Remove favourites lab
  Future<String> removeLabFavourites({
    required String labId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    final body = {"lab_id": labId, "doctor_id": doctorId};
    String basePath = "medicalshop/Lab/RemovefavLab";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Favourites Lab Removed  Successfully>>>>>>>>>>");
    return response.body;
  }

  //* get all favourite labs
  Future<GetAllFavouriteLabModel> getAllFavouriteLabs() async {
    String basePath = "medicalshop/getfavlab";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<< GET ALL FAVOURITE LAB WORKED >>>>>>");
    return GetAllFavouriteLabModel.fromJson(json.decode(response.body));
  }

  //get all scanning centre

  Future<GetAllLabsModel> getAllScanning() async {
    String basePath = "Lab/getallScanningCenter";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<< Get All Labs Worked >>>>>>");
    return GetAllLabsModel.fromJson(json.decode(response.body));
  }

  //Search lab api;

  Future<SearchLabModel> getSearchLabs({
    required String labName,
  }) async {
    final body = {"lab_name": labName};
    String basePath = "medicalshop/Lab/searchLabandScan";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<Search Lab Successfully>>>>>>>>");
    return SearchLabModel.fromJson(json.decode(response.body));
  }

  //Search Scanning centre api;

  Future<SearchLabModel> getSearchScanningCentre({
    required String searchQuery,
  }) async {
    final body = {"scanningCenter_name": searchQuery};
    String basePath = "Lab/searchScanningCenter";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<Search Scanning centre Successfully>>>>>>>>");
    return SearchLabModel.fromJson(json.decode(response.body));
  }
}

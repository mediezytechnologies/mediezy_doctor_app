import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_all_medical_shope_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/search_medical_store_model.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalShoppeApi {
  ApiClient apiClient = ApiClient();
  //get all medical shope
  Future<GetAllMedicalShopeModel> getAllMedicalShoppes() async {
    String basePath = "medicalshop/getallmedicalshop";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<< Get All Medical Shoppe Worked >>>>>>");
    return GetAllMedicalShopeModel.fromJson(json.decode(response.body));
  }

  //add favourites medical shopes

  Future<String> addFavouriteMedicalShope({
    required String medicalShopeId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    final body = {"medicalshop_id": medicalShopeId, "doctor_id": doctorId};
    String basePath = "medicalshop/addfavmedicalshop";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Favourites Medical shope Added  Successfully>>>>>>>>>>");
    return response.body;
  }

  //* get all favourite medical

  Future<GetAllFavouriteMedicalStoresModel> getAllMedicalStores() async {
    String basePath = "medicalshop/getfavmedicalshop";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    log("<<<<<< GET ALL MEDICAL STORE WORKED >>>>>>");
    return GetAllFavouriteMedicalStoresModel.fromJson(
        json.decode(response.body));
  }

  //Remove favourites medical store

  Future<String> removeFavouriteMedicalShope({
    required String medicalShopeId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? doctorId = preferences.getString('DoctorId');
    final body = {"medicalshop_id": medicalShopeId, "doctor_id": doctorId};
    String basePath = "medicalshop/Removefavmedicalshop";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<<<<Favourites Lab Added  Successfully>>>>>>>>>>");
    return response.body;
  }

  //Search Medical Store api;

  Future<SearchMedicalStoreModel> getSearchMedicalStore({
    required String searchQuery,
  }) async {
    final body = {"searchTerm": searchQuery};
    String basePath = "medicalshop/searchmedicalshop";

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    log(body.toString());
    log("<<<<<<<Search Medical Store Successfully>>>>>>>>");
    return SearchMedicalStoreModel.fromJson(json.decode(response.body));
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/Labs/get_all_favourite_lab_model.dart';
import '../../../Model/MedicalShoppe/get_fav_medical_shope_model.dart';

class BookAppointLabDropdown {
  static Future<List<Favoritemedicalshop>?> getMedicalStoreService() async {
    final preference = await SharedPreferences.getInstance();

    final token =
        preference.getString('token') ?? preference.getString('tokenD');
    log("tok $token!");
    try {
      var response = await Dio(BaseOptions(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/x-www-form-urlencoded',
      )).get(
        "${basePathUrl}medicalshop/getfavmedicalshop",
      );
      GetAllFavouriteMedicalStoresModel? model =
          GetAllFavouriteMedicalStoresModel.fromJson(response.data);

      log(model.toString());
      log("res ${response.data}");
      return model.favoritemedicalshop;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log("6656566565656556565  dist");
      log("${e.response!.data}===========");
      log("${e.message}=fdsfg=fd");
    } catch (e) {
      log("$e");
    }
    return null;
  }

  //lab
  static Future<List<FavoriteLabs>?> getScanLabService() async {
    final preference = await SharedPreferences.getInstance();

    final token =
        preference.getString('token') ?? preference.getString('tokenD');
    log("tok $token!");
    try {
      var response = await Dio(BaseOptions(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/x-www-form-urlencoded',
      )).get(
        "${basePathUrl}medicalshop/getfavlab",
      );
      GetAllFavouriteLabModel? model =
          GetAllFavouriteLabModel.fromJson(response.data);

      log(model.toString());
      log("res ${response.data}");
      return model.favoriteLabs;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log("6656566565656556565  dist");
      log("${e.response!.data}===========");
      log("${e.message}=fdsfg=fd");
    } catch (e) {
      log("$e");
    }
    return null;
  }
}

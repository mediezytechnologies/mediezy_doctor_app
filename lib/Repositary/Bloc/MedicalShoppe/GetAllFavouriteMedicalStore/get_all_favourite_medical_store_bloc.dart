import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Api/MedicalShoppe/medical_shoppe_api.dart';
import 'package:meta/meta.dart';

part 'get_all_favourite_medical_store_event.dart';
part 'get_all_favourite_medical_store_state.dart';

class GetAllFavouriteMedicalStoreBloc extends Bloc<
    GetAllFavouriteMedicalStoreEvent, GetAllFavouriteMedicalStoreState> {
  late GetAllFavouriteMedicalStoresModel getAllFavouriteMedicalStoresModel;
  MedicalShoppeApi medicalShoppeApi = MedicalShoppeApi();
  GetAllFavouriteMedicalStoreBloc()
      : super(GetAllFavouriteMedicalStoreInitial()) {
    on<FetchAllFavouriteMedicalStore>((event, emit) async {
      emit(GetAllFavouriteMedicalStoreLoading());
      try {
        getAllFavouriteMedicalStoresModel =
            await medicalShoppeApi.getAllMedicalStores();
        emit(GetAllFavouriteMedicalStoreLoaded());
      } catch (error) {
        log("<<<<<<<<<<GetAllFavouriteMedicalStore Error>>>>>>>>>>$error");
        emit(GetAllFavouriteMedicalStoreError());
      }
    });
  }
}

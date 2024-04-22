import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/search_medical_store_model.dart';
import 'package:mediezy_doctor/Repositary/Api/MedicalShoppe/medical_shoppe_api.dart';
import 'package:meta/meta.dart';

part 'search_medical_store_event.dart';
part 'search_medical_store_state.dart';

class SearchMedicalStoreBloc
    extends Bloc<SearchMedicalStoreEvent, SearchMedicalStoreState> {
  late SearchMedicalStoreModel searchMedicalStoreModel;
  MedicalShoppeApi medicalShoppeApi = MedicalShoppeApi();
  SearchMedicalStoreBloc() : super(SearchMedicalStoreInitial()) {
    on<FetchSearchMedicalStore>((event, emit) async {
      emit(SearchMedicalStoreLoading());
      try {
        searchMedicalStoreModel = await medicalShoppeApi.getSearchMedicalStore(
            searchQuery: event.searchQuery);
        emit(SearchMedicalStoreLoaded());
      } catch (e) {
        print("<>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(SearchMedicalStoreError());
      }
      // TODO: implement event handler
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Labs/search_lab_model.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:meta/meta.dart';

part 'search_scanning_centre_event.dart';

part 'search_scanning_centre_state.dart';

class SearchScanningCentreBloc
    extends Bloc<SearchScanningCentreEvent, SearchScanningCentreState> {
  late SearchLabModel searchLabModel;
  LabsApi labsApi = LabsApi();

  SearchScanningCentreBloc() : super(SearchScanningCentreInitial()) {
    on<FetchSearchScanningCentre>((event, emit) async {
      emit(SearchScanningCentreLoading());
      try {
        searchLabModel = await labsApi.getSearchScanningCentre(
            searchQuery: event.searchQuery);
        emit(SearchScanningCentreLoaded());
      } catch (e) {
        print(">>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(SearchScanningCentreError());
      }
      // TODO: implement event handler
    });
  }
}

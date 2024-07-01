import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/search_lab_test_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'search_lab_test_event.dart';
part 'search_lab_test_state.dart';

class SearchLabTestBloc extends Bloc<SearchLabTestEvent, SearchLabTestState> {
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  SearchLabTestBloc() : super(SearchLabTestInitial()) {
    on<FetchAllLabTest>((event, emit) async {
      emit(SearchLabTestLoading());
      try {
        final model = await getAppointmentApi.getAllLabTest(
            searchQuery: event.searchQuery);
        emit(SearchLabTestLoaded(searchLabTestModel: model));
      } catch (e) {
        emit(SearchLabTestError());
        log(e.toString());
      }
    });

    //!scan test

    on<FetchAllScanTest>((event, emit) async {
      emit(SearchScanTestLoading());
      try {
        final model = await getAppointmentApi.getAllScanTest(
            searchQuery: event.searchQuery);
        emit(SearchScanTestLoaded(searchLabTestModel: model));
      } catch (e) {
        emit(SearchScanTestError());
        log(e.toString());
      }
    });
  }
}

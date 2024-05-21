import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/patients_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/patient_screen_api.dart';
import 'package:meta/meta.dart';

part 'search_patients_event.dart';

part 'search_patients_state.dart';

class SearchPatientsBloc
    extends Bloc<SearchPatientsEvent, SearchPatientsState> {
  late PatientsGetModel patientsGetModel;
  PatientScreenApi patientScreenApi = PatientScreenApi();

  SearchPatientsBloc() : super(SearchPatientsInitial()) {
    on<FetchSearchPatients>((event, emit) async {
      emit(SearchPatientsLoading());
      try {
        patientsGetModel = await patientScreenApi.getSearchPatients(
            searchQuery: event.searchQuery);
        emit(SearchPatientsLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(SearchPatientsError());
      }
    });
  }
}

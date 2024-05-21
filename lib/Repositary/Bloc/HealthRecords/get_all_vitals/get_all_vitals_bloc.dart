import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_vitals_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'get_all_vitals_event.dart';
part 'get_all_vitals_state.dart';

class GetAllVitalsBloc extends Bloc<GetAllVitalsEvent, GetAllVitalsState> {
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  GetAllVitalsBloc() : super(GetAllVitalsInitial()) {
    on<FetchVitals>((event, emit) async {
      emit(GetAllVitalsLoading());
      try {
        final getVitalsModel =
            await healthRecordsApi.getVitals(patientId: event.patientId);
        emit(GetAllVitalsLoaded(getVitalsModel: getVitalsModel));
      } catch (error) {
        emit(GetAllVitalsError(errorMessage: error.toString()));
        log("<<<<<<<error ${error.toString()}");
      }
    });
  }
}

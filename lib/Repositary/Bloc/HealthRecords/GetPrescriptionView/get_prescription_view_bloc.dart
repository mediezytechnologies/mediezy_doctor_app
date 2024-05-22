import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_view_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'get_prescription_view_event.dart';
part 'get_prescription_view_state.dart';

class GetPrescriptionViewBloc
    extends Bloc<GetPrescriptionViewEvent, GetPrescriptionViewState> {
  late GetPrescriptionViewModel getPrescriptionViewModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  GetPrescriptionViewBloc() : super(GetPrescriptionViewInitial()) {
    on<FetchGetPrescriptionView>((event, emit) async {
      emit(GetPrescriptionViewLoading());
      try {
        getPrescriptionViewModel = await healthRecordsApi.getPrescriptionView(
            patientId: event.patientId, userId: event.userId);
        emit(GetPrescriptionViewLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetPrescriptionViewError());
      }
    });
  }
}

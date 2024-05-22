import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'get_prescription_event.dart';
part 'get_prescription_state.dart';

class GetPrescriptionBloc
    extends Bloc<GetPrescriptionEvent, GetPrescriptionState> {
  late GetPrescriptionModel getPrescriptionModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  GetPrescriptionBloc() : super(GetPrescriptionInitial()) {
    on<FetchGetPrescription>((event, emit) async {
      emit(GetPrescriptionLoading());
      try {
        getPrescriptionModel = await healthRecordsApi.getPrescription(
            patientId: event.patientId, userId: event.userId);
        emit(GetPrescriptionLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetPrescriptionError());
      }
    });
  }
}

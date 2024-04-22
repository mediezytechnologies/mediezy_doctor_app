import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/completed_appointments_ht_rcd_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'completed_appointments_health_record_event.dart';
part 'completed_appointments_health_record_state.dart';

class CompletedAppointmentsHealthRecordBloc extends Bloc<CompletedAppointmentsHealthRecordEvent, CompletedAppointmentsHealthRecordState> {
 late  GetCompletedAppointmentsHealthRecordModel getCompletedAppointmentsHealthRecordModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();

  CompletedAppointmentsHealthRecordBloc() : super(CompletedAppointmentsHealthRecordInitial()) {
    on<FetchCompletedAppointmentsByPatientId>((event, emit) async {
      emit(CompletedAppointmentsHealthRecordLoading());
      try {
        getCompletedAppointmentsHealthRecordModel = await healthRecordsApi
            .getCompletedAppointmentByPatientId(patientId: event.patientId, userId: event.userId);
        emit(CompletedAppointmentsHealthRecordLoaded());
      } catch (error) {
        print(
            "<<<<<<<<<<GET COMPLETED APPOINTMENTS BY PATIENT ID ERROR>>>>>>>>>>$error");
        emit(CompletedAppointmentsHealthRecordError());
      }
    });

  }
}

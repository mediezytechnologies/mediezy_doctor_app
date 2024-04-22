import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/discharge_summary_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'discharge_summary_event.dart';

part 'discharge_summary_state.dart';

class DischargeSummaryBloc
    extends Bloc<DischargeSummaryEvent, DischargeSummaryState> {
  DischargeSummaryModel dischargeSummaryModel = DischargeSummaryModel();
  HealthRecordsApi healthRecordApi = HealthRecordsApi();

  DischargeSummaryBloc() : super(DischargeSummaryInitial()) {
    on<FetchGetUploadedDischargeSummary>((event, emit) async {
      emit(DischargeSummaryLoading());
      try {
        dischargeSummaryModel =
            await healthRecordApi.getAllUploadedDischargeSummary(
                patientId: event.patientId, userId: event.userId);
        emit(DischargeSummaryLoaded());
      } catch (e) {
        print("<<<<<<<<<<GetAllDischargeSummaryError>>>>>>>>>>" + e.toString());
        emit(DischargeSummaryError());
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/lab_report_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'lab_report_event.dart';
part 'lab_report_state.dart';

class LabReportBloc extends Bloc<LabReportEvent, LabReportState> {
  late LabReportModel labReportModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  LabReportBloc() : super(LabReportInitial()) {
    on<FetchLabReport>((event, emit) async {
      emit(LabReportLoading());
      try {
        labReportModel = await healthRecordsApi.getLabReport(
            patientId: event.patientId, userId: event.userId);
        emit(LabReportLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(LabReportError());
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/GetUploadedScanReportModel.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'scan_report_event.dart';

part 'scan_report_state.dart';

class ScanReportBloc extends Bloc<ScanReportEvent, ScanReportState> {
  GetUploadedScanReportModel getUploadedScanReportModel =
      GetUploadedScanReportModel();
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();

  ScanReportBloc() : super(ScanReportInitial()) {
    on<FetchGetUploadedScanReport>((event, emit) async {
      emit(ScanReportLoading());
      try {
        getUploadedScanReportModel = await healthRecordsApi
            .getAllUploadedScanReports(patientId: event.patientId, userId: event.userId);
        emit(ScanReportLoaded());
      } catch (e) {
        print("<<<<<<<<<<GetAllUploadedScanReportsError>>>>>>>>>>" +
            e.toString());
        emit(ScanReportError());
      }
    });
  }
}

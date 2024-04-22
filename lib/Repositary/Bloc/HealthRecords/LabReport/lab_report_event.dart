part of 'lab_report_bloc.dart';

@immutable
abstract class LabReportEvent {}



class FetchLabReport extends LabReportEvent{
    final String patientId;
    final String userId;
    FetchLabReport({
    required this.patientId,
    required this.userId
});
}

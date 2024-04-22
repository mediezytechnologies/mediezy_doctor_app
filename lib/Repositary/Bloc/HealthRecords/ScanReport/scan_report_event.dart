part of 'scan_report_bloc.dart';

@immutable
abstract class ScanReportEvent {}


class FetchGetUploadedScanReport extends ScanReportEvent {
  final String patientId;
  final String userId;

  FetchGetUploadedScanReport({required this.patientId,required this.userId});
}
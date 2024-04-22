part of 'scan_report_bloc.dart';

@immutable
abstract class ScanReportState {}

class ScanReportInitial extends ScanReportState {}

class ScanReportLoading extends ScanReportState {}

class ScanReportLoaded extends ScanReportState {}

class ScanReportError extends ScanReportState {}

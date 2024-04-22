part of 'lab_report_bloc.dart';

@immutable
abstract class LabReportState {}

class LabReportInitial extends LabReportState {}

class LabReportLoading extends LabReportState {}

class LabReportLoaded extends LabReportState {}

class LabReportError extends LabReportState {}

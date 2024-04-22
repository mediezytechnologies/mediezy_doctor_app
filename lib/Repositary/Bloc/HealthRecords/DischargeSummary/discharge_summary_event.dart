part of 'discharge_summary_bloc.dart';

@immutable
abstract class DischargeSummaryEvent {}

class FetchGetUploadedDischargeSummary extends DischargeSummaryEvent{
  final String patientId;
  final String userId;

  FetchGetUploadedDischargeSummary({
    required this.patientId,
    required this.userId,
  });
}
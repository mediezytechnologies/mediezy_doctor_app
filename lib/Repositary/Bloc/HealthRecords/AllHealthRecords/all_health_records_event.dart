part of 'all_health_records_bloc.dart';

@immutable
abstract class AllHealthRecordsEvent {}

class FetchAllHealthRecords extends AllHealthRecordsEvent {
  final String patientId;
  final String userId;
  FetchAllHealthRecords({
    required this.patientId,
    required this.userId
  });
}

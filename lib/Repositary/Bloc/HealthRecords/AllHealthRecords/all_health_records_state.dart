part of 'all_health_records_bloc.dart';

@immutable
abstract class AllHealthRecordsState {}

class AllHealthRecordsInitial extends AllHealthRecordsState {}
class AllHealthRecordsLoading extends AllHealthRecordsState {}
class AllHealthRecordsLoaded extends AllHealthRecordsState {}
class AllHealthRecordsError extends AllHealthRecordsState {}

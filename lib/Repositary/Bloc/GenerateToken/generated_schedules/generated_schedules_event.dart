part of 'generated_schedules_bloc.dart';

@immutable
sealed class GeneratedSchedulesEvent {}

class FetchGeneratedSchedules extends GeneratedSchedulesEvent {}

//! delete schedules

class DeleteGeneratedSchedules extends GeneratedSchedulesEvent {
  final String scheduleId;

  DeleteGeneratedSchedules({required this.scheduleId});
}

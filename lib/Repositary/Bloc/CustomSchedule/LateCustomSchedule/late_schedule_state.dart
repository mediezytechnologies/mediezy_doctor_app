part of 'late_schedule_bloc.dart';

@immutable
abstract class LateScheduleState {}

class LateScheduleInitial extends LateScheduleState {}
class LateScheduleLoading extends LateScheduleState {}
class LateScheduleLoaded extends LateScheduleState {}
class LateScheduleError extends LateScheduleState {
  final String errorMessage;

  LateScheduleError({required this.errorMessage});

}


class EarlyScheduleLoading extends LateScheduleState {}
class EarlyScheduleLoaded extends LateScheduleState {}
class EarlyScheduleError extends LateScheduleState {
  final String errorMessage;

  EarlyScheduleError({required this.errorMessage});
}

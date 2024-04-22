part of 'between_schedule_bloc.dart';

@immutable
abstract class BetweenScheduleState {}

class BetweenScheduleInitial extends BetweenScheduleState {}
class BetweenScheduleLoading extends BetweenScheduleState {}
class BetweenScheduleLoaded extends BetweenScheduleState {}
class BetweenScheduleError extends BetweenScheduleState {}

part of 'between_schedule_bloc.dart';

@immutable
abstract class BetweenScheduleEvent {}


class FetchBetweenSchedule extends BetweenScheduleEvent{
  final String clinicId;
  final String startDate;
  final String endDate;
  final String scheduleType;
  final String startTime;
  final String endTime;

  FetchBetweenSchedule({
    required this.clinicId,
    required this.startDate,
    required this.endDate,
    required this.scheduleType,
    required this.startTime,
    required this.endTime,
  });
}
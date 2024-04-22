part of 'late_schedule_bloc.dart';

@immutable
abstract class LateScheduleEvent {}


class AddLateSchedule extends LateScheduleEvent{
  final String clinicId;
  final String date;
  final String scheduleType;
  final String timeDuration;

  AddLateSchedule({
    required this.clinicId,
    required this.date,
    required this.scheduleType,
    required this.timeDuration,
});
}



class AddEarlySchedule extends LateScheduleEvent{
  final String clinicId;
  final String date;
  final String scheduleType;
  final String timeDuration;

  AddEarlySchedule({
    required this.clinicId,
    required this.date,
    required this.scheduleType,
    required this.timeDuration,
  });
}
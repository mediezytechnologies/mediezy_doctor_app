part of 'appointments_demo_bloc_bloc.dart';

@immutable
sealed class AppointmentsDemoBlocEvent {}

class FetchAllAppointmentsDemo extends AppointmentsDemoBlocEvent {
  final String date;
  final String clinicId;
  final String scheduleType;

  FetchAllAppointmentsDemo({
    required this.date,
    required this.clinicId,
    required this.scheduleType,
  });
}

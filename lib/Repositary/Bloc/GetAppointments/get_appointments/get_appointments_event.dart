part of 'get_appointments_bloc.dart';

@immutable
sealed class GetAppointmentsEvent {}

class FetchAllAppointments extends GetAppointmentsEvent {
  final String date;
  final String clinicId;
  final String scheduleType;

  FetchAllAppointments({
    required this.date,
    required this.clinicId,
    required this.scheduleType,
  });
}

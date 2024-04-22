part of 'get_all_appointments_bloc.dart';

@immutable
abstract class GetAllAppointmentsEvent {}

class FetchAllAppointments extends GetAllAppointmentsEvent {
  final String date;
  final String clinicId;
  final String scheduleType;

  FetchAllAppointments({
    required this.date,
    required this.clinicId,
    required this.scheduleType,
  });
}
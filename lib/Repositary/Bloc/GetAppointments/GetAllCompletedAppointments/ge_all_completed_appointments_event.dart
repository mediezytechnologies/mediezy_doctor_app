part of 'ge_all_completed_appointments_bloc.dart';

@immutable
sealed class GetAllCompletedAppointmentsEvent {}

class FetchAllCompletedAppointments extends GetAllCompletedAppointmentsEvent {
  final String date;
  final String clinicId;
  final String scheduleType;

  FetchAllCompletedAppointments({
    required this.date,
    required this.clinicId,
    required this.scheduleType,
  });
}



class FetchAllCompletedAppointmentDetails extends GetAllCompletedAppointmentsEvent {
  final String tokenId;

  FetchAllCompletedAppointmentDetails({
    required this.tokenId,
  });
}
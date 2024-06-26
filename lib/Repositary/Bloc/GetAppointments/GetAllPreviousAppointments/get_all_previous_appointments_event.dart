part of 'get_all_previous_appointments_bloc.dart';

@immutable
abstract class GetAllPreviousAppointmentsEvent {}

class FetchAllPreviousAppointments extends GetAllPreviousAppointmentsEvent {
  final String date;
  final String clinicId;

  FetchAllPreviousAppointments({required this.date, required this.clinicId});
}

// class FetchAllPreviousAppointmentDetails
//     extends GetAllPreviousAppointmentsEvent {
//   final String appointmentId;
//   final String patientId;
//
//   FetchAllPreviousAppointmentDetails(
//       {required this.patientId, required this.appointmentId});
// }

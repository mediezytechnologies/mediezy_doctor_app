part of 'previous_details_bloc.dart';

@immutable
abstract class PreviousDetailsEvent {}

class FetchAllPreviousAppointmentDetails
    extends PreviousDetailsEvent {
  final String appointmentId;
  final String patientId;

  FetchAllPreviousAppointmentDetails(
      {required this.patientId, required this.appointmentId});
}

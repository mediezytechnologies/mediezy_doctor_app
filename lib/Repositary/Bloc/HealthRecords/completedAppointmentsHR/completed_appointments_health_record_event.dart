part of 'completed_appointments_health_record_bloc.dart';

@immutable
abstract class CompletedAppointmentsHealthRecordEvent {}

class FetchCompletedAppointmentsByPatientId
    extends CompletedAppointmentsHealthRecordEvent {
  final String patientId;
  final String userId;

  FetchCompletedAppointmentsByPatientId(
      {required this.patientId, required this.userId});
}

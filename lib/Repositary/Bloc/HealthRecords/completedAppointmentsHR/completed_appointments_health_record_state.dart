part of 'completed_appointments_health_record_bloc.dart';

@immutable
abstract class CompletedAppointmentsHealthRecordState {}

class CompletedAppointmentsHealthRecordInitial
    extends CompletedAppointmentsHealthRecordState {}

class CompletedAppointmentsHealthRecordLoading
    extends CompletedAppointmentsHealthRecordState {}

class CompletedAppointmentsHealthRecordLoaded
    extends CompletedAppointmentsHealthRecordState {}

class CompletedAppointmentsHealthRecordError
    extends CompletedAppointmentsHealthRecordState {}

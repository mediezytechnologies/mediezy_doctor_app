part of 'ge_all_completed_appointments_bloc.dart';

@immutable
sealed class GeAllCompletedAppointmentsState {}

final class GeAllCompletedAppointmentsInitial extends GeAllCompletedAppointmentsState {}

class GetAllCompletedAppointmentsLoading extends GeAllCompletedAppointmentsState {}
class GetAllCompletedAppointmentsLoaded extends GeAllCompletedAppointmentsState {}
class GetAllCompletedAppointmentsError extends GeAllCompletedAppointmentsState {}



class GetAllCompletedAppointmentDetailsLoading extends GeAllCompletedAppointmentsState {}
class GetAllCompletedAppointmentDetailsLoaded extends GeAllCompletedAppointmentsState {}
class GetAllCompletedAppointmentDetailsError extends GeAllCompletedAppointmentsState {}
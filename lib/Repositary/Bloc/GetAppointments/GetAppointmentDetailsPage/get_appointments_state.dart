part of 'get_appointments_bloc.dart';

@immutable
abstract class GetAppointmentsState {}

class GetAppointmentsInitial extends GetAppointmentsState {}
class GetAppointmentsLoading extends GetAppointmentsState {}
class GetAppointmentsLoaded extends GetAppointmentsState {}
class GetAppointmentsError extends GetAppointmentsState {}
part of 'get_all_previous_appointments_bloc.dart';

@immutable
abstract class GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsInitial extends GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsLoading extends GetAllPreviousAppointmentsState{}
class GetAllPreviousAppointmentsLoaded extends GetAllPreviousAppointmentsState{}
class GetAllPreviousAppointmentsError extends GetAllPreviousAppointmentsState{}

part of 'add_all_appointment_details_bloc.dart';

@immutable
abstract class AddAllAppointmentDetailsState {}

class AddAllAppointmentDetailsInitial extends AddAllAppointmentDetailsState {}

class AddAllAppointmentDetailsLoading extends AddAllAppointmentDetailsState {}

class AddAllAppointmentDetailsLoaded extends AddAllAppointmentDetailsState {}

class AddAllAppointmentDetailsError extends AddAllAppointmentDetailsState {}

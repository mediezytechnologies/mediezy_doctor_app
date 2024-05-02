part of 'get_all_previous_appointments_bloc.dart';

@immutable
abstract class GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsInitial
    extends GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsLoading
    extends GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsLoaded
    extends GetAllPreviousAppointmentsState {}

class GetAllPreviousAppointmentsError extends GetAllPreviousAppointmentsState {}

//previous appointment details

// class PreviousAppointmentDetailsInitial extends GetAllPreviousAppointmentsState {}
//
// class PreviousAppointmentDetailsLoading extends GetAllPreviousAppointmentsState {}
//
// class PreviousAppointmentDetailsLoaded extends GetAllPreviousAppointmentsState {
//   final PreviousAppointmentDetailsModel previousAppointmentDetailsModel;
//
//   PreviousAppointmentDetailsLoaded(
//       {required this.previousAppointmentDetailsModel});
// }
//
// class PreviousAppointmentDetailsError
//     extends GetAllPreviousAppointmentsState {}

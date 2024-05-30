part of 'get_appointments_bloc.dart';

@immutable
sealed class GetAppointmentsState {}

final class GetAppointmentsInitial extends GetAppointmentsState {}

final class GetAppointmentsLoading extends GetAppointmentsState {}

final class GetAppointmentsLoaded extends GetAppointmentsState {
  final bool isLoaded;

  GetAppointmentsLoaded({required this.isLoaded});
}

final class GetAppointmentsError extends GetAppointmentsState {}

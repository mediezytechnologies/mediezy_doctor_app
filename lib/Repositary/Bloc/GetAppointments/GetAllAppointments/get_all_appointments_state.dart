part of 'get_all_appointments_bloc.dart';

@immutable
abstract class GetAllAppointmentsState {}

final class GetAllAppointmentsInitial extends GetAllAppointmentsState {}

class GetAllAppointmentsLoading extends GetAllAppointmentsState {}

class GetAllAppointmentsError extends GetAllAppointmentsState {}

class GetAllAppointmentsLoaded extends GetAllAppointmentsState {
  final bool isLoaded;

  GetAllAppointmentsLoaded({required this.isLoaded});
}

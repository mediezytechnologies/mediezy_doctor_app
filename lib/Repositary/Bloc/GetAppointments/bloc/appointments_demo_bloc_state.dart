part of 'appointments_demo_bloc_bloc.dart';

@immutable
sealed class AppointmentsDemoBlocState {}

final class AppointmentsDemoBlocInitial extends AppointmentsDemoBlocState {}

final class AppointmentsDemoBlocLoading extends AppointmentsDemoBlocState {}

final class AppointmentsDemoBlocLoaded extends AppointmentsDemoBlocState {
    final bool isLoaded;

  AppointmentsDemoBlocLoaded({required this.isLoaded});
}

final class AppointmentsDemoBlocError extends AppointmentsDemoBlocState {


}

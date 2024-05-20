part of 'book_appointment_bloc.dart';

@immutable
abstract class BookAppointmentState {}

final class BookAppointmentInitial extends BookAppointmentState {}

class BookAppointmentLoading extends BookAppointmentState {}

class BookAppointmentLoaded extends BookAppointmentState {}

class BookAppointmentError extends BookAppointmentState {
  final String errorMessage;

  BookAppointmentError({required this.errorMessage});
}

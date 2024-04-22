part of 'suggest_doctor_bloc.dart';

@immutable
abstract class SuggestDoctorState {}

class SuggestDoctorInitial extends SuggestDoctorState {}

class SuggestDoctorLoading extends SuggestDoctorState {}

class SuggestDoctorLoaded extends SuggestDoctorState {
  final String successMessage;

  SuggestDoctorLoaded({required this.successMessage});
}

class SuggestDoctorError extends SuggestDoctorState {
  final String errorMessage;

  SuggestDoctorError({required this.errorMessage});
}

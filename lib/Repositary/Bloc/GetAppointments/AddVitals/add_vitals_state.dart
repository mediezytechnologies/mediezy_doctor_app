part of 'add_vitals_bloc.dart';

@immutable
abstract class AddVitalsState {}

class AddVitalsInitial extends AddVitalsState {}

class AddVitalsLoading extends AddVitalsState {}

class AddVitalsLoaded extends AddVitalsState {
  final String successMessage;

  AddVitalsLoaded({required this.successMessage});
}

class AddVitalsError extends AddVitalsState {
  final String errorMessage;

  AddVitalsError({required this.errorMessage});
}

//edit vitals state

class EditVitalsInitial extends AddVitalsState {}

class EditVitalsLoading extends AddVitalsState {}

class EditVitalsLoaded extends AddVitalsState {
  final String successMessage;

  EditVitalsLoaded({required this.successMessage});
}

class EditVitalsError extends AddVitalsState {
  final String errorMessage;

  EditVitalsError({required this.errorMessage});
}


//delete vitals state

class DeleteVitalsInitial extends AddVitalsState {}

class DeleteVitalsLoading extends AddVitalsState {}

class DeleteVitalsLoaded extends AddVitalsState {
  final String successMessage;

  DeleteVitalsLoaded({required this.successMessage});
}

class DeleteVitalsError extends AddVitalsState {
  final String errorMessage;

  DeleteVitalsError({required this.errorMessage});
}
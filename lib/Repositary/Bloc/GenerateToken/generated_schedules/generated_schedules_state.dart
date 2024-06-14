part of 'generated_schedules_bloc.dart';

@immutable
sealed class GeneratedSchedulesState {}

final class GeneratedSchedulesInitial extends GeneratedSchedulesState {}

final class GeneratedSchedulesLoading extends GeneratedSchedulesState {}

final class GeneratedSchedulesLoaded extends GeneratedSchedulesState {
  final GeneratedSchedulesModel generatedSchedulesModel;

  GeneratedSchedulesLoaded({required this.generatedSchedulesModel});
}

final class GeneratedSchedulesError extends GeneratedSchedulesState {}

//! delete schedules

final class DeleteSchedulesInitial extends GeneratedSchedulesState {}

final class DeleteSchedulesLoading extends GeneratedSchedulesState {}

final class DeleteSchedulesLoaded extends GeneratedSchedulesState {
  final String successMessage;

  DeleteSchedulesLoaded({required this.successMessage});
}

final class DeleteSchedulesError extends GeneratedSchedulesState {
  final String errorMessage;

  DeleteSchedulesError({required this.errorMessage});
}

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

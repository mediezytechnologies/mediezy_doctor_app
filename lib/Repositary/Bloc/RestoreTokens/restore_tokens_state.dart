part of 'restore_tokens_bloc.dart';

@immutable
abstract class RestoreTokensState {}

class RestoreDatesInitial extends RestoreTokensState {}

class RestoreDatesLoading extends RestoreTokensState {}

class RestoreDatesLoaded extends RestoreTokensState {}

class RestoreDatesError extends RestoreTokensState {}



class AddRestoreTokensInitial extends RestoreTokensState {}

class AddRestoreTokensLoading extends RestoreTokensState {}

class AddRestoreTokensLoaded extends RestoreTokensState {
  final String successMessage;

  AddRestoreTokensLoaded({required this.successMessage});
}

class AddRestoreTokensError extends RestoreTokensState {
  final String errorMessage;

  AddRestoreTokensError({required this.errorMessage});
}
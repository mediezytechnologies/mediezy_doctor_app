part of 'generate_token_final_bloc.dart';

@immutable
abstract class GenerateTokenFinalState {}

class GenerateTokenFinalInitial extends GenerateTokenFinalState {}

class GenerateTokenFinalLoading extends GenerateTokenFinalState {}

class GenerateTokenFinalLoaded extends GenerateTokenFinalState {
  final String successMessage;

  GenerateTokenFinalLoaded({required this.successMessage});
}

class GenerateTokenFinalError extends GenerateTokenFinalState {
  final String errorMessage;

  GenerateTokenFinalError({required this.errorMessage});
}

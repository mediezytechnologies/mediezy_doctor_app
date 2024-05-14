part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginError extends LoginState {}

class DummyRegisterInitial extends LoginState {}

class DummyRegisterLoading extends LoginState {}

class DummyRegisterLoaded extends LoginState {
  final String successMessage;

  DummyRegisterLoaded({required this.successMessage});
}

class DummyRegisterError extends LoginState {
  final String errorMessage;

  DummyRegisterError({required this.errorMessage});
}

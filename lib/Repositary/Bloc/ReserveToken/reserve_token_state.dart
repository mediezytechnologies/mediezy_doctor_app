part of 'reserve_token_bloc.dart';

@immutable
abstract class ReserveTokenState {}

class ReserveTokenInitial extends ReserveTokenState {}

class ReserveTokenLoading extends ReserveTokenState {}

class ReserveTokenLoaded extends ReserveTokenState {}

class ReserveTokenError extends ReserveTokenState {
  final String errorMessage;

  ReserveTokenError({required this.errorMessage});
}

// un reserve token


class UnReserveTokenInitial extends ReserveTokenState {}

class UnReserveTokenLoading extends ReserveTokenState {}

class UnReserveTokenLoaded extends ReserveTokenState {}

class UnReserveTokenError extends ReserveTokenState {
  final String errorMessage;

  UnReserveTokenError({required this.errorMessage});
}

//reserved tokens get

class ReservedTokensInitial extends ReserveTokenState {}

class ReservedTokensLoading extends ReserveTokenState {}

class ReservedTokensLoaded extends ReserveTokenState {
  final GetReservedTokensModel getReservedTokensModel;

  ReservedTokensLoaded({required this.getReservedTokensModel});
}

class ReservedTokensError extends ReserveTokenState {}

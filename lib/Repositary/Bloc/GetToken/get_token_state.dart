part of 'get_token_bloc.dart';

@immutable
sealed class GetTokenState {}

final class GetTokenInitial extends GetTokenState {}

class GetTokenLoading extends GetTokenState {}

class GetTokenLoaded extends GetTokenState {}

class GetTokenError extends GetTokenState {}

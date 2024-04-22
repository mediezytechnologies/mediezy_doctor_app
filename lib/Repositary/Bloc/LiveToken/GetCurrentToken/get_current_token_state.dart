part of 'get_current_token_bloc.dart';

@immutable
abstract class GetCurrentTokenState {}

class GetCurrentTokenInitial extends GetCurrentTokenState {}
class GetCurrentTokenLoading extends GetCurrentTokenState {}
class GetCurrentTokenLoaded extends GetCurrentTokenState {}
class GetCurrentTokenError extends GetCurrentTokenState {}

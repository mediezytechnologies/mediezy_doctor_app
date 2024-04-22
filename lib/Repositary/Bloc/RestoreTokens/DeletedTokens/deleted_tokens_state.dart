part of 'deleted_tokens_bloc.dart';

@immutable
abstract class DeletedTokensState {}

class DeletedTokensInitial extends DeletedTokensState {}

class DeletedTokensLoading extends DeletedTokensState {}

class DeletedTokensLoaded extends DeletedTokensState {}

class DeletedTokensError extends DeletedTokensState {}

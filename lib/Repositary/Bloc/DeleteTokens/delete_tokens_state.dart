part of 'delete_tokens_bloc.dart';

@immutable
abstract class DeleteTokensState {}

class DeleteTokensInitial extends DeleteTokensState {}
class DeleteTokensLoading extends DeleteTokensState {}
class DeleteTokensLoaded extends DeleteTokensState {}
class DeleteTokensError extends DeleteTokensState {
  final String errorMessage;

  DeleteTokensError({required this.errorMessage});
}

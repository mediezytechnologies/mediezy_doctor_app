part of 'restore_tokens_bloc.dart';

@immutable
abstract class RestoreTokensEvent {}

class FetchRestoreDates extends RestoreTokensEvent {
  final String clinicId;

  FetchRestoreDates({required this.clinicId});
}



class AddRestoreTokens extends RestoreTokensEvent {
  final String tokenId;

  AddRestoreTokens({required this.tokenId});
}
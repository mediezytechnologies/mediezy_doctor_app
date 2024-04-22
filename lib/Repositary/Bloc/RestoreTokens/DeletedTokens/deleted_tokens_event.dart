part of 'deleted_tokens_bloc.dart';

@immutable
abstract class DeletedTokensEvent {}


class FetchDeletedTokens extends DeletedTokensEvent {
  final String clinicId;
  // final String date;

  FetchDeletedTokens({required this.clinicId,
    // required this.date
  });
}
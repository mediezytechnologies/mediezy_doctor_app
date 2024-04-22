part of 'delete_tokens_bloc.dart';

@immutable
abstract class DeleteTokensEvent {}

class FetchDeleteTokens extends DeleteTokensEvent {
  final String tokenId;



  FetchDeleteTokens({
    required this.tokenId,

  });
}
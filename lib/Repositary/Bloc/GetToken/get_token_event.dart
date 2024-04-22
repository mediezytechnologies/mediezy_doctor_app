part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenEvent {}

class FetchTokens extends GetTokenEvent {
  final String date;
  final String clinicId;

  FetchTokens({
    required this.date,
    required this.clinicId
  });
}



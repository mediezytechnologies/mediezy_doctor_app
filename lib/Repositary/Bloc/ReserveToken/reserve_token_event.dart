part of 'reserve_token_bloc.dart';

@immutable
abstract class ReserveTokenEvent {}

class AddReserveToken extends ReserveTokenEvent {
  final String tokenNumber;
  final String fromDate;
  final String toDate;
  final String clinicId;

  AddReserveToken({
    required this.tokenNumber,
    required this.fromDate,
    required this.toDate,
    required this.clinicId,
});
}



class FetchReservedTokens extends ReserveTokenEvent {
  final String fromDate;
  final String toDate;
  final String clinicId;

  FetchReservedTokens({
    required this.fromDate,
    required this.toDate,
    required this.clinicId,
  });
}


class UnReserveToken extends ReserveTokenEvent {
  final String tokenNumber;
  final String fromDate;
  final String toDate;
  final String clinicId;

  UnReserveToken({
    required this.tokenNumber,
    required this.fromDate,
    required this.toDate,
    required this.clinicId,
  });
}
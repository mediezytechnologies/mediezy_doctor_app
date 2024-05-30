part of 'add_checkin_or_checkout_bloc.dart';

@immutable
abstract class AddCheckinOrCheckoutEvent {}

class AddCheckinOrCheckout extends AddCheckinOrCheckoutEvent {
  final String tokenNumber;
  final int isCheckin;
  final int isCompleted;
  final String clinicId;
  final String isReached;

  AddCheckinOrCheckout({
    required this.tokenNumber,
    required this.isCheckin,
    required this.isCompleted,
    required this.clinicId,
    required this.isReached,
  });
}

//! estimate time update checkin

class EstimateUpdateCheckin extends AddCheckinOrCheckoutEvent {
  final String tokenId;

  EstimateUpdateCheckin({
    required this.tokenId,
  });
}

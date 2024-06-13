part of 'add_checkin_or_checkout_bloc.dart';

@immutable
abstract class AddCheckinOrCheckoutState {}

class AddCheckinOrCheckoutInitial extends AddCheckinOrCheckoutState {}

class AddCheckinOrCheckoutLoading extends AddCheckinOrCheckoutState {}

class AddCheckinOrCheckoutLoaded extends AddCheckinOrCheckoutState {
 // final String response;

  AddCheckinOrCheckoutLoaded(
    //this.response
    );
}

class AddCheckinOrCheckoutError extends AddCheckinOrCheckoutState {
  final String errorMessage;

  AddCheckinOrCheckoutError({required this.errorMessage});
}

//! estimate time update checkin

class EstimateUpdateCheckinInitial extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckinLoading extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckinLoaded extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckinError extends AddCheckinOrCheckoutState {}

//! estimate time update checkout

class EstimateUpdateCheckoutInitial extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckoutLoading extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckoutLoaded extends AddCheckinOrCheckoutState {}

class EstimateUpdateCheckoutError extends AddCheckinOrCheckoutState {}

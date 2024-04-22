part of 'add_checkin_or_checkout_bloc.dart';

@immutable
abstract class AddCheckinOrCheckoutState {}

class AddCheckinOrCheckoutInitial extends AddCheckinOrCheckoutState {}
class AddCheckinOrCheckoutLoading extends AddCheckinOrCheckoutState {}
class AddCheckinOrCheckoutLoaded extends AddCheckinOrCheckoutState {}
class AddCheckinOrCheckoutError extends AddCheckinOrCheckoutState {}

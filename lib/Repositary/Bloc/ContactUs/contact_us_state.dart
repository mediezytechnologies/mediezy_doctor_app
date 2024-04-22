part of 'contact_us_bloc.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}
class ContactUsLoading extends ContactUsState {}
class ContactUsLoaded extends ContactUsState {
  final String successMessage;

  ContactUsLoaded({required this.successMessage});
}
class ContactUsError extends ContactUsState {
  final String errorMessage;

  ContactUsError({required this.errorMessage});
}
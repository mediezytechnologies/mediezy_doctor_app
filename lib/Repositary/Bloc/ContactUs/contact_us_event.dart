part of 'contact_us_bloc.dart';

@immutable
abstract class ContactUsEvent {}

class AddContactUs extends ContactUsEvent {
  final String email;
  final String description;

  AddContactUs({
    required this.email,
    required this.description,
  });
}

part of 'profile_edit_bloc.dart';

@immutable
abstract class ProfileEditEvent {}

class FetchProfileEdit extends ProfileEditEvent {
  final String firstname;
  final String secondname;
  final String mobileNo;
  final File? attachment;

  FetchProfileEdit({
    required this.firstname,
    required this.secondname,
    required this.mobileNo,
    required this.attachment,
  });
}

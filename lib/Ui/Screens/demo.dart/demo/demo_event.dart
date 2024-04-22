// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'demo_bloc.dart';

@immutable
abstract class LandingPageEvent {}

class TabChange extends LandingPageEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

class DropdowEvent extends LandingPageEvent {
  final String dropdownvLalu;

  DropdowEvent({required this.dropdownvLalu});
}

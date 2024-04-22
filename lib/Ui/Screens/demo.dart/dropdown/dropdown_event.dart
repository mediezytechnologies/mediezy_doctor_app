part of 'dropdown_bloc.dart';

@immutable
sealed class DropdownEvent {}

class DropdownSelectEvent extends DropdownEvent {
  final String dropdownSelectnvLalu;

  DropdownSelectEvent({required this.dropdownSelectnvLalu});
}

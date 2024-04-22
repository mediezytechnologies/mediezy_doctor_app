part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownState {
  final String changValue;
  const DropdownState({required this.changValue});
}

class DropDownInitial extends DropdownState {
  const DropDownInitial ({required super.changValue});
}

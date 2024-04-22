part of 'selected_clinic_bloc.dart';

@immutable
abstract class SelectedClinicEvent {
}


class selectedDropDownClinic extends SelectedClinicEvent {
  final String dropdownSelectedValue;

  selectedDropDownClinic({required this.dropdownSelectedValue});
}
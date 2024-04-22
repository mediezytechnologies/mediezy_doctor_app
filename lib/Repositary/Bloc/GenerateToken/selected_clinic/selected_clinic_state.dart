part of 'selected_clinic_bloc.dart';

@immutable
abstract class SelectedClinicState {
  final String changValue;
  const SelectedClinicState({required this.changValue});
}

class SelectedClinicInitial extends SelectedClinicState {
  const SelectedClinicInitial ({required super.changValue});
}

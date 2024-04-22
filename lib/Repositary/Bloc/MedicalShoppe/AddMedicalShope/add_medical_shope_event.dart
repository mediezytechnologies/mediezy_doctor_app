part of 'add_medical_shope_bloc.dart';

@immutable
abstract class AddMedicalShopeEvent {}


class AddMedicalShope extends AddMedicalShopeEvent {
  final String medicalShopeId;
  AddMedicalShope({required this.medicalShopeId});
}

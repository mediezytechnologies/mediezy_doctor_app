part of 'remove_medical_shope_bloc.dart';

@immutable
abstract class RemoveMedicalShopeEvent {}


class RemoveMedicalShope extends RemoveMedicalShopeEvent {
  final String medicalShopeId;
  RemoveMedicalShope({required this.medicalShopeId});
}
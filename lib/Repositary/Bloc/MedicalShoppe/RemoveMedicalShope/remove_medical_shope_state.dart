part of 'remove_medical_shope_bloc.dart';

@immutable
abstract class RemoveMedicalShopeState {}

class RemoveMedicalShopeInitial extends RemoveMedicalShopeState {}
class RemoveMedicalShopeLoading extends RemoveMedicalShopeState {}
class RemoveMedicalShopeLoaded extends RemoveMedicalShopeState {}
class RemoveMedicalShopeError extends RemoveMedicalShopeState {}

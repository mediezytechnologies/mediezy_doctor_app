part of 'add_medical_shope_bloc.dart';

@immutable
abstract class AddMedicalShopeState {}

class AddMedicalShopeInitial extends AddMedicalShopeState {}
class AddMedicalShopeLoading extends AddMedicalShopeState {}
class AddMedicalShopeLoaded extends AddMedicalShopeState {}
class AddMedicalShopeError extends AddMedicalShopeState {}

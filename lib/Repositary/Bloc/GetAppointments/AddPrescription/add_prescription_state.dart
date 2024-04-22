part of 'add_prescription_bloc.dart';

@immutable
abstract class AddPrescriptionState {}

class AddPrescriptionInitial extends AddPrescriptionState {}
class AddPrescriptionLoading extends AddPrescriptionState {}
class AddPrescriptionLoaded extends AddPrescriptionState {}
class AddPrescriptionError extends AddPrescriptionState {
  final String errorMessage;

  AddPrescriptionError({required this.errorMessage});
}

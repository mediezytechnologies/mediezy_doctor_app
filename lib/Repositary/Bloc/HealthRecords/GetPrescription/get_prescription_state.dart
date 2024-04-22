part of 'get_prescription_bloc.dart';

@immutable
abstract class GetPrescriptionState {}

class GetPrescriptionInitial extends GetPrescriptionState {}
class GetPrescriptionLoading extends GetPrescriptionState {}
class GetPrescriptionLoaded extends GetPrescriptionState {}
class GetPrescriptionError extends GetPrescriptionState {}

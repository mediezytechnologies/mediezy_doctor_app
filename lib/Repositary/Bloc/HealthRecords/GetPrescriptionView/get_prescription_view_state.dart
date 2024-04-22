part of 'get_prescription_view_bloc.dart';

@immutable
abstract class GetPrescriptionViewState {}

class GetPrescriptionViewInitial extends GetPrescriptionViewState {}

class GetPrescriptionViewLoading extends GetPrescriptionViewState {}

class GetPrescriptionViewLoaded extends GetPrescriptionViewState {}

class GetPrescriptionViewError extends GetPrescriptionViewState {}

part of 'delete_medicine_bloc.dart';

@immutable
abstract class DeleteMedicineState {}

class DeleteMedicineInitial extends DeleteMedicineState {}

class DeleteMedicineLoading extends DeleteMedicineState {}

class DeleteMedicineLoaded extends DeleteMedicineState {}

class DeleteMedicineError extends DeleteMedicineState {}

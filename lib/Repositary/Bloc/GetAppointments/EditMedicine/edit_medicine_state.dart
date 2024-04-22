part of 'edit_medicine_bloc.dart';

@immutable
abstract class EditMedicineState {}

class EditMedicineInitial extends EditMedicineState {}

class EditMedicineLoading extends EditMedicineState {}

class EditMedicineLoaded extends EditMedicineState {}

class EditMedicineError extends EditMedicineState {}

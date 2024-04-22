part of 'delete_medicine_bloc.dart';

@immutable
abstract class DeleteMedicineEvent {}


class DeleteMedicine extends DeleteMedicineEvent{
  final String medicineId;

  DeleteMedicine({
   required this.medicineId
});
}
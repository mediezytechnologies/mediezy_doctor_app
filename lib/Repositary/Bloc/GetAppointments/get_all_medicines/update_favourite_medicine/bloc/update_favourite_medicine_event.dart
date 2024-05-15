part of 'update_favourite_medicine_bloc.dart';

@immutable
sealed class UpdateFavouriteMedicineEvent {}

class UpdateFavouriteMedicine extends UpdateFavouriteMedicineEvent {
  final String medicineId;

  UpdateFavouriteMedicine({required this.medicineId});
}

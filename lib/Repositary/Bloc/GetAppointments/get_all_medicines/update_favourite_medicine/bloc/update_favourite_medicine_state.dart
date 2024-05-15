part of 'update_favourite_medicine_bloc.dart';

@immutable
sealed class UpdateFavouriteMedicineState {}

final class UpdateFavouriteMedicineInitial
    extends UpdateFavouriteMedicineState {}

final class UpdateFavouriteMedicineLoading
    extends UpdateFavouriteMedicineState {}

final class UpdateFavouriteMedicineLoaded extends UpdateFavouriteMedicineState {
  final String successMessage;

  UpdateFavouriteMedicineLoaded({required this.successMessage});
}

final class UpdateFavouriteMedicineError extends UpdateFavouriteMedicineState {
  final String errorMessage;

  UpdateFavouriteMedicineError({required this.errorMessage});
}

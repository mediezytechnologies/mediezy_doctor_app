part of 'favourite_lab_test_bloc.dart';

@immutable
sealed class FavouriteLabTestState {}

final class FavouriteLabTestInitial extends FavouriteLabTestState {}

final class FavouriteLabTestLoading extends FavouriteLabTestState {}

final class FavouriteLabTestLoaded extends FavouriteLabTestState {
  final String successMessage;

  FavouriteLabTestLoaded({required this.successMessage});
}

final class FavouriteLabTestError extends FavouriteLabTestState {
  final String errorMessage;

  FavouriteLabTestError({required this.errorMessage});
}

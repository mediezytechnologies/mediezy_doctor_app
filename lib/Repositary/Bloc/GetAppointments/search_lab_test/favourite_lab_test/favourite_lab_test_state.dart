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

//! delete recently search lab test

final class DeleteRecentlySearchLabTestInitial extends FavouriteLabTestState {}

final class DeleteRecentlySearchLabTestLoading extends FavouriteLabTestState {}

final class DeleteRecentlySearchLabTestLoaded extends FavouriteLabTestState {
  final String successMessage;

  DeleteRecentlySearchLabTestLoaded({required this.successMessage});
}

final class DeleteRecentlySearchLabTestError extends FavouriteLabTestState {
  final String errorMessage;

  DeleteRecentlySearchLabTestError({required this.errorMessage});
}

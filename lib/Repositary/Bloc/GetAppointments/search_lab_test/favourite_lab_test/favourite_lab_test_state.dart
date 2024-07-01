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

//! favourite scan test

final class FavouriteScanTestInitial extends FavouriteLabTestState {}

final class FavouriteScanTestLoading extends FavouriteLabTestState {}

final class FavouriteScanTestLoaded extends FavouriteLabTestState {
  final String successMessage;

  FavouriteScanTestLoaded({required this.successMessage});
}

final class FavouriteScanTestError extends FavouriteLabTestState {
  final String errorMessage;

  FavouriteScanTestError({required this.errorMessage});
}

//! delete recently search scan test

final class DeleteRecentlySearchScanTestInitial extends FavouriteLabTestState {}

final class DeleteRecentlySearchScanTestLoading extends FavouriteLabTestState {}

final class DeleteRecentlySearchScanTestLoaded extends FavouriteLabTestState {
  final String successMessage;

  DeleteRecentlySearchScanTestLoaded({required this.successMessage});
}

final class DeleteRecentlySearchScanTestError extends FavouriteLabTestState {
  final String errorMessage;

  DeleteRecentlySearchScanTestError({required this.errorMessage});
}

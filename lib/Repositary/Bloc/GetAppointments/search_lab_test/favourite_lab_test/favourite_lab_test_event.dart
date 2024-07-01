part of 'favourite_lab_test_bloc.dart';

@immutable
sealed class FavouriteLabTestEvent {}

class AddFavouriteLabTest extends FavouriteLabTestEvent {
  final String labTestId;

  AddFavouriteLabTest({required this.labTestId});
}

//! delete recently search lab test

class DeleteRecentlySearchLabTest extends FavouriteLabTestEvent {
  final String labTestId;

  DeleteRecentlySearchLabTest({required this.labTestId});
}

//! favourite scan test

class AddFavouriteScanTest extends FavouriteLabTestEvent {
  final String scanTestId;

  AddFavouriteScanTest({required this.scanTestId});
}

//! delete recently search scan test

class DeleteRecentlySearchScanTest extends FavouriteLabTestEvent {
  final String historyId;

  DeleteRecentlySearchScanTest({required this.historyId});
}

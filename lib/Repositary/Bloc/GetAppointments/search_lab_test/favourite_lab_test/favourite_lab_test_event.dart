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

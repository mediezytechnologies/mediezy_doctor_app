part of 'favourite_lab_test_bloc.dart';

@immutable
sealed class FavouriteLabTestEvent {}

class AddFavouriteLabTest extends FavouriteLabTestEvent {
  final String labTestId;

  AddFavouriteLabTest({required this.labTestId});
}

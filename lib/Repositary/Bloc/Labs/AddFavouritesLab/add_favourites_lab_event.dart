part of 'add_favourites_lab_bloc.dart';

@immutable
abstract class AddFavouritesLabEvent {}

class AddFavouritesLab extends AddFavouritesLabEvent {
  final String labId;
  AddFavouritesLab({required this.labId});
}

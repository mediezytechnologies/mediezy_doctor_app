part of 'remove_fav_labs_bloc.dart';

@immutable
abstract class RemoveFavLabsEvent {}


class RemoveFavouritesLab extends RemoveFavLabsEvent {
  final String labId;
  RemoveFavouritesLab({required this.labId});
}

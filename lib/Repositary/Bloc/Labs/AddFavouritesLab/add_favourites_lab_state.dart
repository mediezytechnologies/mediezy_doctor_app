part of 'add_favourites_lab_bloc.dart';

@immutable
abstract class AddFavouritesLabState {}

class AddFavouritesLabInitial extends AddFavouritesLabState {}

class AddFavouritesLabLoading extends AddFavouritesLabState {}

class AddFavouritesLabLoaded extends AddFavouritesLabState {}

class AddFavouritesLabError extends AddFavouritesLabState {}

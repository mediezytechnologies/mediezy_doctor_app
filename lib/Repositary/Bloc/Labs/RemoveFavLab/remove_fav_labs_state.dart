part of 'remove_fav_labs_bloc.dart';

@immutable
abstract class RemoveFavLabsState {}

class RemoveFavLabsInitial extends RemoveFavLabsState {}

class RemoveFavLabsLoading extends RemoveFavLabsState {}

class RemoveFavLabsLoaded extends RemoveFavLabsState {}

class RemoveFavLabsError extends RemoveFavLabsState {}

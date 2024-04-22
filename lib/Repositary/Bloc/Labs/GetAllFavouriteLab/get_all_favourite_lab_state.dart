part of 'get_all_favourite_lab_bloc.dart';

@immutable
sealed class GetAllFavouriteLabState {}

final class GetAllFavouriteLabInitial extends GetAllFavouriteLabState {}


class GetAllFavouriteLabLoading extends GetAllFavouriteLabState{}
class GetAllFavouriteLabLoaded extends GetAllFavouriteLabState{}
class GetAllFavouriteLabError extends GetAllFavouriteLabState{}



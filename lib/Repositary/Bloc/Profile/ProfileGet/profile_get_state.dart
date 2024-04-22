part of 'profile_get_bloc.dart';

@immutable
abstract class ProfileGetState {}

class ProfileGetInitial extends ProfileGetState {}
class ProfileGetLoading extends ProfileGetState {}
class ProfileGetLoaded extends ProfileGetState {}
class ProfileGetError extends ProfileGetState {}

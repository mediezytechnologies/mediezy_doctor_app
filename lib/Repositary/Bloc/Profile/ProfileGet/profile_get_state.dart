part of 'profile_get_bloc.dart';

@immutable
abstract class ProfileGetState {}

class ProfileGetInitial extends ProfileGetState {}

class ProfileGetLoading extends ProfileGetState {}

class ProfileGetLoaded extends ProfileGetState {
  final ProfileGetModel profileGetModel;

  ProfileGetLoaded({required this.profileGetModel});
}

class ProfileGetError extends ProfileGetState {}

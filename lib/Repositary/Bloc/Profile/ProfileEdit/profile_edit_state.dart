part of 'profile_edit_bloc.dart';

@immutable
abstract class ProfileEditState {}

class ProfileEditInitial extends ProfileEditState {}
class ProfileEditLoading extends ProfileEditState {}
class ProfileEditLoaded extends ProfileEditState {}
class ProfileEditError extends ProfileEditState {}

part of 'get_symptoms_bloc.dart';

@immutable
sealed class GetSymptomsState {}

final class GetSymptomsInitial extends GetSymptomsState {}

final class GetSymptomsLoading extends GetSymptomsState {}

final class GetSymptomsLoaded extends GetSymptomsState {}

final class GetSymptomsError extends GetSymptomsState {}

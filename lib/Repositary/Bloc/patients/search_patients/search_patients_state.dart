part of 'search_patients_bloc.dart';

@immutable
abstract class SearchPatientsState {}

class SearchPatientsInitial extends SearchPatientsState {}

class SearchPatientsLoading extends SearchPatientsState {}

class SearchPatientsLoaded extends SearchPatientsState {}

class SearchPatientsError extends SearchPatientsState {}

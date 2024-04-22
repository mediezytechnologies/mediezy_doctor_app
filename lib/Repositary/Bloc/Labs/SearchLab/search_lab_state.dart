part of 'search_lab_bloc.dart';

@immutable
abstract class SearchLabState {}

class SearchLabInitial extends SearchLabState {}

class SearchLabLoading extends SearchLabState {}

class SearchLabLoaded extends SearchLabState {}

class SearchLabError extends SearchLabState {}

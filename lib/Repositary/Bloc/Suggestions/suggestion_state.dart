part of 'suggestion_bloc.dart';

@immutable
abstract class SuggestionState {}

class SuggestionInitial extends SuggestionState {}

class SuggestionLoading extends SuggestionState {}

class SuggestionLoaded extends SuggestionState {}

class SuggestionError extends SuggestionState {}

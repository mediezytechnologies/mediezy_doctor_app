part of 'search_scanning_centre_bloc.dart';

@immutable
abstract class SearchScanningCentreState {}

class SearchScanningCentreInitial extends SearchScanningCentreState {}
class SearchScanningCentreLoading extends SearchScanningCentreState {}
class SearchScanningCentreLoaded extends SearchScanningCentreState {}
class SearchScanningCentreError extends SearchScanningCentreState {}

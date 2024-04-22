part of 'search_scanning_centre_bloc.dart';

@immutable
abstract class SearchScanningCentreEvent {}


class FetchSearchScanningCentre extends SearchScanningCentreEvent{
  final String searchQuery;

  FetchSearchScanningCentre({
    required this.searchQuery
});
}
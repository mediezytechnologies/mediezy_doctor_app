part of 'search_lab_test_bloc.dart';

@immutable
sealed class SearchLabTestEvent {}

class FetchAllLabTest extends SearchLabTestEvent {
  final String searchQuery;

  FetchAllLabTest({required this.searchQuery});
}

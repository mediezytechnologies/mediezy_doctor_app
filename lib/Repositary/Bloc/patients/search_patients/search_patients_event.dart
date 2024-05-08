part of 'search_patients_bloc.dart';

@immutable
abstract class SearchPatientsEvent {}

class FetchSearchPatients extends SearchPatientsEvent {
  final String searchQuery;

  FetchSearchPatients({
    required this.searchQuery,
  });
}
part of 'search_medical_store_bloc.dart';

@immutable
abstract class SearchMedicalStoreEvent {}


class FetchSearchMedicalStore extends SearchMedicalStoreEvent{
  final String searchQuery;

  FetchSearchMedicalStore({
    required this.searchQuery
});
}
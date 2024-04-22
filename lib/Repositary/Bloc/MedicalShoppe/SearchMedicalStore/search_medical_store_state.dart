part of 'search_medical_store_bloc.dart';

@immutable
abstract class SearchMedicalStoreState {}

class SearchMedicalStoreInitial extends SearchMedicalStoreState {}

class SearchMedicalStoreLoading extends SearchMedicalStoreState {}

class SearchMedicalStoreLoaded extends SearchMedicalStoreState {}

class SearchMedicalStoreError extends SearchMedicalStoreState {}

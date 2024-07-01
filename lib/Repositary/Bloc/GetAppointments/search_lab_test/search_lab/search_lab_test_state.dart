part of 'search_lab_test_bloc.dart';

@immutable
sealed class SearchLabTestState {}

final class SearchLabTestInitial extends SearchLabTestState {}

final class SearchLabTestLoading extends SearchLabTestState {}

final class SearchLabTestLoaded extends SearchLabTestState {
  final SearchLabTestModel searchLabTestModel;

  SearchLabTestLoaded({required this.searchLabTestModel});
}

final class SearchLabTestError extends SearchLabTestState {}

//! scan test

final class SearchScanTestInitial extends SearchLabTestState {}

final class SearchScanTestLoading extends SearchLabTestState {}

final class SearchScanTestLoaded extends SearchLabTestState {
  final SearchLabTestModel searchLabTestModel;

  SearchScanTestLoaded({required this.searchLabTestModel});
}

final class SearchScanTestError extends SearchLabTestState {}

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

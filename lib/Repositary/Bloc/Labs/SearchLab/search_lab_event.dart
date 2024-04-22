part of 'search_lab_bloc.dart';

@immutable
abstract class SearchLabEvent {}

class FetchSearchLab extends SearchLabEvent {
  final String labName;

  FetchSearchLab({required this.labName});
}

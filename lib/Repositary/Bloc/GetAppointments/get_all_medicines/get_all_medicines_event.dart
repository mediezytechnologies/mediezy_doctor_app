part of 'get_all_medicines_bloc.dart';

@immutable
abstract class GetAllMedicinesEvent {}


class FetchMedicines extends GetAllMedicinesEvent{
  final String searchQuery;

  FetchMedicines({required this.searchQuery});
}
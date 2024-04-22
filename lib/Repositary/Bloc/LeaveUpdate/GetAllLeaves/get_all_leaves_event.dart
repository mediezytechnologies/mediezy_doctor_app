part of 'get_all_leaves_bloc.dart';

@immutable
abstract class GetAllLeavesEvent {}


class FetchAllLeaves extends GetAllLeavesEvent{
  final String hospitalId;

  FetchAllLeaves({
    required this.hospitalId,
  });
}
part of 'get_all_leaves_bloc.dart';

@immutable
abstract class GetAllLeavesState {}

class GetAllLeavesInitial extends GetAllLeavesState {}
class GetAllLeavesLoading extends GetAllLeavesState {}
class GetAllLeavesLoaded extends GetAllLeavesState {}
class GetAllLeavesError extends GetAllLeavesState {}

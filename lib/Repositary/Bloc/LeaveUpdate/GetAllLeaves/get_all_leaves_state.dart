part of 'get_all_leaves_bloc.dart';

@immutable
abstract class GetAllLeavesState {}

class GetAllLeavesInitial extends GetAllLeavesState {}
class GetAllLeavesLoading extends GetAllLeavesState {
 
 
}
class GetAllLeavesLoaded extends GetAllLeavesState {
 final GetAllLeavesModel getAllLeavesModel;

  GetAllLeavesLoaded({required this.getAllLeavesModel});
}
class GetAllLeavesError extends GetAllLeavesState {}

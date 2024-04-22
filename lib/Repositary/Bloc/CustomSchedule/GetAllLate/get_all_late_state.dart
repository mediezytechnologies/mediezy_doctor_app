part of 'get_all_late_bloc.dart';

@immutable
abstract class GetAllLateState {}

//get all late

class GetAllLateInitial extends GetAllLateState {}

class GetAllLateLoading extends GetAllLateState {}

class GetAllLateLoaded extends GetAllLateState {}

class GetAllLateError extends GetAllLateState {}

//get all early

class GetAllEarlyInitial extends GetAllLateState {}

class GetAllEarlyLoading extends GetAllLateState {}

class GetAllEarlyLoaded extends GetAllLateState {}

class GetAllEarlyError extends GetAllLateState {}


//get all break

class GetAllBreakInitial extends GetAllLateState {}

class GetAllBreakLoading extends GetAllLateState {}

class GetAllBreakLoaded extends GetAllLateState {}

class GetAllBreakError extends GetAllLateState {}


//delete late

class DeleteLateInitial extends GetAllLateState {}

class DeleteLateLoading extends GetAllLateState {}

class DeleteLateLoaded extends GetAllLateState {}

class DeleteLateError extends GetAllLateState {}



//delete late

class DeleteEarlyInitial extends GetAllLateState {}

class DeleteEarlyLoading extends GetAllLateState {}

class DeleteEarlyLoaded extends GetAllLateState {}

class DeleteEarlyError extends GetAllLateState {}


//delete break

class DeleteBreakInitial extends GetAllLateState {}

class DeleteBreakLoading extends GetAllLateState {}

class DeleteBreakLoaded extends GetAllLateState {}

class DeleteBreakError extends GetAllLateState {}
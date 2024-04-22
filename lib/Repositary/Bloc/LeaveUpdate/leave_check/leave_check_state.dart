part of 'leave_check_bloc.dart';

@immutable
abstract class LeaveCheckState {}

class LeaveCheckInitial extends LeaveCheckState {}

class LeaveCheckLoading extends LeaveCheckState {}

class LeaveCheckLoaded extends LeaveCheckState {
  // final LeaveCheckModel leaveCheckModel;
  //
  // LeaveCheckLoaded({required this.leaveCheckModel});
}

class LeaveCheckError extends LeaveCheckState {}

part of 'leave_update_bloc.dart';

@immutable
abstract class LeaveUpdateState {}

class LeaveUpdateInitial extends LeaveUpdateState {}

class LeaveUpdateLoading extends LeaveUpdateState {}

class LeaveUpdateLoaded extends LeaveUpdateState {}

class LeaveUpdateError extends LeaveUpdateState {
  final String errorMessage;

  LeaveUpdateError({required this.errorMessage});
}

//leave delete

class LeaveDeleteInitial extends LeaveUpdateState {}

class LeaveDeleteLoading extends LeaveUpdateState {}

class LeaveDeleteLoaded extends LeaveUpdateState {}

class LeaveDeleteError extends LeaveUpdateState {}

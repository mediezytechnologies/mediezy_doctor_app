part of 'leave_check_bloc.dart';

@immutable
abstract class LeaveCheckEvent {}


class FetchLeaveCheck extends LeaveCheckEvent {

  final String clinicId;
  final String fromDate;
  final String toDate;

  FetchLeaveCheck({
    required this.clinicId,
    required this.fromDate,
    required this.toDate,
  });
}
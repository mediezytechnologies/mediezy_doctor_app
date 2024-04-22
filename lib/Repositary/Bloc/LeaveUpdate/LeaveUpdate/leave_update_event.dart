part of 'leave_update_bloc.dart';

@immutable
abstract class LeaveUpdateEvent {}


class FetchLeaveUpdate extends LeaveUpdateEvent {
  final String clinicId;
  final String fromDate;
  final String toDate;


  FetchLeaveUpdate({required this. clinicId,required this.fromDate,required this.toDate,});
}


//leave delete

class LeaveDelete extends LeaveUpdateEvent {
  final String clinicId;
  final String date;


  LeaveDelete({required this. clinicId,required this.date});
}
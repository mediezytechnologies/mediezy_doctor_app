part of 'time_line_bloc.dart';

@immutable
abstract class TimeLineEvent {}


class FetchTimeLine extends TimeLineEvent{
    final String patientId;
    final String userId;
    FetchTimeLine({
    required this.patientId,
    required this.userId,
});
}

part of 'time_line_bloc.dart';

@immutable
abstract class TimeLineState {}

class TimeLineInitial extends TimeLineState {}

class TimeLineLoading extends TimeLineState {}

class TimeLineLoaded extends TimeLineState {}

class TimeLineError extends TimeLineState {}

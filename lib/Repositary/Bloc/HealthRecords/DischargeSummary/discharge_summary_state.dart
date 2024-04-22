part of 'discharge_summary_bloc.dart';

@immutable
abstract class DischargeSummaryState {}

class DischargeSummaryInitial extends DischargeSummaryState {}

class DischargeSummaryLoading extends DischargeSummaryState {}

class DischargeSummaryLoaded extends DischargeSummaryState {}

class DischargeSummaryError extends DischargeSummaryState {}

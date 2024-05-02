part of 'previous_details_bloc.dart';

@immutable
abstract class PreviousDetailsState {}

class PreviousDetailsInitial extends PreviousDetailsState {}

class PreviousDetailsLoading extends PreviousDetailsState {}

class PreviousDetailsLoaded extends PreviousDetailsState {
  final PreviousAppointmentDetailsModel previousAppointmentDetailsModel;

  PreviousDetailsLoaded({required this.previousAppointmentDetailsModel});
}

class PreviousDetailsError extends PreviousDetailsState {}

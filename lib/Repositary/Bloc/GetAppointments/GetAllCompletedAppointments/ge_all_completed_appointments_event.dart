part of 'ge_all_completed_appointments_bloc.dart';

@immutable
sealed class GetAllCompletedAppointmentsEvent {}

class FetchAllCompletedAppointments extends GetAllCompletedAppointmentsEvent {
  final String date;
  final String clinicId;
  final String scheduleType;

  FetchAllCompletedAppointments({
    required this.date,
    required this.clinicId,
    required this.scheduleType,
  });
}

//! fetch sort patients

// class FetchSortPatients extends GetAllCompletedAppointmentsEvent {
//   final String sort;
//   final String clinicId;
//   final String fromDate;
//   final String toDate;

//   FetchSortPatients({
//     required this.sort,
//     required this.clinicId,
//     required this.fromDate,
//     required this.toDate,
//   });
// }

class FetchAllCompletedAppointmentDetails
    extends GetAllCompletedAppointmentsEvent {
  final String tokenId;

  FetchAllCompletedAppointmentDetails({
    required this.tokenId,
  });
}

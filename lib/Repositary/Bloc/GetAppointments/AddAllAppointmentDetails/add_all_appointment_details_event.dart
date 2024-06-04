part of 'add_all_appointment_details_bloc.dart';

@immutable
abstract class AddAllAppointmentDetailsEvent {}

class AddAllAppointmentDetails extends AddAllAppointmentDetailsEvent {
  final String tokenId;
  final String labId;
  final String labTest;
  final String medicalshopId;

  final String reviewAfter;
  final String notes;
  final String scanId;
  final String scanTest;
  final String? attachment;

  AddAllAppointmentDetails({
    required this.tokenId,
    required this.labId,
    required this.labTest,
    required this.medicalshopId,
    required this.reviewAfter,
    required this.notes,
    required this.scanId,
    required this.scanTest,
    this.attachment,
  });
}

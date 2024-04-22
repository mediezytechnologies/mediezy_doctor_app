part of 'get_prescription_bloc.dart';

@immutable
abstract class GetPrescriptionEvent {}

class FetchGetPrescription extends GetPrescriptionEvent {
  final String patientId;
  final String userId;

  FetchGetPrescription({
    required this.patientId,
    required this.userId,
  });
}

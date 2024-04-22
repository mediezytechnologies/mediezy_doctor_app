part of 'get_prescription_view_bloc.dart';

@immutable
abstract class GetPrescriptionViewEvent {}



class FetchGetPrescriptionView extends GetPrescriptionViewEvent{
    final String patientId;
    final String userId;
    FetchGetPrescriptionView({
    required this.patientId,
    required this.userId,
});
}

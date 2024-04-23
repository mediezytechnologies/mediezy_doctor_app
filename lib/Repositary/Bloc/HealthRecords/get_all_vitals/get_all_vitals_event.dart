part of 'get_all_vitals_bloc.dart';

@immutable
abstract class GetAllVitalsEvent {}


class FetchVitals extends GetAllVitalsEvent {
  final String patientId;

  FetchVitals({required this.patientId});
}
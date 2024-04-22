part of 'suggest_doctor_bloc.dart';

@immutable
abstract class SuggestDoctorEvent {}

class AddSuggestDoctorEvent extends SuggestDoctorEvent {
  final String doctorName;
  final String location;
  final String clinicName;
  final String specialization;
  final String phoneNumber;

  AddSuggestDoctorEvent(
      {required this.doctorName,
        required this.location,
        required this.clinicName,
        required this.specialization,
        required this.phoneNumber});
}
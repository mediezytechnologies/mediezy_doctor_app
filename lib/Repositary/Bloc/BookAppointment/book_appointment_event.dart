part of 'book_appointment_bloc.dart';

@immutable
abstract class BookAppointmentEvent {}

class PassBookAppointMentEvent extends BookAppointmentEvent {
  final String patientName;
  final String date;
  final String regularmedicine;
  final String whenitcomes;
  final String whenitstart;
  final String tokenTime;
  final String tokenNumber;
  final String gender;
  final String age;
  final String mobileNo;
  final String clinicId;
  final String scheduleType;
  final List<String> appoinmentfor1;
  final List<int> appoinmentfor2;

  PassBookAppointMentEvent({
    required this.patientName,
    required this.clinicId,
    required this.date,
    required this.regularmedicine,
    required this.whenitcomes,
    required this.whenitstart,
    required this.tokenTime,
    required this.tokenNumber,
    required this.gender,
    required this.age,
    required this.mobileNo,
    required this.appoinmentfor1,
    required this.appoinmentfor2,
    required this.scheduleType,
  });
}

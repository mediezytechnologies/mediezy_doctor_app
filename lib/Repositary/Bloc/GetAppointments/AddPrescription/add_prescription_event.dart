part of 'add_prescription_bloc.dart';

@immutable
abstract class AddPrescriptionEvent {}


class FetchAddPrescription extends AddPrescriptionEvent{
  final String bookedPersonId;
  final String medicineName;
  final String dosage;
  final String noOfDays;
  final String type;
  final String night;
  final String morning;
  final String noon;
  final String tokenId;
  final String evening;
  final String medicalStoreId;
  final String timeSection;
  final String interval;

  FetchAddPrescription({
    required this.medicineName,
    required this.bookedPersonId,
    required this.dosage,
    required this.noOfDays,
    required this.type,
    required this.night,
    required this.morning,
    required this.noon,
    required this.tokenId,
    required this.evening,
    required this.medicalStoreId,
    required this.timeSection,
    required this.interval,
});
}
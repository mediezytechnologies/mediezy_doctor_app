part of 'edit_medicine_bloc.dart';

@immutable
abstract class EditMedicineEvent {}


class EditMedicine extends EditMedicineEvent{
  final String medicineId;
  final String medicineName;
  final String dosage;
  final String noOfDays;
  final String type;
  final String night;
  final String morning;
  final String noon;
  final String evening;
  final String interval;
  final String timeSection;

  EditMedicine({
    required this.medicineName,
    required this.medicineId,
    required this.dosage,
    required this.noOfDays,
    required this.type,
    required this.night,
    required this.morning,
    required this.noon,
    required this.evening,
    required this.timeSection,
    required this.interval,
  });
}

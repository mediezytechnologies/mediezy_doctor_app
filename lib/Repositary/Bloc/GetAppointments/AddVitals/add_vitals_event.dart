part of 'add_vitals_bloc.dart';

@immutable
abstract class AddVitalsEvent {}

class AddVitals extends AddVitalsEvent {
  final String tokenId;
  final String height;
  final String weight;
  final String temperature;
  final String temperatureType;
  final String spo2;
  final String sys;
  final String dia;
  final String heartRate;

  AddVitals(
      {required this.height,
      required this.weight,
      required this.temperature,
      required this.temperatureType,
      required this.spo2,
      required this.sys,
      required this.dia,
      required this.heartRate,
      required this.tokenId});
}

//edit vitals

class EditVitals extends AddVitalsEvent {
  final String tokenId;
  final String height;
  final String weight;
  final String temperature;
  final String temperatureType;
  final String spo2;
  final String sys;
  final String dia;
  final String heartRate;

  EditVitals(
      {required this.height,
      required this.weight,
      required this.temperature,
      required this.temperatureType,
      required this.spo2,
      required this.sys,
      required this.dia,
      required this.heartRate,
      required this.tokenId});
}

//delete vitals

class DeleteVitals extends AddVitalsEvent {
  final String tokenId;

  DeleteVitals({required this.tokenId});
}

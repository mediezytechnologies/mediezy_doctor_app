part of 'patients_get_bloc.dart';

@immutable
abstract class PatientsGetState {}

class PatientsGetInitial extends PatientsGetState {}
class PatientsGetLoading extends PatientsGetState {}
class PatientsGetLoaded extends PatientsGetState {}
class PatientsGetError extends PatientsGetState {}

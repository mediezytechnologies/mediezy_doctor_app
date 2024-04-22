part of 'patients_get_bloc.dart';

@immutable
abstract class PatientsGetEvent {}

class FetchPatients extends PatientsGetEvent {
  final String clinicId;

  FetchPatients({required this.clinicId});
}

class FetchSearchPatients extends PatientsGetEvent {
  final String searchQuery;

  FetchSearchPatients({
    required this.searchQuery,
  });
}



class FetchSortPatients extends PatientsGetEvent {
  final String sort;
  final String clinicId;
  final String fromDate;
  final String toDate;

  FetchSortPatients({
    required this.sort,
    required this.clinicId,
    required this.fromDate,
    required this.toDate,
  });
}
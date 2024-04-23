part of 'get_all_vitals_bloc.dart';

@immutable
abstract class GetAllVitalsState {}

class GetAllVitalsInitial extends GetAllVitalsState {}

class GetAllVitalsLoading extends GetAllVitalsState {}

class GetAllVitalsLoaded extends GetAllVitalsState {
  final GetVitalsModel getVitalsModel;

  GetAllVitalsLoaded({required this.getVitalsModel});
}

class GetAllVitalsError extends GetAllVitalsState {
  final String errorMessage;

  GetAllVitalsError({required this.errorMessage});

}

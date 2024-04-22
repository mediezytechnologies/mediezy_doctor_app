part of 'get_all_scanning_centre_bloc.dart';

@immutable
abstract class GetAllScanningCentreState {}

class GetAllScanningCentreInitial extends GetAllScanningCentreState {}

class GetAllScanningCentreLoading extends GetAllScanningCentreState {}
class GetAllScanningCentreLoaded extends GetAllScanningCentreState {}
class GetAllScanningCentreError extends GetAllScanningCentreState {}
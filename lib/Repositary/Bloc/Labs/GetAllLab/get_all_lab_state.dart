part of 'get_all_lab_bloc.dart';

@immutable
abstract class GetAllLabState {}

class GetAllLabInitial extends GetAllLabState {}
class GetAllLabLoading extends GetAllLabState {}
class GetAllLabLoaded extends GetAllLabState {}
class GetAllLabError extends GetAllLabState {}


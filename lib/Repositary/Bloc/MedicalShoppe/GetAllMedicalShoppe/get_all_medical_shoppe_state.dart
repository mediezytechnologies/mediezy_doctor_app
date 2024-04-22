part of 'get_all_medical_shoppe_bloc.dart';

@immutable
abstract class GetAllMedicalShoppeState {}

class GetAllMedicalShoppeInitial extends GetAllMedicalShoppeState {}

class GetAllMedicalShoppeLoading extends GetAllMedicalShoppeState {}

class GetAllMedicalShoppeLoaded extends GetAllMedicalShoppeState {}

class GetAllMedicalShoppeError extends GetAllMedicalShoppeState {}

part of 'get_all_favourite_medical_store_bloc.dart';

@immutable
sealed class GetAllFavouriteMedicalStoreState {}

final class GetAllFavouriteMedicalStoreInitial extends GetAllFavouriteMedicalStoreState {}

class GetAllFavouriteMedicalStoreLoading extends GetAllFavouriteMedicalStoreState{}
class GetAllFavouriteMedicalStoreLoaded extends GetAllFavouriteMedicalStoreState{}
class GetAllFavouriteMedicalStoreError extends GetAllFavouriteMedicalStoreState{}


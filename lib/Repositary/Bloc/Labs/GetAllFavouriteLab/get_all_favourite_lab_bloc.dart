import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:meta/meta.dart';

part 'get_all_favourite_lab_event.dart';
part 'get_all_favourite_lab_state.dart';

class GetAllFavouriteLabBloc
    extends Bloc<GetAllFavouriteLabEvent, GetAllFavouriteLabState> {
  late GetAllFavouriteLabModel getAllFavouriteLabModel;
  LabsApi labsApi = LabsApi();
  GetAllFavouriteLabBloc() : super(GetAllFavouriteLabInitial()) {
    on<FetchAllFavouriteLab>((event, emit) async {
      emit(GetAllFavouriteLabLoading());
      try {
        getAllFavouriteLabModel = await labsApi.getAllFavouriteLabs();
        emit(GetAllFavouriteLabLoaded());
      } catch (error) {
        log("<<<<<<<<<<GetAll Favourite lab Error>>>>>>>>>>$error");
        emit(GetAllFavouriteLabError());
      }
    });
  }
}

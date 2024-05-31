import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Api/Profile/profile_get_api.dart';
part 'profile_get_event.dart';
part 'profile_get_state.dart';

class ProfileGetBloc extends Bloc<ProfileGetEvent, ProfileGetState> {
  ProfileGetApi profileGetApi = ProfileGetApi();
  ProfileGetBloc() : super(ProfileGetInitial()) {
    on<FetchProfileGet>((event, emit) async {
      emit(ProfileGetLoading());
      try {
        final profileGetModel = await profileGetApi.getProfileGet();
        emit(ProfileGetLoaded(profileGetModel: profileGetModel));
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(ProfileGetError());
      }
    });
  }
}

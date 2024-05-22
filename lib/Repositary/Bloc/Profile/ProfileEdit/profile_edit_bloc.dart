import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileEditModel.dart';
import 'package:mediezy_doctor/Repositary/Api/Profile/profile_get_api.dart';
import 'package:meta/meta.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  late ProfileEditModel profileEditModel;
  ProfileGetApi profileGetApi = ProfileGetApi();

  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<FetchProfileEdit>((event, emit) async {
      emit(ProfileEditLoading());
      try {
        profileEditModel = await profileGetApi.getProfileEdit(
            firstname: event.firstname,
            secondname: event.secondname,
            mobileNo: event.mobileNo,
            attachment: event.attachment);
        emit(ProfileEditLoaded());
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(ProfileEditError());
      }
    });
  }
}

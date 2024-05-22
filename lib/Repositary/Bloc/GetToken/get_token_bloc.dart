import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetToken/get_token_api.dart';
part 'get_token_event.dart';
part 'get_token_state.dart';

class GetTokenBloc extends Bloc<GetTokenEvent, GetTokenState> {
  late GetTokenModel getTokenModel;
  GetTokenApi getTokenApi = GetTokenApi();
  GetTokenBloc() : super(GetTokenInitial()) {
    on<FetchTokens>((event, emit) async {
      emit(GetTokenLoading());
      try {
        getTokenModel = await getTokenApi.getToken(
          date: event.date,
          clinicId: event.clinicId,
        );
        emit(GetTokenLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetTokenError());
      }
    });
  }
}

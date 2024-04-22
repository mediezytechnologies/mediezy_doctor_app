import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/LiveToken/get_current_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/LiveToken/live_token_api.dart';
import 'package:meta/meta.dart';

part 'get_current_token_event.dart';

part 'get_current_token_state.dart';

class GetCurrentTokenBloc
    extends Bloc<GetCurrentTokenEvent, GetCurrentTokenState> {
  late GetCurrentTokenModel getCurrentTokenModel;
  GetCurrentTokenApi getCurrentTokenApi = GetCurrentTokenApi();

  GetCurrentTokenBloc() : super(GetCurrentTokenInitial()) {
    on<FetchGetCurrentToken>((event, emit) async {
      emit(GetCurrentTokenLoading());
      try {
        getCurrentTokenModel = await getCurrentTokenApi.getCurrentToken(
            clinicId: event.clinicId, scheduleType: event.scheduleType);
        emit(GetCurrentTokenLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetCurrentTokenError());
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GenerateToken/generate_token_api.dart';

part 'get_clinic_event.dart';

part 'get_clinic_state.dart';

class GetClinicBloc extends Bloc<GetClinicEvent, GetClinicState> {
  late ClinicGetModel clinicGetModel;
  GenerateTokenApi generateTokenApi = GenerateTokenApi();

  GetClinicBloc() : super(GetClinicInitial()) {
    on<FetchGetClinic>((event, emit) async {
      emit(GetClinicLoading());
      try {
        clinicGetModel = await generateTokenApi.getClinic();
        emit(GetClinicLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(GetClinicError());
      }
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GenerateToken/generate_token_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

part 'generate_token_final_event.dart';

part 'generate_token_final_state.dart';

class GenerateTokenFinalBloc
    extends Bloc<GenerateTokenFinalEvent, GenerateTokenFinalState> {
  late String updatedSuccessfully;
  GenerateTokenApi generateTokenApi = GenerateTokenApi();

  GenerateTokenFinalBloc() : super(GenerateTokenFinalInitial()) {
    on<FetchGenerateTokenFinal>((event, emit) async {
      emit(GenerateTokenFinalLoading());
      try {
        updatedSuccessfully = await generateTokenApi.getGenerateTokenFinal(
            selecteddays: event.selecteddays,
            clinicId: event.clinicId,
            startDate: event.startDate,
            endDate: event.endDate,
            startTime: event.startTime,
            endTime: event.endTime,
            timeDuration: event.timeDuration,
            scheduleType: event.scheduleType);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);

        emit(GenerateTokenFinalLoaded(
            successMessage: data['message'].toString()));
      } catch (e) {
        final errorWithTimestamp = "$e";
        print("Error: $errorWithTimestamp");
        emit(GenerateTokenFinalError(errorMessage: errorWithTimestamp));
      }
    });
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GenerateToken/generated_schedules.dart';
import 'package:mediezy_doctor/Repositary/Api/GenerateToken/generate_token_api.dart';
import 'package:meta/meta.dart';

part 'generated_schedules_event.dart';
part 'generated_schedules_state.dart';

class GeneratedSchedulesBloc
    extends Bloc<GeneratedSchedulesEvent, GeneratedSchedulesState> {
  GenerateTokenApi generateTokenApi = GenerateTokenApi();
  GeneratedSchedulesBloc() : super(GeneratedSchedulesInitial()) {
    on<FetchGeneratedSchedules>((event, emit) async {
      emit(GeneratedSchedulesLoading());
      try {
        final model = await generateTokenApi.getSchedules();
        emit(GeneratedSchedulesLoaded(generatedSchedulesModel: model));
      } catch (e) {
        log(e.toString());
        emit(GeneratedSchedulesError());
      }
    });
  }
}

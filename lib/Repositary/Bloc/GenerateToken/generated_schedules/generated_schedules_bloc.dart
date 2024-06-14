import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GenerateToken/generated_schedules.dart';
import 'package:mediezy_doctor/Repositary/Api/GenerateToken/generate_token_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'generated_schedules_event.dart';
part 'generated_schedules_state.dart';

class GeneratedSchedulesBloc
    extends Bloc<GeneratedSchedulesEvent, GeneratedSchedulesState> {
  late String updatedSuccessfully;
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

    //! delete schedules
    on<DeleteGeneratedSchedules>((event, emit) async {
      emit(DeleteSchedulesLoading());
      try {
        updatedSuccessfully = await generateTokenApi.deleteSchedules(
            scheduleId: event.scheduleId);
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(DeleteSchedulesLoaded(successMessage: data['message'].toString()));
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        log(e.toString());
        emit(DeleteSchedulesError(errorMessage: e.toString()));
      }
    });
  }
}

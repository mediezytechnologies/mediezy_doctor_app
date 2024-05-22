import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/MessageShowModel/message_show_model.dart';
import 'package:mediezy_doctor/Repositary/Api/CustomSchedule/custom_schedule_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'late_schedule_event.dart';

part 'late_schedule_state.dart';

class LateScheduleBloc extends Bloc<LateScheduleEvent, LateScheduleState> {
  late String updatedSuccessfully;
  late MessageShowModel messageShowModel;
  CustomScheduleApi customScheduleApi = CustomScheduleApi();

  LateScheduleBloc() : super(LateScheduleInitial()) {
    on<AddLateSchedule>((event, emit) async {
      emit(LateScheduleLoading());
      try {
        updatedSuccessfully = await customScheduleApi.addLateSchedule(
          date: event.date,
          clinicId: event.clinicId,
          scheduleType: event.scheduleType,
          timeDuration: event.timeDuration,
        );
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
        emit(LateScheduleLoaded());
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LateScheduleError(errorMessage: '$e'));
      }
    });

    // early schedule

    on<AddEarlySchedule>((event, emit) async {
      emit(EarlyScheduleLoading());
      try {
        messageShowModel = await customScheduleApi.addEarlySchedule(
          date: event.date,
          clinicId: event.clinicId,
          scheduleType: event.scheduleType,
          timeDuration: event.timeDuration,
        );
        // Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        // GeneralServices.instance.showSuccessMessage(context, title);
        emit(EarlyScheduleLoaded());
      } catch (e) {
        final error = "$e";
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(EarlyScheduleError(errorMessage: error));
      }
    });
  }
}

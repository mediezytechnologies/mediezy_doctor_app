import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/CustomSchedule/custom_schedule_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'between_schedule_event.dart';

part 'between_schedule_state.dart';

class BetweenScheduleBloc
    extends Bloc<BetweenScheduleEvent, BetweenScheduleState> {
  late String updatedSuccessfully;
  CustomScheduleApi customScheduleApi = CustomScheduleApi();

  BetweenScheduleBloc() : super(BetweenScheduleInitial()) {
    on<FetchBetweenSchedule>((event, emit) async {
      emit(BetweenScheduleLoading());
      try {
        updatedSuccessfully = await customScheduleApi.getBetweenSchedule(
          clinicId: event.clinicId,
          startTime: event.startTime,
          endTime: event.endTime,
          startDate: event.startDate,
          endDate: event.endDate,
          scheduleType: event.scheduleType,
        );
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
        emit(BetweenScheduleLoaded());
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(BetweenScheduleError(errorMessage: '$e'));
      }
    });
  }
}

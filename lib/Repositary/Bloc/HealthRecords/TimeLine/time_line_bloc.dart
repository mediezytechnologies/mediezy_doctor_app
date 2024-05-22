import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/time_line_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  late TimeLineModel timeLineModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  TimeLineBloc() : super(TimeLineInitial()) {
    on<FetchTimeLine>((event, emit) async {
      emit(TimeLineLoading());
      try {
        timeLineModel = await healthRecordsApi.getTimeLine(
            patientId: event.patientId, userId: event.userId);
        emit(TimeLineLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(TimeLineError());
      }
    });
  }
}

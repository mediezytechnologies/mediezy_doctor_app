import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/leave_check_model/leave_check_model.dart';
import 'package:mediezy_doctor/Repositary/Api/LeaveUpdate/leave_update_api.dart';
import 'package:meta/meta.dart';

part 'leave_check_event.dart';

part 'leave_check_state.dart';

class LeaveCheckBloc extends Bloc<LeaveCheckEvent, LeaveCheckState> {
  LeaveUpdateApi leaveUpdateApi = LeaveUpdateApi();
  late LeaveCheckModel leaveCheckModel;

  LeaveCheckBloc() : super(LeaveCheckInitial()) {
    on<FetchLeaveCheck>((event, emit) async {
      emit(LeaveCheckLoading());
      try {
        leaveCheckModel = await leaveUpdateApi.getCheckLeave(
          clinicId: event.clinicId,
          fromDate: event.fromDate,
          toDate: event.toDate,
        );
        emit(LeaveCheckLoaded(
            // leaveCheckModel: leaveCheckModel
            ));
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LeaveCheckError());
      }
    });
  }
}

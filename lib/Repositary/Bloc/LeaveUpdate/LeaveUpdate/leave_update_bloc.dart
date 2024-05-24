import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mediezy_doctor/Repositary/Api/LeaveUpdate/leave_update_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
part 'leave_update_event.dart';
part 'leave_update_state.dart';

class LeaveUpdateBloc extends Bloc<LeaveUpdateEvent, LeaveUpdateState> {
  late String updatedSuccessfully;
  LeaveUpdateApi leaveUpdateApi = LeaveUpdateApi();
  LeaveUpdateBloc() : super(LeaveUpdateInitial()) {
    on<FetchLeaveUpdate>((event, emit) async {
      emit(LeaveUpdateLoading());
      try {
        updatedSuccessfully = await leaveUpdateApi.getLeaveUpdate(
          fromDate: event.fromDate,
          clinicId: event.clinicId,
          toDate: event.toDate,
        );
        emit(LeaveUpdateLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LeaveUpdateError());
      }
    });

//leave delete

    on<LeaveDelete>((event, emit) async {
      emit(LeaveDeleteLoading());
      try {
        updatedSuccessfully = await leaveUpdateApi.leaveDelete(
          date: event.date,
          clinicId: event.clinicId,
        );
        emit(LeaveDeleteLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LeaveDeleteError());
      }
    });
  }
}

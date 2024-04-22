import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediezy_doctor/Repositary/Api/LeaveUpdate/leave_update_api.dart';
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
        showToastMessage(data['message']);
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
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
        showToastMessage(data['message']);
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(LeaveDeleteError());
      }
    });
  }
}

//* to show toast
showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade600,
      textColor: Colors.white,
      fontSize: 16.sp);
}

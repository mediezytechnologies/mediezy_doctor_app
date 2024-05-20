import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/custom_schedule_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DeleteTokens/delete_tokens_api.dart';

part 'delete_tokens_event.dart';

part 'delete_tokens_state.dart';

class DeleteTokensBloc extends Bloc<DeleteTokensEvent, DeleteTokensState> {
  late CustomScheduleModel customScheduleModel;
  late String uploadSuccessfully;
  DeleteTokensApi deleteTokensApi = DeleteTokensApi();

  DeleteTokensBloc() : super(DeleteTokensInitial()) {
    on<FetchDeleteTokens>((event, emit) async {
      emit(DeleteTokensLoading());
      try {
        uploadSuccessfully = await deleteTokensApi.getDeleteToken(
          tokenId: event.tokenId,
          // hospitalId: event.hospitalId,
          // tokenNumbers: event.tokenNumbers,
          // scheduleType: event.scheduleType,
        );
        emit(DeleteTokensLoaded());
        Map<String, dynamic> data = jsonDecode(uploadSuccessfully);
        showToastMessage(data['message']);
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(DeleteTokensError(errorMessage: '$e'));
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

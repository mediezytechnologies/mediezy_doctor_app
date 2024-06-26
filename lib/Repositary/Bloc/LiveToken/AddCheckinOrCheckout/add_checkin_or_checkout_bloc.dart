import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/LiveToken/live_token_api.dart';
import 'package:meta/meta.dart';

import '../../LeaveUpdate/LeaveUpdate/leave_update_bloc.dart';

part 'add_checkin_or_checkout_event.dart';

part 'add_checkin_or_checkout_state.dart';

class AddCheckinOrCheckoutBloc
    extends Bloc<AddCheckinOrCheckoutEvent, AddCheckinOrCheckoutState> {
  late String updatedSuccessfully;
  GetCurrentTokenApi getCurrentTokenApi = GetCurrentTokenApi();

  AddCheckinOrCheckoutBloc() : super(AddCheckinOrCheckoutInitial()) {
    on<AddCheckinOrCheckout>((event, emit) async {
      emit(AddCheckinOrCheckoutLoading());
      try {
        updatedSuccessfully = await getCurrentTokenApi.addCheckinOrCheckout(
            tokenNumber: event.tokenNumber,
            isCheckIn: event.isCheckin,
            isCompleted: event.isCompleted,
            clinicId: event.clinicId,
            isReached: event.isReached);
        emit(AddCheckinOrCheckoutLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        showToastMessage(data['message']);
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(AddCheckinOrCheckoutError());
      }
    });
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/LiveToken/live_token_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

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
        GeneralServices.instance.showToastMessage(data['message']);
        log("checkin first call :${data['message']}");
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(AddCheckinOrCheckoutError(errorMessage: '$e'));
      }
    });

//! estimate time update checkin

    on<EstimateUpdateCheckin>((event, emit) async {
      emit(EstimateUpdateCheckinLoading());
      try {
        updatedSuccessfully = await getCurrentTokenApi.estimateUpdateCheckin(
          tokenId: event.tokenId,
        );
        emit(EstimateUpdateCheckinLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        log("checkin second call :${data['message']}");
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(EstimateUpdateCheckinError());
      }
    });

    //! estimate time update checkout

    on<EstimateUpdateCheckout>((event, emit) async {
      emit(EstimateUpdateCheckoutLoading());
      try {
        updatedSuccessfully = await getCurrentTokenApi.estimateUpdateCheckout(
          tokenId: event.tokenId,
        );
        emit(EstimateUpdateCheckoutLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        log("checkout second call :${data['message']}");
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(EstimateUpdateCheckoutError());
      }
    });
  }
}

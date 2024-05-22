import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetReservedTokensModel/GetReservedTokensModel.dart';
import 'package:mediezy_doctor/Repositary/Api/ReserveTokenApi/reserve_token_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'reserve_token_event.dart';

part 'reserve_token_state.dart';

class ReserveTokenBloc extends Bloc<ReserveTokenEvent, ReserveTokenState> {
  late String uploadSuccessfully;

  // late GetReservedTokensModel getReservedTokensModel;
  ReserveTokenApi reserveTokenApi = ReserveTokenApi();

  ReserveTokenBloc() : super(ReserveTokenInitial()) {
    on<AddReserveToken>((event, emit) async {
      emit(ReserveTokenLoading());
      try {
        uploadSuccessfully = await reserveTokenApi.addReserveToken(
            tokenNumber: event.tokenNumber,
            fromDate: event.fromDate,
            toDate: event.toDate,
            clinicId: event.clinicId);
        emit(ReserveTokenLoaded());
        Map<String, dynamic> data = jsonDecode(uploadSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        log("Error: $errorWithTimestamp");
        emit(ReserveTokenError(errorMessage: errorWithTimestamp));
      }
    });

    //un reserve token

    on<UnReserveToken>((event, emit) async {
      emit(UnReserveTokenLoading());
      try {
        uploadSuccessfully = await reserveTokenApi.unReserveToken(
          tokenNumber: event.tokenNumber,
          fromDate: event.fromDate,
          toDate: event.toDate,
          clinicId: event.clinicId,
        );
        emit(UnReserveTokenLoaded());
        Map<String, dynamic> data = jsonDecode(uploadSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        log("Error: $errorWithTimestamp");
        emit(UnReserveTokenError(errorMessage: errorWithTimestamp));
      }
    });

    //get reserved tokens

    on<FetchReservedTokens>((event, emit) async {
      emit(ReservedTokensLoading());
      try {
        final getReservedTokensModel = await reserveTokenApi.getReservedTokens(
          fromDate: event.fromDate,
          toDate: event.toDate,
          clinicId: event.clinicId,
        );
        emit(ReservedTokensLoaded(
            getReservedTokensModel: getReservedTokensModel));
      } catch (e) {
        log("Error: >>>>>>>>>>>>>>>>>>$e");
        emit(ReservedTokensError());
      }
    });
  }
}

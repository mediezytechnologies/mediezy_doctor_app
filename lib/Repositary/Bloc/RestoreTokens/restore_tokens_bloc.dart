
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/get_delete_tokens_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/restore_dates_model.dart';
import 'package:mediezy_doctor/Repositary/Api/RestoreTokensApi/restore_tokens_api.dart';
import 'package:meta/meta.dart';

part 'restore_tokens_event.dart';

part 'restore_tokens_state.dart';

class RestoreTokensBloc extends Bloc<RestoreTokensEvent, RestoreTokensState> {
  late RestoreDatesModel restoreDatesModel;
  late GetDeleteTokensModel getDeleteTokensModel;
  late String updatedSuccessfully;
  RestoreTokensApi restoreTokensApi = RestoreTokensApi();

  RestoreTokensBloc() : super(RestoreDatesInitial()) {
    on<FetchRestoreDates>((event, emit) async {
      emit(RestoreDatesLoading());
      try {
        restoreDatesModel =
            await restoreTokensApi.getDates(clinicId: event.clinicId);
        emit(RestoreDatesLoaded());
      } catch (e) {
        emit(RestoreDatesError());
      }
    });

    on<AddRestoreTokens>((event, emit) async {
      emit(AddRestoreTokensLoading());
      try {
        updatedSuccessfully =
            await restoreTokensApi.addRestoreToken(tokenId: event.tokenId);
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(
            AddRestoreTokensLoaded(successMessage: data["message"].toString()));
      } catch (e) {
        final error = "$e";
        emit(AddRestoreTokensError(errorMessage: error));
      }
    });
  }
}

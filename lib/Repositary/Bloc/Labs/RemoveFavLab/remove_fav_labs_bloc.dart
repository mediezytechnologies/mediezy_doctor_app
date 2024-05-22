import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'remove_fav_labs_event.dart';
part 'remove_fav_labs_state.dart';

class RemoveFavLabsBloc extends Bloc<RemoveFavLabsEvent, RemoveFavLabsState> {
  late String updatedSuccessfullyMessage;
  LabsApi labsApi = LabsApi();
  RemoveFavLabsBloc() : super(RemoveFavLabsInitial()) {
    on<RemoveFavouritesLab>((event, emit) async {
      emit(RemoveFavLabsLoading());
      try {
        updatedSuccessfullyMessage =
            await labsApi.removeLabFavourites(labId: event.labId);
        emit(RemoveFavLabsLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (error) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$error");
        emit(RemoveFavLabsError());
      }
    });
  }
}

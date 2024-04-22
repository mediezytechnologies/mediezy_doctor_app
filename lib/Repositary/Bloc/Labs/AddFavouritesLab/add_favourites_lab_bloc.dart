import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'add_favourites_lab_event.dart';
part 'add_favourites_lab_state.dart';

class AddFavouritesLabBloc
    extends Bloc<AddFavouritesLabEvent, AddFavouritesLabState> {
  late String updatedSuccessfullyMessage;
  LabsApi labsApi = LabsApi();
  AddFavouritesLabBloc() : super(AddFavouritesLabInitial()) {
    on<AddFavouritesLab>((event, emit) async {
      emit(AddFavouritesLabLoading());
      try {
        updatedSuccessfullyMessage =
            await labsApi.addLabFavourites(labId: event.labId);
        emit(AddFavouritesLabLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(AddFavouritesLabError());
      }
    });
  }
}

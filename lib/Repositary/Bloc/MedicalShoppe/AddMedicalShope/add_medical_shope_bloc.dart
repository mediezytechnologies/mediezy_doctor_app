import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/MedicalShoppe/medical_shoppe_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'add_medical_shope_event.dart';
part 'add_medical_shope_state.dart';

class AddMedicalShopeBloc
    extends Bloc<AddMedicalShopeEvent, AddMedicalShopeState> {
  late String updatedSuccessfullyMessage;
  MedicalShoppeApi medicalShoppeApi = MedicalShoppeApi();
  AddMedicalShopeBloc() : super(AddMedicalShopeInitial()) {
    on<AddMedicalShope>((event, emit) async {
      emit(AddMedicalShopeLoading());
      try {
        updatedSuccessfullyMessage =
            await medicalShoppeApi.addFavouriteMedicalShope(
          medicalShopeId: event.medicalShopeId,
        );
        emit(AddMedicalShopeLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (error) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$error");
        emit(AddMedicalShopeError());
      }
    });
  }
}

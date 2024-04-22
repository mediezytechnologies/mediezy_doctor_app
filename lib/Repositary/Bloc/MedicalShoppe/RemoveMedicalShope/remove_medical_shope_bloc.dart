import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/MedicalShoppe/medical_shoppe_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';
part 'remove_medical_shope_event.dart';
part 'remove_medical_shope_state.dart';

class RemoveMedicalShopeBloc
    extends Bloc<RemoveMedicalShopeEvent, RemoveMedicalShopeState> {
  late String updatedSuccessfullyMessage;
  MedicalShoppeApi medicalShoppeApi = MedicalShoppeApi();
  RemoveMedicalShopeBloc() : super(RemoveMedicalShopeInitial()) {
    on<RemoveMedicalShope>((event, emit) async {
      emit(RemoveMedicalShopeLoading());
      try {
        updatedSuccessfullyMessage =
            await medicalShoppeApi.removeFavouriteMedicalShope(
          medicalShopeId: event.medicalShopeId,
        );
        emit(RemoveMedicalShopeLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfullyMessage);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(RemoveMedicalShopeError());
      }
    });
  }
}

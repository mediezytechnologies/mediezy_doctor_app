import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'update_favourite_medicine_event.dart';
part 'update_favourite_medicine_state.dart';

class UpdateFavouriteMedicineBloc
    extends Bloc<UpdateFavouriteMedicineEvent, UpdateFavouriteMedicineState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  UpdateFavouriteMedicineBloc() : super(UpdateFavouriteMedicineInitial()) {
    on<UpdateFavouriteMedicine>((event, emit) async {
      emit(UpdateFavouriteMedicineLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.updateFavouriteMedicine(
            medicineId: event.medicineId);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(UpdateFavouriteMedicineLoaded(
            successMessage: data['message'].toString()));
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        log("Error: $errorWithTimestamp");
        emit(UpdateFavouriteMedicineError(errorMessage: errorWithTimestamp));
      }
    });
  }
}

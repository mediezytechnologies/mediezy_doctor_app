import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'add_vitals_event.dart';

part 'add_vitals_state.dart';

class AddVitalsBloc extends Bloc<AddVitalsEvent, AddVitalsState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  AddVitalsBloc() : super(AddVitalsInitial()) {
    on<AddVitals>((event, emit) async {
      emit(AddVitalsLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.addVitals(
            tokenId: event.tokenId,
            height: event.height,
            weight: event.weight,
            temperature: event.temperature,
            spo2: event.spo2,
            sys: event.sys,
            dia: event.dia,
            heartRate: event.heartRate, temperatureType: event.temperatureType);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(AddVitalsLoaded(successMessage: data['message'].toString()));
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        print("Error: $errorWithTimestamp");
        emit(AddVitalsError(errorMessage: errorWithTimestamp));
      }
    });

//edit vitals

    on<EditVitals>((event, emit) async {
      emit(EditVitalsLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.addVitals(
            tokenId: event.tokenId,
            height: event.height,
            weight: event.weight,
            temperature: event.temperature,
            spo2: event.spo2,
            sys: event.sys,
            dia: event.dia,
            heartRate: event.heartRate, temperatureType: event.temperatureType);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(EditVitalsLoaded(successMessage: data['message'].toString()));
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        print("Error: $errorWithTimestamp");
        emit(EditVitalsError(errorMessage: errorWithTimestamp));
      }
    });


    //edit vitals

    on<DeleteVitals>((event, emit) async {
      emit(DeleteVitalsLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.deleteVitals(
            tokenId: event.tokenId,);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(DeleteVitalsLoaded(successMessage: data['message'].toString()));
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        final errorWithTimestamp = "$e";
        print("Error: $errorWithTimestamp");
        emit(DeleteVitalsError(errorMessage: errorWithTimestamp));
      }
    });
  }
}

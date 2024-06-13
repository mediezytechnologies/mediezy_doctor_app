import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/add_prescription_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'add_prescription_event.dart';

part 'add_prescription_state.dart';

class AddPrescriptionBloc
    extends Bloc<AddPrescriptionEvent, AddPrescriptionState> {
  late AddPrescriptionModel addPrescriptionModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  AddPrescriptionBloc() : super(AddPrescriptionInitial()) {
    on<FetchAddPrescription>((event, emit) async {
      emit(AddPrescriptionLoading());
      try {
        addPrescriptionModel = await getAppointmentApi.getAddPresscription(
            medicineName: event.medicineName,
            dosage: event.dosage,
            noOfDays: event.noOfDays,
            type: event.type,
            night: event.night,
            morning: event.morning,
            noon: event.noon,
            bookedPersonId: event.bookedPersonId,
            tokenId: event.tokenId,
            evening: event.evening,
            medicalStoreId: event.medicalStoreId,
            timeSection: event.timeSection,
            interval: event.interval,
            medicineId: event.medicineId);
        emit(AddPrescriptionLoaded());
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(AddPrescriptionError(errorMessage: '$e'));
      }
    });
  }
}

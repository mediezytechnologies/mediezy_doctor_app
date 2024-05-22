import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'edit_medicine_event.dart';

part 'edit_medicine_state.dart';

class EditMedicineBloc extends Bloc<EditMedicineEvent, EditMedicineState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  EditMedicineBloc() : super(EditMedicineInitial()) {
    on<EditMedicine>((event, emit) async {
      emit(EditMedicineLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.editPrescription(
            medicineId: event.medicineId,
            medicineName: event.medicineName,
            dosage: event.dosage,
            noOfDays: event.noOfDays,
            type: event.type,
            night: event.night,
            morning: event.morning,
            noon: event.noon,
            evening: event.evening,
            timeSection: event.timeSection,
            interval: event.interval);
        emit(EditMedicineLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        log(">>>>>>>>>>>>>>>>>$e");
        emit(EditMedicineError());
      }
    });
  }
}

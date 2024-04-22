import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'delete_medicine_event.dart';

part 'delete_medicine_state.dart';

class DeleteMedicineBloc
    extends Bloc<DeleteMedicineEvent, DeleteMedicineState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  DeleteMedicineBloc() : super(DeleteMedicineInitial()) {
    on<DeleteMedicine>((event, emit) async {
      emit(DeleteMedicineLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.deleteMedicine(
            medicineId: event.medicineId);
        emit(DeleteMedicineLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        print(">>>>>>>>>>>>>>>>" + e.toString());
        emit(DeleteMedicineError());
      }
      // TODO: implement event handler
    });
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'add_all_appointment_details_event.dart';

part 'add_all_appointment_details_state.dart';

class AddAllAppointmentDetailsBloc
    extends Bloc<AddAllAppointmentDetailsEvent, AddAllAppointmentDetailsState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  AddAllAppointmentDetailsBloc() : super(AddAllAppointmentDetailsInitial()) {
    on<AddAllAppointmentDetails>((event, emit) async {
      emit(AddAllAppointmentDetailsLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.addAllAppointmentDetails(
            tokenId: event.tokenId,
            labId: event.labId,
            labTest: event.labTest,
            medicalshopId: event.medicalshopId,
            event.attachment,
            reviewAfter: event.reviewAfter,
            notes: event.notes,
            scanId: event.scanId,
            scanTest: event.scanTest);
        emit(AddAllAppointmentDetailsLoaded());
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data["message"]);
      } catch (e) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(AddAllAppointmentDetailsError());
      }
    });
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

import '../../../Api/GetAppointment/get_all_appointment_api.dart';

part 'add_all_appointment_details_event.dart';
part 'add_all_appointment_details_state.dart';

class AddAllAppointmentDetailsBloc
    extends Bloc<AddAllAppointmentDetailsEvent, AddAllAppointmentDetailsState> {
 
 final SaveaAllApontmentDetailsServicce saveAllAppointmentDetailsService = SaveaAllApontmentDetailsServicce();
 AddAllAppointmentDetailsBloc() : super(AddAllAppointmentDetailsInitial()) {
    on<AddAllAppointmentDetails>((event, emit) async {
      emit(AddAllAppointmentDetailsLoading());
      try {
     var    response = await saveAllAppointmentDetailsService.addAllApontmentDetailsList(
          tokenId:event. tokenId,
          labId: event.labId,
           labTest: event.labTest, 
           medicalshopId:event. medicalshopId,
            reviewAfter: event.reviewAfter,
             notes:event. notes,
              scanId: event.scanId,
               scanTest:event. scanTest,
               attachment: event.attachment,
               );
        if (response != null) {
          emit(AddAllAppointmentDetailsLoaded());
          GeneralServices.instance.showToastMessage(response["message"]);
        } else {
          emit(AddAllAppointmentDetailsError());
        }
      } catch (e) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(AddAllAppointmentDetailsError());
      }
    });
  }
}

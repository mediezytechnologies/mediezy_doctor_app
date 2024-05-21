import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/Previous_appointment_details_model.dart';
import 'package:mediezy_doctor/Repositary/Api/previous_appointments/previous_appointments_api.dart';
import 'package:meta/meta.dart';

part 'previous_details_event.dart';
part 'previous_details_state.dart';

class PreviousDetailsBloc
    extends Bloc<PreviousDetailsEvent, PreviousDetailsState> {
  PreviousAppointmentsApi previousAppointmentsApi = PreviousAppointmentsApi();
  PreviousDetailsBloc() : super(PreviousDetailsInitial()) {
    on<FetchAllPreviousAppointmentDetails>((event, emit) async {
      emit(PreviousDetailsLoading());
      try {
        final previousAppointmentDetailsModel =
            await previousAppointmentsApi.getAllPreviousAppointmentDetails(
                patientId: event.patientId, appointmentId: event.appointmentId);
        emit(PreviousDetailsLoaded(
            previousAppointmentDetailsModel: previousAppointmentDetailsModel));
      } catch (error) {
        log("<<<<<<<<<<Error Previous appointemt details>>>>>>>>>>$error");
        emit(PreviousDetailsError());
      }
    });
  }
}

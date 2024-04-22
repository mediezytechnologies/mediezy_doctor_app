import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_all_previous_appointments_event.dart';

part 'get_all_previous_appointments_state.dart';

class GetAllPreviousAppointmentsBloc extends Bloc<
    GetAllPreviousAppointmentsEvent, GetAllPreviousAppointmentsState> {
  late PreviousAppointmentsModel previousAppointmentsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  GetAllPreviousAppointmentsBloc()
      : super(GetAllPreviousAppointmentsInitial()) {
    on<FetchAllPreviousAppointments>((event, emit) async {
      emit(GetAllPreviousAppointmentsLoading());
      try {
        previousAppointmentsModel =
            await getAppointmentApi.getAllPreviousAppointments(
                date: event.date, clinicId: event.clinicId);
        emit(GetAllPreviousAppointmentsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error Previous Appointemts>>>>>>>>>>" +
            error.toString());
        emit(GetAllPreviousAppointmentsError());
      }
    });
  }
}

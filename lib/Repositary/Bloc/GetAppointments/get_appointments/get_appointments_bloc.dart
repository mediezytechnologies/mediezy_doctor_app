import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_appointments_event.dart';
part 'get_appointments_state.dart';

class GetAppointmentsBloc
    extends Bloc<GetAppointmentsEvent, GetAppointmentsState> {
  late GetAppointmentsModel getAppointmentsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  bool isLoaded = false;
  GetAppointmentsBloc() : super(GetAppointmentsInitial()) {
    on<FetchAllAppointments>((event, emit) async {
      // emit(GetAllAppointmentsLoading());
      try {
        getAppointmentsModel = await getAppointmentApi.getAllApointments(
            date: event.date,
            clinicId: event.clinicId,
            scheduleType: event.scheduleType);
        isLoaded = true;
        emit(GetAppointmentsLoaded(isLoaded: isLoaded));
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetAppointmentsError());
      }
    });
  }
}

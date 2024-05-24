import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/appointment_demo_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'appointments_demo_bloc_event.dart';
part 'appointments_demo_bloc_state.dart';

class AppointmentsDemoBlocBloc
    extends Bloc<AppointmentsDemoBlocEvent, AppointmentsDemoBlocState> {
  late AppointmentDemoModel appointmentDemoModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  bool isLoaded = false;
  AppointmentsDemoBlocBloc() : super(AppointmentsDemoBlocInitial()) {
    on<FetchAllAppointmentsDemo>((event, emit) async {
      // emit(GetAllAppointmentsLoading());
      try {
        appointmentDemoModel = await getAppointmentApi.getAllApointmentsDemo(
            date: event.date,
            clinicId: event.clinicId,
            scheduleType: event.scheduleType);
        isLoaded = true;
        emit(AppointmentsDemoBlocLoaded(isLoaded: isLoaded));
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(AppointmentsDemoBlocError());
      }
    });
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointments_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'ge_all_completed_appointments_event.dart';

part 'ge_all_completed_appointments_state.dart';

class GetAllCompletedAppointmentsBloc extends Bloc<
    GetAllCompletedAppointmentsEvent, GeAllCompletedAppointmentsState> {
  late GetAllAppointmentsModel getAllAppointmentsModel;
  late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  late GetAllCompletedAppointmentDetailsModel
      getAllCompletedAppointmentDetailsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();

  GetAllCompletedAppointmentsBloc()
      : super(GeAllCompletedAppointmentsInitial()) {
    on<FetchAllCompletedAppointments>((event, emit) async {
      emit(GetAllCompletedAppointmentsLoading());
      try {
        getAllCompletedAppointmentsModel =
            await getAppointmentApi.getAllCompletedApointmentsAsPerDate(
                date: event.date,
                clinicId: event.clinicId,
                scheduleType: event.scheduleType);
        emit(GetAllCompletedAppointmentsLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetAllCompletedAppointmentsError());
      }
    });

//get completed appointment details screen bloc

    on<FetchAllCompletedAppointmentDetails>((event, emit) async {
      emit(GetAllCompletedAppointmentDetailsLoading());
      try {
        getAllCompletedAppointmentDetailsModel = await getAppointmentApi
            .getAllCompletedAppointmentDetails(tokenId: event.tokenId);
        emit(GetAllCompletedAppointmentDetailsLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetAllCompletedAppointmentDetailsError());
      }
    });
  }
}

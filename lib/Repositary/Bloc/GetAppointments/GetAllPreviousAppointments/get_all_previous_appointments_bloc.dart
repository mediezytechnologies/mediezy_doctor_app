import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/Previous_appointment_details_model.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/previous_appointments/previous_appointments_api.dart';
import 'package:meta/meta.dart';

part 'get_all_previous_appointments_event.dart';

part 'get_all_previous_appointments_state.dart';

class GetAllPreviousAppointmentsBloc extends Bloc<
    GetAllPreviousAppointmentsEvent, GetAllPreviousAppointmentsState> {
  late PreviousAppointmentsModel previousAppointmentsModel;
  PreviousAppointmentsApi previousAppointmentsApi = PreviousAppointmentsApi();

  GetAllPreviousAppointmentsBloc()
      : super(GetAllPreviousAppointmentsInitial()) {
    on<FetchAllPreviousAppointments>((event, emit) async {
      emit(GetAllPreviousAppointmentsLoading());
      try {
        previousAppointmentsModel =
            await previousAppointmentsApi.getAllPreviousAppointments(
                date: event.date, clinicId: event.clinicId);
        emit(GetAllPreviousAppointmentsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error Previous Appointemts>>>>>>>>>>$error");
        emit(GetAllPreviousAppointmentsError());
      }
    });

    //previous appointment details
    //
    // on<FetchAllPreviousAppointmentDetails>((event, emit) async {
    //   emit(PreviousAppointmentDetailsLoading());
    //   try {
    //     final previousAppointmentDetailsModel =
    //         // await previousAppointmentsApi.getAllPreviousAppointmentDetails(
    //             patientId: event.patientId, appointmentId: event.appointmentId);
    //     emit(PreviousAppointmentDetailsLoaded(
    //         previousAppointmentDetailsModel: previousAppointmentDetailsModel));
    //   } catch (error) {
    //     print("<<<<<<<<<<Error Previous appointemt details>>>>>>>>>>$error");
    //     emit(PreviousAppointmentDetailsError());
    //   }
    // });
  }
}

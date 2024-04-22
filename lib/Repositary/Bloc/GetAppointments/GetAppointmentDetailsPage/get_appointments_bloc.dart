import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_appointments_event.dart';
part 'get_appointments_state.dart';

class GetAppointmentsBloc extends Bloc<GetAppointmentsEvent, GetAppointmentsState> {
  late AppointmentDetailsPageModel appointmentDetailsPageModel;
  GetAppointmentApi getAppointmentApi=GetAppointmentApi();
  GetAppointmentsBloc() : super(GetAppointmentsInitial()) {
    on<FetchAppointmentDetailsPage>((event, emit)async {
      emit(GetAppointmentsLoading());
      try{
        appointmentDetailsPageModel = await getAppointmentApi.getAppointmentDetailsPage(tokenId: event.tokenId);
        emit(GetAppointmentsLoaded());
      }catch(e){
        print("Error>>>>>>>>>>>>>>>>>>>"+e.toString());
        emit(GetAppointmentsError());
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_all_appointments_event.dart';

part 'get_all_appointments_state.dart';

class GetAllAppointmentsBloc
    extends Bloc<GetAllAppointmentsEvent, GetAllAppointmentsState> {
  late GetAllAppointmentsModel getAllAppointmentsModel;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  bool isLoaded = false;

  GetAllAppointmentsBloc() : super(GetAllAppointmentsInitial()) {
    on<FetchAllAppointments>((event, emit) async {
      emit(GetAllAppointmentsLoading());
      try {
        getAllAppointmentsModel =
            await getAppointmentApi.getAllApointmentsAsPerDate(
                date: event.date,
                clinicId: event.clinicId,
                scheduleType: event.scheduleType);
        isLoaded = true;
        emit(GetAllAppointmentsLoaded(isLoaded: isLoaded));
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetAllAppointmentsError());
      }
    });
  }
}

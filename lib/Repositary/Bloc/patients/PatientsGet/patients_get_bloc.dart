import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/patients_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/patient_screen_api.dart';
import 'package:meta/meta.dart';

part 'patients_get_event.dart';

part 'patients_get_state.dart';

class PatientsGetBloc extends Bloc<PatientsGetEvent, PatientsGetState> {
  late PatientsGetModel patientsGetModel;
  PatientScreenApi patientScreenApi = PatientScreenApi();

  PatientsGetBloc() : super(PatientsGetInitial()) {
    on<FetchPatients>((event, emit) async {
      emit(PatientsGetLoading());
      try {
        patientsGetModel =
            await patientScreenApi.getPatients(clinicId: event.clinicId);
        emit(PatientsGetLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(PatientsGetError());
      }
    });

    //Sort patients

    on<FetchSortPatients>((event, emit) async {
      emit(PatientsGetLoading());
      try {
        patientsGetModel = await patientScreenApi.getSortingPatients(
            sort: event.sort,
            clinicId: event.clinicId,
            fromDate: event.fromDate,
            toDate: event.toDate);
        emit(PatientsGetLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(PatientsGetError());
      }
    });
  }
}

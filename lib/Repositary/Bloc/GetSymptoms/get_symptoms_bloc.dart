import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_doctor/Repositary/Api/BookAppointment/book_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_symptoms_event.dart';
part 'get_symptoms_state.dart';

class GetSymptomsBloc extends Bloc<GetSymptomsEvent, GetSymptomsState> {
  late GetSymptomsModel getSymptomsModel;
  BookAppointmentApi bookAppointmentApi = BookAppointmentApi();
  GetSymptomsBloc() : super(GetSymptomsInitial()) {
    on<FetchSymptoms>((event, emit) async {
      emit(GetSymptomsLoading());
      try {
        getSymptomsModel = await bookAppointmentApi.getSymptoms();
        emit(GetSymptomsLoaded());
      } catch (e) {
        log("Error>>>>>>>>>>>>>><<<<<<<<<<<<<<>>>>>>>>>>>$e");
        emit(GetSymptomsError());
      }
    });
  }
}

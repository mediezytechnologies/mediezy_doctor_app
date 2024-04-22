import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/suggest_doctor_api/suggest_doctor_api.dart';
import 'package:meta/meta.dart';

part 'suggest_doctor_event.dart';

part 'suggest_doctor_state.dart';

class SuggestDoctorBloc extends Bloc<SuggestDoctorEvent, SuggestDoctorState> {
  late String updatedSuccessfully;
  SuggestDoctorApi suggestDoctorApi = SuggestDoctorApi();

  SuggestDoctorBloc() : super(SuggestDoctorInitial()) {
    on<AddSuggestDoctorEvent>((event, emit) async {
      emit(SuggestDoctorLoading());
      try {
        updatedSuccessfully = await suggestDoctorApi.doctorRecommend(
            doctorName: event.doctorName,
            location: event.location,
            clinicName: event.clinicName,
            specialization: event.specialization,
            phoneNumber: event.phoneNumber);
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(SuggestDoctorLoaded(successMessage: data['message'].toString()));
      } catch (e) {
        print("<<<<< SUGGESTION ERROR : $e >>>>>");
        emit(SuggestDoctorError(errorMessage: e.toString()));
      }
    });
  }
}

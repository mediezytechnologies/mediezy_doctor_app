import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/BookAppointment/book_appointment_api.dart';
import 'package:mediezy_doctor/Repositary/Bloc/DeleteTokens/delete_tokens_bloc.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

part 'book_appointment_event.dart';

part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  late String uploadSuccessfully;
  BookAppointmentApi bookAppointmentApi = BookAppointmentApi();

  BookAppointmentBloc() : super(BookAppointmentInitial()) {
    on<PassBookAppointMentEvent>((event, emit) async {
      emit(BookAppointmentLoading());
      try {
        uploadSuccessfully = await bookAppointmentApi.bookAppointment(
          patientName: event.patientName,
          date: event.date,
          regularmedicine: event.regularmedicine,
          whenitcomes: event.whenitcomes,
          whenitstart: event.whenitstart,
          tokenTime: event.tokenTime,
          tokenNumber: event.tokenNumber,
          gender: event.gender,
          age: event.age,
          mobileNo: event.mobileNo,
          appoinmentfor1: event.appoinmentfor1,
          appoinmentfor2: event.appoinmentfor2,
          clinicId: event.clinicId,
          scheduleType: event.scheduleType,
          // endTokenTime: event.endTokenTime
        );
        emit(BookAppointmentLoaded());
        Map<String, dynamic> data = jsonDecode(uploadSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
      } catch (e) {
        log("Error>>>>>>>>>>>>>><<<<<<<<<<<<<<>>>>>>>>>>>$e");
        emit(BookAppointmentError(errorMessage: '$e'));
      }
    });
  }
}

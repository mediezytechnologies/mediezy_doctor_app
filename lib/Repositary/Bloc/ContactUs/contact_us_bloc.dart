import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/ContactUs/contact_us_api.dart';
import 'package:meta/meta.dart';

part 'contact_us_event.dart';

part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  late String uploadedSuccessfully;
  ContactUsApi contactUsApi = ContactUsApi();

  ContactUsBloc() : super(ContactUsInitial()) {
    on<AddContactUs>((event, emit) async {
      emit(ContactUsLoading());
      try {
        uploadedSuccessfully = await contactUsApi.addContactUs(
            email: event.email, description: event.description);
        Map<String, dynamic> data = jsonDecode(uploadedSuccessfully);
        emit(ContactUsLoaded(successMessage: data['message'].toString()));
      } catch (e) {
        emit(ContactUsError(errorMessage: e.toString()));
      }
    });
  }
}

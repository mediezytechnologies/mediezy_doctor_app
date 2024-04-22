import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_clinic_event.dart';
part 'selected_clinic_state.dart';

class SelectedClinicBloc extends Bloc<SelectedClinicEvent, SelectedClinicState> {
  // GetClinicModel getClinicModel;
  SelectedClinicBloc() : super(SelectedClinicInitial(changValue:'All')) {
    on<SelectedClinicEvent>((event, emit) {
      if (event is selectedDropDownClinic) {
        print(event.dropdownSelectedValue);
        emit(SelectedClinicInitial(changValue: event.dropdownSelectedValue));
      }
      // TODO: implement event handler
    });
  }
}

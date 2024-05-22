import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropDownInitial(changValue: 'All')) {
    on<DropdownEvent>((event, emit) {
      if (event is DropdownSelectEvent) {
        log(event.dropdownSelectnvLalu);
        emit(DropDownInitial(changValue: event.dropdownSelectnvLalu));
      }
    });
  }
}

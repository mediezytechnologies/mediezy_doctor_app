import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropDownInitial(changValue: 'All')) {
    on<DropdownEvent>((event, emit) {
      if (event is DropdownSelectEvent) {
        print(event.dropdownSelectnvLalu);
        emit(DropDownInitial(changValue: event.dropdownSelectnvLalu));
      }
    });
  }
}

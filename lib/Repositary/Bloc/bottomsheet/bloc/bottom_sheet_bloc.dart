import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/bottomsheet/bottomsheet_model.dart';
import 'package:mediezy_doctor/Repositary/Api/bottomsheet/bottmsheet_api.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetApi bottomSheetApi = BottomSheetApi();
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<FetchBottomSheet>((event, emit) async {
      emit(BottomSheetLoading());
      try {
        final bottomSheetModel = await bottomSheetApi.addBottomSheet();
        emit(BottomSheetLoaded(bottomSheetModel: bottomSheetModel));
      } catch (e) {
        emit(BottomSheetError());
      }
    });
  }
}

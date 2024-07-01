import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_leaves_model.dart';
import 'package:mediezy_doctor/Repositary/Api/LeaveUpdate/leave_update_api.dart';
import 'package:meta/meta.dart';

part 'get_all_leaves_event.dart';
part 'get_all_leaves_state.dart';

class GetAllLeavesBloc extends Bloc<GetAllLeavesEvent, GetAllLeavesState> {
  late GetAllLeavesModel getAllLeavesModel;
  LeaveUpdateApi leaveUpdateApi = LeaveUpdateApi();
  GetAllLeavesBloc() : super(GetAllLeavesInitial()) {
    on<FetchAllLeaves>((event, emit) async {
    emit(GetAllLeavesLoading( ));
      try {
        getAllLeavesModel = await leaveUpdateApi.getAllLeaves(
          hospitalId: event.hospitalId,
        );
        emit(GetAllLeavesLoaded(getAllLeavesModel:getAllLeavesModel ));
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(GetAllLeavesError());
      }
    });
  }
}

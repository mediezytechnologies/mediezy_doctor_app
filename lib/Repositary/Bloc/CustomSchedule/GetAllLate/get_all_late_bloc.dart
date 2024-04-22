import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_break_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_early_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_late_model.dart';
import 'package:mediezy_doctor/Repositary/Api/CustomSchedule/custom_schedule_api.dart';
import 'package:meta/meta.dart';

part 'get_all_late_event.dart';

part 'get_all_late_state.dart';

class GetAllLateBloc extends Bloc<GetAllLateEvent, GetAllLateState> {
  late GetAllLateModel getAllLateModel;
  late GetAllEarlyModel getAllEarlyModel;
  late GetAllBreakModel getAllBreakModel;
  late String updatedSuccessfully;
  CustomScheduleApi customScheduleApi = CustomScheduleApi();

  GetAllLateBloc() : super(GetAllLateInitial()) {
    //get all late

    on<FetchAllLate>((event, emit) async {
      emit(GetAllLateLoading());
      try {
        getAllLateModel =
            await customScheduleApi.getAllLate(clinicId: event.clinicId);
        emit(GetAllLateLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(GetAllLateError());
      }
      // TODO: implement event handler
    });

    // get all early section
    on<FetchAllEarly>((event, emit) async {
      emit(GetAllEarlyLoading());
      try {
        getAllEarlyModel =
            await customScheduleApi.getAllEarly(clinicId: event.clinicId);
        emit(GetAllEarlyLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(GetAllEarlyError());
      }
    });

    // get all break section
    on<FetchAllBreak>((event, emit) async {
      emit(GetAllBreakLoading());
      try {
        getAllBreakModel =
            await customScheduleApi.getAllBreak(clinicId: event.clinicId);
        emit(GetAllBreakLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(GetAllBreakError());
      }
    });

    // delete late section
    on<DeleteLate>((event, emit) async {
      emit(DeleteLateLoading());
      try {
        updatedSuccessfully = await customScheduleApi.deleteLate(
            scheduleId: event.scheduleId);
        emit(DeleteLateLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(DeleteLateError());
      }
    });

    // delete early section
    on<DeleteEarly>((event, emit) async {
      emit(DeleteEarlyLoading());
      try {
        updatedSuccessfully = await customScheduleApi.deleteEarly(
            scheduleId: event.scheduleId);
        emit(DeleteEarlyLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(DeleteEarlyError());
      }
    });

    // delete break section
    on<DeleteBreak>((event, emit) async {
      emit(DeleteBreakLoading());
      try {
        updatedSuccessfully = await customScheduleApi.deleteBreak(
            reScheduleId: event.reScheduleId,);
        emit(DeleteBreakLoaded());
      } catch (e) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(DeleteBreakError());
      }
    });
  }
}

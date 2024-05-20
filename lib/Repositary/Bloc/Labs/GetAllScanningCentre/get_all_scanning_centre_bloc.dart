import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_labs_model.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:meta/meta.dart';

part 'get_all_scanning_centre_event.dart';
part 'get_all_scanning_centre_state.dart';

class GetAllScanningCentreBloc
    extends Bloc<GetAllScanningCentreEvent, GetAllScanningCentreState> {
  late GetAllLabsModel getAllLabsModel;
  LabsApi labsApi = LabsApi();
  GetAllScanningCentreBloc() : super(GetAllScanningCentreInitial()) {
    on<FetchGetAllScanningCentre>((event, emit) async {
      emit(GetAllScanningCentreLoading());
      try {
        getAllLabsModel = await labsApi.getAllScanning();
        emit(GetAllScanningCentreLoaded());
      } catch (error) {
        log("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetAllScanningCentreError());
      }
    });
  }
}

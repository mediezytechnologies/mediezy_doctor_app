import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:meta/meta.dart';

part 'favourite_lab_test_event.dart';
part 'favourite_lab_test_state.dart';

class FavouriteLabTestBloc
    extends Bloc<FavouriteLabTestEvent, FavouriteLabTestState> {
  late String updatedSuccessfully;
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  FavouriteLabTestBloc() : super(FavouriteLabTestInitial()) {
    on<AddFavouriteLabTest>((event, emit) async {
      emit(FavouriteLabTestLoading());
      try {
        updatedSuccessfully = await getAppointmentApi.updateFavouriteLabTest(
            labTestId: event.labTestId);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
        emit(
            FavouriteLabTestLoaded(successMessage: data['message'].toString()));
      } catch (e) {
        emit(FavouriteLabTestError(errorMessage: e.toString()));
      }
    });

    //! delete recently search lab test

    on<DeleteRecentlySearchLabTest>((event, emit) async {
      emit(DeleteRecentlySearchLabTestLoading());
      try {
        updatedSuccessfully = await getAppointmentApi
            .deleteRecentlySearchLabTest(labtestId: event.labTestId);

        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        GeneralServices.instance.showToastMessage(data['message']);
        emit(DeleteRecentlySearchLabTestLoaded(
            successMessage: data['message'].toString()));
      } catch (e) {
        emit(DeleteRecentlySearchLabTestError(errorMessage: e.toString()));
      }
    });
  }
}

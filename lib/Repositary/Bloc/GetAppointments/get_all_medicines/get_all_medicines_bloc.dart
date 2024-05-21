import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_medicines_model.dart';
import 'package:mediezy_doctor/Repositary/Api/GetAppointment/get_appointment_api.dart';
import 'package:meta/meta.dart';

part 'get_all_medicines_event.dart';

part 'get_all_medicines_state.dart';

class GetAllMedicinesBloc
    extends Bloc<GetAllMedicinesEvent, GetAllMedicinesState> {
  GetAppointmentApi getAppointmentApi = GetAppointmentApi();
  GetAllMedicinesBloc() : super(GetAllMedicinesInitial()) {
    on<FetchMedicines>((event, emit) async {
      emit(GetAllMedicinesLoading());
      try {
        final getAllMedicinesModel = await getAppointmentApi.getAllMedicines(
            searchQuery: event.searchQuery);
        emit(GetAllMedicinesLoaded(getAllMedicinesModel: getAllMedicinesModel));
      } catch (e) {
        emit(GetAllMedicinesError());
      }
    });
  }
}

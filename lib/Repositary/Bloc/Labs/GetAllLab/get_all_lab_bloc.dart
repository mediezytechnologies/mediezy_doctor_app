import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_labs_model.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:meta/meta.dart';

part 'get_all_lab_event.dart';
part 'get_all_lab_state.dart';

class GetAllLabBloc extends Bloc<GetAllLabEvent, GetAllLabState> {
  late GetAllLabsModel getAllLabsModel;
  LabsApi labsApi = LabsApi();
  GetAllLabBloc() : super(GetAllLabInitial()) {
    on<FetchGetAllLabs>((event, emit) async {
      emit(GetAllLabLoading());
      try {
        getAllLabsModel = await labsApi.getAllLabs();
        emit(GetAllLabLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(GetAllLabError());
      }
    });
  }
}

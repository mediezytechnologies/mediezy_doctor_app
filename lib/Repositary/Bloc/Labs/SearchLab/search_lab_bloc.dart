import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/Labs/search_lab_model.dart';
import 'package:mediezy_doctor/Repositary/Api/Labs/labs_api.dart';
import 'package:meta/meta.dart';

part 'search_lab_event.dart';

part 'search_lab_state.dart';

class SearchLabBloc extends Bloc<SearchLabEvent, SearchLabState> {
  late SearchLabModel searchLabModel;
  LabsApi labsApi = LabsApi();

  SearchLabBloc() : super(SearchLabInitial()) {
    on<FetchSearchLab>((event, emit) async {
      emit(SearchLabLoading());
      try {
        searchLabModel = await labsApi.getSearchLabs(labName: event.labName);
        emit(SearchLabLoaded());
      } catch (e) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + e.toString());
        emit(SearchLabError());
      }
      // TODO: implement event handler
    });
  }
}

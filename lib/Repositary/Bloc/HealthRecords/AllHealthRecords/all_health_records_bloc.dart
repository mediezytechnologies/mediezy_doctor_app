import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/HealthRecords/health_records_model.dart';
import 'package:mediezy_doctor/Repositary/Api/HealthRecords/health_records_api.dart';
import 'package:meta/meta.dart';

part 'all_health_records_event.dart';
part 'all_health_records_state.dart';

class AllHealthRecordsBloc
    extends Bloc<AllHealthRecordsEvent, AllHealthRecordsState> {
  late HealthRecordsModel healthRecordsModel;
  HealthRecordsApi healthRecordsApi = HealthRecordsApi();
  AllHealthRecordsBloc() : super(AllHealthRecordsInitial()) {
    on<FetchAllHealthRecords>((event, emit) async {
      emit(AllHealthRecordsLoading());
      try {
        healthRecordsModel = await healthRecordsApi.getAllHealthRecords(
            patientId: event.patientId, userId: event.userId);
        emit(AllHealthRecordsLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>" + error.toString());
        emit(AllHealthRecordsError());
      }
    });
  }
}

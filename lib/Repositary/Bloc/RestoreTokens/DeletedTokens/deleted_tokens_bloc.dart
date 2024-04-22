
import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/get_delete_tokens_model.dart';
import 'package:mediezy_doctor/Repositary/Api/RestoreTokensApi/restore_tokens_api.dart';
import 'package:meta/meta.dart';

part 'deleted_tokens_event.dart';
part 'deleted_tokens_state.dart';

class DeletedTokensBloc extends Bloc<DeletedTokensEvent, DeletedTokensState> {
  late GetDeleteTokensModel getDeleteTokensModel;
  RestoreTokensApi restoreTokensApi = RestoreTokensApi();
  DeletedTokensBloc() : super(DeletedTokensInitial()) {
    on<FetchDeletedTokens>((event, emit) async {
      emit(DeletedTokensLoading());
      try {
        getDeleteTokensModel = await restoreTokensApi.getDeletedTokens(
            clinicId: event.clinicId,
            // date: event.date
        );
        emit(DeletedTokensLoaded());
      } catch (e) {
        emit(DeletedTokensError());
      }
    });
  }
}

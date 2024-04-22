import 'package:bloc/bloc.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_all_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Api/MedicalShoppe/medical_shoppe_api.dart';
import 'package:meta/meta.dart';

part 'get_all_medical_shoppe_event.dart';
part 'get_all_medical_shoppe_state.dart';

class GetAllMedicalShoppeBloc
    extends Bloc<GetAllMedicalShoppeEvent, GetAllMedicalShoppeState> {
  late GetAllMedicalShopeModel getAllMedicalShopeModel;
  MedicalShoppeApi medicalShoppeApi = MedicalShoppeApi();
  GetAllMedicalShoppeBloc() : super(GetAllMedicalShoppeInitial()) {
    on<FetchAllMedicalShoppe>((event, emit) async {
      emit(GetAllMedicalShoppeLoading());
      try {
        getAllMedicalShopeModel = await medicalShoppeApi.getAllMedicalShoppes();
        emit(GetAllMedicalShoppeLoaded());
      } catch (error) {
        print("<<<<<<<<<<Error>>>>>>>>>>$error");
        emit(GetAllMedicalShoppeError());
      }
    });
  }
}

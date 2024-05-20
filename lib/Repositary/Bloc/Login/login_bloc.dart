import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Model/auth/login_model.dart';
import 'package:mediezy_doctor/Model/auth/sign_up_model.dart.dart';
import 'package:mediezy_doctor/Repositary/Api/Login/login_api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LoginModel loginModel;
  late SignupModel signupModel;
  late String updatedSuccessfully;
  LoginApi loginApi = LoginApi();

  LoginBloc() : super(LoginInitial()) {
    on<FetchLogin>((event, emit) async {
      final preference = await SharedPreferences.getInstance();
      emit(LoginLoading());
      log("loading");
      try {
        loginModel = await loginApi.getLogin(
            email: event.email, password: event.password);
        preference.setString('token', loginModel.token.toString());
        preference.setString(
            'doctorFirstName', loginModel.doctor!.firstname.toString());
        preference.setString(
            'doctorLastName', loginModel.doctor!.secondname.toString());
        preference.setString('DoctorId', loginModel.doctor!.id.toString());
        preference.setInt('DoctorId2', loginModel.doctor!.id!);
        String? token = preference.getString('token');
        log("Tokken >>>>>>>>>>>>>>>>>>$token");
        emit(LoginLoaded());
        log("loaded");
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LoginError());
      }
    });

    //signup
    on<FetchSignup>((event, emit) async {
      emit(LoginLoading());
      log("loading");
      try {
        signupModel = await loginApi.getSignup(
            email: event.email,
            password: event.password,
            firstname: event.firstname,
            secondname: event.secondname,
            mobileNo: event.mobileNo);

        emit(LoginLoaded());
        log("loaded");
      } catch (e) {
        log("Error>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(LoginError());
      }
    });

    // signup
    on<DummyRegister>((event, emit) async {
      emit(DummyRegisterLoading());
      try {
        updatedSuccessfully = await loginApi.addDummyRegister(
          email: event.email,
          firstname: event.firstname,
          dob: event.dob,
          mobileNo: event.mobileNo,
          location: event.location,
          hospitalName: event.hospitalName,
          specialization: event.specialization,
          // doctorImage: event.doctorImage
        );
        Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
        emit(DummyRegisterLoaded(successMessage: data['message'].toString()));
        log("loaded");
      } catch (e) {
        final String error = "$e";
        log("Error>>>>>>>>>>>>>>>>>>>>>>$e");
        emit(DummyRegisterError(errorMessage: error));
      }
    });

    // on<GuestRegister>((event, emit) async {
    //   emit(DummyRegisterLoading());
    //   try {
    //     updatedSuccessfully = await loginApi.addGuestRegister(
    //       email: event.email,
    //       name: event.name,
    //       mobileNo: event.mobileNo,
    //     );
    //     Map<String, dynamic> data = jsonDecode(updatedSuccessfully);
    //     emit(DummyRegisterLoaded(successMessage: data['message'].toString()));
    //     log("loaded");
    //   } catch (e) {
    //     final String error = "$e";
    //     print("Error>>>>>>>>>>>>" + e.toString());
    //     emit(DummyRegisterError(errorMessage: error));
    //   }
    // });
  }
}

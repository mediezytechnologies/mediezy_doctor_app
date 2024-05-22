import 'dart:developer';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkuserlogin() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final HospitalController controller = Get.put(HospitalController());

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (token == null) {
          Navigator.of(context).pushAndRemoveUntil(
              // MaterialPageRoute(builder: (context) => const LoginDemoScreen()),
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationControlWidget()),
              (route) => false);
          BlocProvider.of<GetAllAppointmentsBloc>(context)
              .add(FetchAllAppointments(
            date: controller.formatDate(),
            clinicId: controller.initialIndex!,
            scheduleType: controller.scheduleIndex.value,
          ));
          BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
              .add(FetchAllCompletedAppointments(
            date: controller.formatDate(),
            clinicId: controller.initialIndex!,
            scheduleType: controller.scheduleIndex.value,
          ));
          log("msg working ===== splash ");
        }
      },
    );
  }

  @override
  void initState() {
    checkuserlogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/icons/doctor screen-02.jpg",
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'dart:developer';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Repositary/getx/get_appointment_getx.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getAllAppointmentController = Get.put(GetAllAppointmentController());
  Future<void> checkuserlogin() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final HospitalController controller = Get.put(HospitalController());

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (token == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => BottomNavigationControlWidget(
                        selectedIndex: 0,
                      )),
              (route) => false);
          getAllAppointmentController.getAllAppointmentGetxController(
            date: controller.formatDate(),
            clinicId: controller.initialIndex.value,
            scheduleType: controller.scheduleIndex.value,
          );
          BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
              .add(FetchAllCompletedAppointments(
            date: controller.formatDate(),
            clinicId: controller.initialIndex.value,
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                height: size.height,
                width: size.width,
                "assets/images/doctor screen-03.jpg",
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

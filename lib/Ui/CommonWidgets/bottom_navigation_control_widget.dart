import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/appointments_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/GetTokensScreen/get_tokens_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/patient_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/shedule_token_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/TokenScreen/token_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/d.dart';

// ignore: must_be_immutable
class BottomNavigationControlWidget extends StatefulWidget {
  const BottomNavigationControlWidget({super.key});

  @override
  State<BottomNavigationControlWidget> createState() =>
      _BottomNavigationControlWidgetState();
}

class _BottomNavigationControlWidgetState
    extends State<BottomNavigationControlWidget> {
  int selectedIndex = 0;
  late ClinicGetModel clinicGetModel;

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
  }

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  void selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const AppointmentsScreen(),
      const TokenScreen(),
      const GetTokensScreen(),
      const SheduleTokenScreen(),
      const PatientScreen(),
      //  D(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectScreen,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kMainColor,
        selectedLabelStyle: TextStyle(
            color: kCardColor, fontSize: 10.sp, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
            color: kCardColor, fontSize: 8.sp, fontWeight: FontWeight.w500),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 0
                      ? IconlyBold.calendar
                      : IconlyLight.calendar,
                  color: kMainColor),
              label: "Appointments"),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 1 ? IconlyBold.ticket : IconlyLight.ticket,
                  color: kMainColor),
              label: "Token"),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? IconlyBold.paper : IconlyLight.paper,
                  color: kMainColor),
              label: "Booking"),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3
                      ? IconlyBold.timeSquare
                      : IconlyLight.timeSquare,
                  color: kMainColor),
              label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 4 ? IconlyBold.profile : IconlyLight.profile,
                  color: kMainColor),
              label: "Patients"),
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;
          if (connectivityResult == ConnectivityResult.none) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/No internet.jpg"),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "Please check your internet connection",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return screens[selectedIndex];
          }
        },
      ),
    );
  }
}

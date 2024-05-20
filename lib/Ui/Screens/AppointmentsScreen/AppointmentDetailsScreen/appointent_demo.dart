// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class AppointmentDemo extends StatefulWidget {
  const AppointmentDemo({
    super.key,
  });

  @override
  State<AppointmentDemo> createState() => _AppointmentDemoState();
}

class _AppointmentDemoState extends State<AppointmentDemo> {
  final PageController controller = PageController();
  final TextEditingController noteController = TextEditingController();

  final TextEditingController afterDaysController = TextEditingController();
  final TextEditingController labTestController = TextEditingController();
  final TextEditingController scanTestController = TextEditingController();
  List<TextEditingController> textFormControllers = [];
  List<Widget> textFormFields = [];

  ////lab

  late ValueNotifier<String> dropValueLabNotifier;
  String dropValueLab = "";
  late List<FavoriteLabs> labId;
  List<FavoriteLabs> labValues = [FavoriteLabs(laboratory: "Select lab")];

  // scanning

  late ValueNotifier<String> dropValueScanningNotifier;
  String dropValueScanning = "";
  late List<FavoriteLabs> scanningId;
  List<FavoriteLabs> scanningValues = [
    FavoriteLabs(laboratory: "Select scanning centre")
  ];

  late AppointmentDetailsPageModel appointmentDetailsPageModel;
  late GetAllFavouriteLabModel getAllFavouriteLabModel;
  late GetAllFavouriteMedicalStoresModel getAllFavouriteMedicalStoresModel;
  late ClinicGetModel clinicGetModel;
  File? imageFromCamera;
  int currentPosition = 0;

  int? count = 0;

  int? length;
  String? selectedValue;

  int clickedIndex = 0;
  int? currentTokenLength = 1;
  int currentIndex = 0;

  void handleDropValueChanged(String newValue) {
    // Handle the value here in your first screen

    setState(() {
      selectedValue = newValue;
    });
    print("Received value: $newValue");
    // print("::::::::::::::::::$selectedValue");
  }

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kCardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 180.h,
              width: 300.w,
              child: Image.asset(
                "assets/images/no connection.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
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
  }
}

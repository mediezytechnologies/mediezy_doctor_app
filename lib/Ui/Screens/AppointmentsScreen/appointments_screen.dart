// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unnecessary_null_comparison
import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Repositary/getx/get_appointment_getx.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_demo.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_appbar.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_dropdown.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_tabbar_demo.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'Widgets/appoiment_drawer.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final HospitalController controller = Get.put(HospitalController());

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  final getAllAppointmentController = Get.put(GetAllAppointmentController());

  late StreamSubscription<ConnectivityResult> subscription;
  late Timer pollingTimer;
  late Timer initialTimer;

  @override
  void initState() {
    super.initState();

    getAllAppointmentController.getAllAppointmentGetxController(
      date: controller.formatDate(),
      clinicId: controller.initialIndex.value,
      scheduleType: controller.scheduleIndex.value,
    );
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });

    if (controller.initialIndex != null &&
        controller.scheduleIndex.value != null) {
      getAllAppointmentController.getAllAppointmentGetxController(
        date: controller.formatDate(),
        clinicId: controller.initialIndex.value,
        scheduleType: controller.scheduleIndex.value,
      );

      initialTimer = Timer(const Duration(seconds: 1), () {
        fetchAppointments();

        pollingTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
          fetchAppointments();
        });
      });
    }
  }

  void fetchAppointments() {
    getAllAppointmentController.getAllAppointmentGetxController(
      date: controller.formatDate(),
      clinicId: controller.initialIndex.value,
      scheduleType: controller.scheduleIndex.value,
    );
  }

  void stopPolling() {
    pollingTimer.cancel();
    initialTimer.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        GeneralServices.instance.appCloseDialogue(
            context, "Are you sure you want to exit?", () async {
          SystemNavigator.pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const AppoimentAppbar(),
        drawer: const CustomDrawer(),
        body: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              return const InternetHandleScreen();
            } else {
              return FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacingWidget(height: 10),
                    const AppoimentDropdown(),
                    const VerticalSpacingWidget(height: 3),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "Your Appointments",
                        style: size.width > 450 ? greyTab10B600 : grey13B600,
                      ),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: DatePickerDemoClass(
                        height: size.width > 450
                            ? size.height * .14
                            : size.height * .145,
                        width: size.width > 450
                            ? size.width * .1
                            : size.width * .17,
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: kMainColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          controller.selectedDate.value = date;
                          getAllAppointmentController
                              .getAllAppointmentGetxController(
                            date: controller.formatDate(),
                            clinicId: controller.initialIndex.value,
                            scheduleType: controller.scheduleIndex.value,
                          );
                          BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                  context)
                              .add(
                            FetchAllCompletedAppointments(
                              date: formattedDate,
                              clinicId: controller.initialIndex.value,
                              scheduleType: controller.scheduleIndex.value,
                            ),
                          );
                        },
                        dateTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width > 450 ? 10.sp : 16.sp,
                        ),
                        dayTextStyle: TextStyle(
                          fontSize: size.width > 450 ? 8.sp : 12.sp,
                        ),
                        monthTextStyle: TextStyle(
                          fontSize: size.width > 450 ? 8.sp : 12.sp,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    const AppoimentTabbar()
                    // AppoimentTabbar(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

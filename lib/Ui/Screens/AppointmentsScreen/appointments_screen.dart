// ignore_for_file: deprecated_member_use, use_build_context_synchronously
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
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_appointments/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_demo.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/internet_handle_screen.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_appbar.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_dropdown.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_tabbar.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/ScheduleToken/schedule_token_details_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shimmer/shimmer.dart';
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

  late StreamSubscription<ConnectivityResult> subscription;

  late Timer pollingTimer;
  late Timer initialTimer;

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });

    getUserName();
    startPolling();
    super.initState();
  }

  void startPolling() {
    initialTimer = Timer(const Duration(seconds: 1), () {
      BlocProvider.of<GetAppointmentsBloc>(context).add(
        FetchAllAppointments(
            date: controller.formatDate(),
            clinicId: controller.initialIndex!,
            scheduleType: controller.scheduleIndex.value),
      );
      pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        BlocProvider.of<GetAppointmentsBloc>(context).add(
          FetchAllAppointments(
              date: controller.formatDate(),
              clinicId: controller.initialIndex!,
              scheduleType: controller.scheduleIndex.value),
        );
      });
    });
  }

  void stopPolling() {
    pollingTimer.cancel();
    initialTimer.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }

  Future<void> getUserName() async {
    BlocProvider.of<GetAppointmentsBloc>(context).add(
      FetchAllAppointments(
          date: controller.formatDate(),
          clinicId: controller.initialIndex!,
          scheduleType: controller.scheduleIndex.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        GeneralServices.instance
            .appCloseDialogue(context, "Are you want to Exit", () async {
          SystemNavigator.pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        //! tab bar
        appBar: const AppoimentAppbar(),
        drawer: const CustomDrawer(),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   showModalBottomSheet(
        //     backgroundColor: Colors.transparent,
        //     context: context,
        //     builder: (context) {
        //       final size = MediaQuery.of(context).size;
        //       return Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Container(
        //             height: 130.h,
        //             width: size.width * .95,
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 15.w),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: [
        //                       IconButton(
        //                           padding: EdgeInsets.only(left: 30.w),
        //                           onPressed: () {
        //                             Navigator.pop(context);
        //                           },
        //                           icon: const Icon(
        //                             Icons.cancel_outlined,
        //                           )),
        //                     ],
        //                   ),
        //                   Text(
        //                       "Your generated tokens will expire in 10 days. Please generate new tokens :",
        //                       style: size.width > 450
        //                           ? blackMainText
        //                           : blackMainText),
        //                   const VerticalSpacingWidget(height: 10),
        //                   InkWell(
        //                     onTap: () {
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) =>
        //                                   const ScheduleTokenDetailsScreen()));
        //                     },
        //                     child: Center(
        //                       child: Container(
        //                         height: 35.h,
        //                         width: 120.w,
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(10),
        //                           color: kMainColor,
        //                         ),
        //                         child: Center(
        //                           child: Text(
        //                             "Generate token",
        //                             style: size.width > 450
        //                                 ? white12Bold
        //                                 : white12Bold,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           const VerticalSpacingWidget(height: 10),
        //         ],
        //       );
        //     },
        //   );
        // }),
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
                      child: Text("Your Appointments",
                          style: size.width > 450 ? greyTab10B600 : grey13B600),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: DatePickerDemoClass(
                        height: size.width > 450
                            ? size.height * .1
                            : size.height * .145,
                        width: size.width > 450
                            ? size.width * .12
                            : size.width * .17,
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: kMainColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          controller.selectedDate = date;
                          BlocProvider.of<GetAppointmentsBloc>(context).add(
                            FetchAllAppointments(
                                date: formattedDate,
                                clinicId: controller.initialIndex!,
                                scheduleType: controller.scheduleIndex.value),
                          );
                          BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                  context)
                              .add(
                            FetchAllCompletedAppointments(
                                date: formattedDate,
                                clinicId: controller.initialIndex!,
                                scheduleType: controller.scheduleIndex.value),
                          );
                          // AppoimentTabbar();
                        },
                        dateTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width > 450 ? 10.sp : 16.sp),
                        dayTextStyle: TextStyle(
                            fontSize: size.width > 450 ? 8.sp : 12.sp),
                        monthTextStyle: TextStyle(
                            fontSize: size.width > 450 ? 8.sp : 12.sp),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    const AppoimentTabbar(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _shimmerLoading() {
    return SizedBox(
      // color: Colors.yellow,
      height: 430.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const VerticalSpacingWidget(height: 10),
              Container(
                width: 130.w,
                height: 20.h,
                color: Colors.white,
              ),
              // const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 90.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                  Container(
                    width: 70.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                ],
              ),
              // const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 8,),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}

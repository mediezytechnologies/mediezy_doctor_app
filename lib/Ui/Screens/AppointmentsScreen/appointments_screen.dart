// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_appbar.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_dropdown.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appoiment_tabbar.dart';
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

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());

    getUserName();

    super.initState();
  }

  Future<void> getUserName() async {
    BlocProvider.of<GetAllAppointmentsBloc>(context).add(FetchAllAppointments(
      date: controller.formatDate(),
      clinicId: controller.initialIndex!,
      scheduleType: controller.scheduleIndex.value,
    ));
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
        appBar: AppoimentAppbar(),

        drawer: CustomDrawer(),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("HEIGHT : ${size.height.toString()}",style: TextStyle(fontSize: 20.sp),),
              //   Text("WIDTH : ${size.width.toString()}",style: TextStyle(fontSize: 20),),


              const VerticalSpacingWidget(height: 10),
              const AppoimentDropdown(),
              const VerticalSpacingWidget(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Your Appointments",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: kSubTextColor),
                ),
              ),
              EasyDateTimeLine(
                initialDate: controller.selectedDate,
                disabledDates: _getDisabledDates(),
                onDateChange: (date) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  controller.selectedDate = date;
                  BlocProvider.of<GetAllAppointmentsBloc>(context).add(
                    FetchAllAppointments(
                        date: formattedDate,
                        clinicId: controller.initialIndex!,
                        scheduleType: controller.scheduleIndex.value),
                  );
                  BlocProvider.of<GetAllCompletedAppointmentsBloc>(context).add(
                    FetchAllCompletedAppointments(
                        date: formattedDate,
                        clinicId: controller.initialIndex!,
                        scheduleType: controller.scheduleIndex.value),
                  );
                },
                activeColor: kMainColor,
                headerProps: const EasyHeaderProps(
                  selectedDateFormat: SelectedDateFormat.monthOnly,
                ),
                dayProps: EasyDayProps(
                  height: 50.h,
                  width: 50.w,
                  dayStructure: DayStructure.dayNumDayStr,
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: kMainColor)),
                    dayNumStyle: TextStyle(fontSize: 18.0, color: kTextColor),
                  ),
                  activeDayStyle: DayStyle(
                    borderRadius: 10,
                    dayNumStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: kCardColor),
                  ),
                  activeDayStrStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: kCardColor),
                ),
              ),
              const VerticalSpacingWidget(height: 5),
              AppoimentTabbar()
            ],
          ),
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

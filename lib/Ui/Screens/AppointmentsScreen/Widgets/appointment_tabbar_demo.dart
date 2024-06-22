import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_tabbar_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/completed_appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import '../../../../Model/GetAppointments/get_all_completed_appointments_model.dart';
import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import '../../../../Repositary/getx/apointment_detail_getx.dart';
import '../../../../Repositary/getx/get_appointment_getx.dart';
import '../../../CommonWidgets/vertical_spacing_widget.dart';
import '../../../Consts/app_colors.dart';
import '../AppointmentDetailsScreen/appointment_details_screen _demo.dart';

class AppoimentTabbarDemo extends StatefulWidget {
  const AppoimentTabbarDemo({super.key});

  @override
  State<AppoimentTabbarDemo> createState() => _AppoimentTabbarDemoState();
}

class _AppoimentTabbarDemoState extends State<AppoimentTabbarDemo>
    with TickerProviderStateMixin {
  // late GetAllAppointmentsModel getAllAppointmentsModel;
  //late GetAppointmentsModel getAppointmentsModel;
  late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  final HospitalController hospitalController = Get.put(HospitalController());
  final bokingAppointmentLabController =
      Get.put(BookingAppointmentLabController());
  late TabController tabController;
  final getAllAppointmentController = Get.put(GetAllAppointmentController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllAppointmentController.getAllAppointmentGetxController(
        date: hospitalController.formatDate(),
        clinicId: hospitalController.initialIndex.value,
        scheduleType: hospitalController.scheduleIndex.value,
      );
    });

    // Future.delayed(const Duration(milliseconds: 500), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacingWidget(height: 5),
          CustomTabbarWidget(
            onTap: (p0) {
              if (tabController.index == 0) {
                getAllAppointmentController.getAllAppointmentGetxController(
                  date: hospitalController.formatDate(),
                  clinicId: hospitalController.initialIndex.value,
                  scheduleType: hospitalController.scheduleIndex.value,
                );
              } else {
                BlocProvider.of<GetAllCompletedAppointmentsBloc>(context).add(
                  FetchAllCompletedAppointments(
                      date: hospitalController.formatDate(),
                      clinicId: hospitalController.initialIndex.value,
                      scheduleType: hospitalController.scheduleIndex.value),
                );
              }
              log(hospitalController.formatDate());
            },
            height: size.width > 450 ? size.height * .065 : size.height * .055,
            marginHorizontal: 8,
            controller: tabController,
            unselectedLebelSize: size.width > 450 ? 11.sp : 12.sp,
            selectedLebelSize: size.width > 450 ? 11.sp : 12.sp,
            tabText1: "Upcoming",
            tabText2: "Completed",
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                GetBuilder<GetAllAppointmentController>(builder: (controller) {
                  if (controller.loding.value) {
                    return Center(child:  CupertinoActivityIndicator(color: kMainColor,radius: 20.r,));
                  }
                  if (controller.bookingData.isEmpty) {
                    return const Center(
                        child: Image(
                            image: AssetImage(
                                "assets/images/No Appointment to day-01.png")));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const VerticalSpacingWidget(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "Patient Count (${getAllAppointmentController.bookingData.length.toString()})",
                            style:
                                size.width > 450 ? blackTab9B600 : black11Bbold,
                          ),
                        ),
                        const VerticalSpacingWidget(height: 3),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              getAllAppointmentController.bookingData.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const VerticalSpacingWidget(height: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                              child: InkWell(
                                onTap: () {
                                  // bokingAppointmentLabController.addtoTembList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            // AppointmentDemo()
                                           // AppointmentDetailsScreen(
                                            AppointmentDetailsScreenDemo(
                                              firstIndex:
                                                  getAllAppointmentController
                                                      .bookingData[index]
                                                      .firstIndexStatus!,
                                              length:
                                                  getAllAppointmentController
                                                      .bookingData.length,
                                              position: index,
                                              tokenId:
                                                  getAllAppointmentController
                                                      .bookingData[index]
                                                      .tokenId
                                                      .toString(),
                                              date: hospitalController.formatDate(),
                                              patientName:
                                                  getAllAppointmentController
                                                      .bookingData[index]
                                                      .patientName
                                                      .toString(),
                                            )),
                                  );
                                },
                                child: AppointmentCardWidget(
                                  tokenNumber: getAllAppointmentController
                                      .bookingData[index].tokenNumber
                                      .toString(),
                                  patientImage: getAllAppointmentController
                                              .bookingData[index].userImage ==
                                          null
                                      ? ""
                                      : getAllAppointmentController
                                          .bookingData[index].userImage
                                          .toString(),
                                  patientName: getAllAppointmentController
                                      .bookingData[index].patientName
                                      .toString(),
                                  time: getAllAppointmentController
                                      .bookingData[index].tokenTime
                                      .toString(),
                                  mediezyId: getAllAppointmentController
                                              .bookingData[index]
                                              .mediezyPatientId ==
                                          null
                                      ? ""
                                      : getAllAppointmentController
                                          .bookingData[index].mediezyPatientId
                                          .toString(),
                                  mainSymptoms: getAllAppointmentController
                                          .bookingData[index]
                                          .mainSymptoms!
                                          .isEmpty
                                      ? getAllAppointmentController
                                          .bookingData[index]
                                          .otherSymptoms!
                                          .first
                                          .name
                                          .toString()
                                      : getAllAppointmentController
                                          .bookingData[index]
                                          .mainSymptoms!
                                          .first
                                          .name
                                          .toString(),
                                  onlineStatus: getAllAppointmentController
                                      .bookingData[index].onlineStatus
                                      .toString(),
                                  reachedStatus: "",
                                  noStatus: 0,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
                //! completed
                BlocBuilder<GetAllCompletedAppointmentsBloc,
                    GeAllCompletedAppointmentsState>(builder: (context, state) {
                  if (state is GetAllCompletedAppointmentsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is GetAllCompletedAppointmentsError) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                  if (state is GetAllCompletedAppointmentsLoaded) {
                    getAllCompletedAppointmentsModel =
                        BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                context)
                            .getAllCompletedAppointmentsModel;
                  }
                  return getAllCompletedAppointmentsModel.appointments!.isEmpty
                      ? const Center(
                          child: Image(
                              image: AssetImage(
                                  "assets/images/No completed Appointment to day-01-01.png")))
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const VerticalSpacingWidget(height: 5),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "Patient Count (${getAllCompletedAppointmentsModel.appointments!.length.toString()})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: getAllCompletedAppointmentsModel
                                    .appointments!.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const VerticalSpacingWidget(height: 3),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    CompletedAppointmentDetailsScreen(
                                                      tokenId:
                                                          getAllCompletedAppointmentsModel
                                                              .appointments![
                                                                  index]
                                                              .id
                                                              .toString(),
                                                    )));
                                      },
                                      child: AppointmentCardWidget(
                                        tokenNumber:
                                            getAllCompletedAppointmentsModel
                                                .appointments![index]
                                                .tokenNumber
                                                .toString(),
                                        patientImage:
                                            getAllCompletedAppointmentsModel
                                                        .appointments![index]
                                                        .userImage ==
                                                    null
                                                ? ""
                                                : getAllCompletedAppointmentsModel
                                                    .appointments![index]
                                                    .userImage
                                                    .toString(),
                                        patientName:
                                            getAllCompletedAppointmentsModel
                                                .appointments![index]
                                                .patientName
                                                .toString(),
                                        time: getAllCompletedAppointmentsModel
                                            .appointments![index].startingtime
                                            .toString(),
                                        mediezyId:
                                            getAllCompletedAppointmentsModel
                                                        .appointments![index]
                                                        .mediezyPatientId ==
                                                    null
                                                ? ""
                                                : getAllCompletedAppointmentsModel
                                                    .appointments![index]
                                                    .mediezyPatientId
                                                    .toString(),
                                        mainSymptoms:
                                            getAllCompletedAppointmentsModel
                                                        .appointments![index]
                                                        .mainSymptoms ==
                                                    null
                                                ? getAllCompletedAppointmentsModel
                                                    .appointments![index]
                                                    .otherSymptoms!
                                                    .first
                                                    .symtoms
                                                    .toString()
                                                : getAllCompletedAppointmentsModel
                                                    .appointments![index]
                                                    .mainSymptoms!
                                                    .mainsymptoms
                                                    .toString(),
                                        onlineStatus:
                                            getAllCompletedAppointmentsModel
                                                .appointments![index]
                                                .onlineStatus
                                                .toString(),
                                        reachedStatus: "",
                                        noStatus: 0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

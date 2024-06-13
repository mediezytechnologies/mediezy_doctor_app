import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_appointments/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_tabbar_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/completed_appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import '../../../../Model/GetAppointments/get_all_completed_appointments_model.dart';
import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import '../../../../Repositary/getx/apointment_detail_getx.dart';
import '../../../CommonWidgets/vertical_spacing_widget.dart';
import '../../../Consts/app_colors.dart';

class AppoimentTabbar extends StatefulWidget {
  const AppoimentTabbar({super.key});

  @override
  State<AppoimentTabbar> createState() => _AppoimentTabbarState();
}

class _AppoimentTabbarState extends State<AppoimentTabbar>
    with TickerProviderStateMixin {
  // late GetAllAppointmentsModel getAllAppointmentsModel;
  late GetAppointmentsModel getAppointmentsModel;
  late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  final HospitalController controller = Get.put(HospitalController());
  final bokingAppointmentLabController =
      Get.put(BookingAppointmentLabController());
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // Future.delayed(const Duration(milliseconds: 500), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<GetAppointmentsBloc, GetAppointmentsState>(
        builder: (context, state) {
      if (state is GetAppointmentsLoading) {
        // return _shimmerLoading();
      }
      if (state is GetAppointmentsError) {
        return const Center(
          child: Text("Something Went Wrong"),
        );
      }
      if (state is GetAppointmentsLoaded) {
        if (state.isLoaded) {
          getAppointmentsModel = BlocProvider.of<GetAppointmentsBloc>(context)
              .getAppointmentsModel;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(height: 5),
                CustomTabbarWidget(
                  onTap: (p0) {
                    if (tabController.index == 0) {
                      BlocProvider.of<GetAppointmentsBloc>(context).add(
                        FetchAllAppointments(
                            date: controller.formatDate(),
                            clinicId: controller.initialIndex!,
                            scheduleType: controller.scheduleIndex.value),
                      );
                    } else {
                      BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
                          .add(
                        FetchAllCompletedAppointments(
                            date: controller.formatDate(),
                            clinicId: controller.initialIndex!,
                            scheduleType: controller.scheduleIndex.value),
                      );
                    }
                    log(controller.formatDate());
                  },
                  height: size.width > 450
                      ? size.height * .065
                      : size.height * .055,
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
                      getAppointmentsModel.bookingData!.isEmpty
                          ? const Center(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/No Appointment to day-01.png")))
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const VerticalSpacingWidget(height: 5),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "Patient Count (${getAppointmentsModel.bookingData!.length.toString()})",
                                      style: size.width > 450
                                          ? blackTab9B600
                                          : black11Bbold,
                                    ),
                                  ),
                                  const VerticalSpacingWidget(height: 3),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: getAppointmentsModel
                                        .bookingData!.length,
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        const VerticalSpacingWidget(height: 3),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                                        child: InkWell(
                                          onTap: () {
                                           // bokingAppointmentLabController.addtoTembList();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      // AppointmentDemo()
                                                      AppointmentDetailsScreen(
                                                        firstIndex:
                                                            getAppointmentsModel
                                                                .bookingData![
                                                                    index]
                                                                .firstIndexStatus!,
                                                        length:
                                                            getAppointmentsModel
                                                                .bookingData!
                                                                .length,
                                                        position: index,
                                                        tokenId:
                                                            getAppointmentsModel
                                                                .bookingData![
                                                                    index]
                                                                .tokenId
                                                                .toString(),
                                                        date: controller
                                                            .formatDate(),
                                                        patientName:
                                                            getAppointmentsModel
                                                                .bookingData![
                                                                    index]
                                                                .patientName
                                                                .toString(),
                                                      )),
                                            );
                                          },
                                          child: AppointmentCardWidget(
                                            tokenNumber: getAppointmentsModel
                                                .bookingData![index].tokenNumber
                                                .toString(),
                                            patientImage: getAppointmentsModel
                                                        .bookingData![index]
                                                        .userImage ==
                                                    null
                                                ? ""
                                                : getAppointmentsModel
                                                    .bookingData![index]
                                                    .userImage
                                                    .toString(),
                                            patientName: getAppointmentsModel
                                                .bookingData![index].patientName
                                                .toString(),
                                            time: getAppointmentsModel
                                                .bookingData![index].tokenTime
                                                .toString(),
                                            mediezyId: getAppointmentsModel
                                                        .bookingData![index]
                                                        .mediezyPatientId ==
                                                    null
                                                ? ""
                                                : getAppointmentsModel
                                                    .bookingData![index]
                                                    .mediezyPatientId
                                                    .toString(),
                                            mainSymptoms: getAppointmentsModel
                                                    .bookingData![index]
                                                    .mainSymptoms!
                                                    .isEmpty
                                                ? getAppointmentsModel
                                                    .bookingData![index]
                                                    .otherSymptoms!
                                                    .first
                                                    .name
                                                    .toString()
                                                : getAppointmentsModel
                                                    .bookingData![index]
                                                    .mainSymptoms!
                                                    .first
                                                    .name
                                                    .toString(),
                                            onlineStatus: getAppointmentsModel
                                                .bookingData![index]
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
                            ),
                      //! completed
                      BlocBuilder<GetAllCompletedAppointmentsBloc,
                              GeAllCompletedAppointmentsState>(
                          builder: (context, state) {
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
                        return getAllCompletedAppointmentsModel
                                .appointments!.isEmpty
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(
                                        "Patient Count (${getAllCompletedAppointmentsModel.appointments!.length.toString()})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          getAllCompletedAppointmentsModel
                                              .appointments!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const VerticalSpacingWidget(
                                                  height: 3),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 5.h, 0, 2.h),
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
                                                              .appointments![
                                                                  index]
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
                                              time:
                                                  getAllCompletedAppointmentsModel
                                                      .appointments![index]
                                                      .startingtime
                                                      .toString(),
                                              mediezyId:
                                                  getAllCompletedAppointmentsModel
                                                              .appointments![
                                                                  index]
                                                              .mediezyPatientId ==
                                                          null
                                                      ? ""
                                                      : getAllCompletedAppointmentsModel
                                                          .appointments![index]
                                                          .mediezyPatientId
                                                          .toString(),
                                              mainSymptoms:
                                                  getAllCompletedAppointmentsModel
                                                              .appointments![
                                                                  index]
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
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          );
        }
      }
      return Container();
    });
  }
}

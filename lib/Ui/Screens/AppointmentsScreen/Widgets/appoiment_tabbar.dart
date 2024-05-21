import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/ap_demo.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/completed_appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import '../../../../Model/GetAppointments/get_all_appointments_model.dart';
import '../../../../Model/GetAppointments/get_all_completed_appointments_model.dart';
import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import '../../../CommonWidgets/vertical_spacing_widget.dart';
import '../../../Consts/app_colors.dart';

class AppoimentTabbar extends StatefulWidget {
  const AppoimentTabbar({super.key});

  @override
  State<AppoimentTabbar> createState() => _AppoimentTabbarState();
}

class _AppoimentTabbarState extends State<AppoimentTabbar>
    with TickerProviderStateMixin {
  late GetAllAppointmentsModel getAllAppointmentsModel;
  late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  final HospitalController controller = Get.put(HospitalController());
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 500), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<GetAllAppointmentsBloc, GetAllAppointmentsState>(
        builder: (context, state) {
      if (state is GetAllAppointmentsLoading) {
        // return _shimmerLoading();
      }
      if (state is GetAllAppointmentsError) {
        return const Center(
          child: Text("Something Went Wrong"),
        );
      }
      if (state is GetAllAppointmentsLoaded) {
        getAllAppointmentsModel =
            BlocProvider.of<GetAllAppointmentsBloc>(context)
                .getAllAppointmentsModel;
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacingWidget(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  height: size.width > 450
                      ? size.height * .065
                      : size.height * .055,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10), // Set border radius
                  ),
                  // color: kCardColor,
                  child: TabBar(
                    controller: tabController,
                    physics: const ClampingScrollPhysics(),
                    dividerColor: kCardColor,
                    unselectedLabelColor: kTextColor,
                    onTap: (d) {
                      // log("${tabController.index}");
                      if (tabController.index == 0) {
                        BlocProvider.of<GetAllAppointmentsBloc>(context).add(
                          FetchAllAppointments(
                              date: controller.formatDate(),
                              clinicId: controller.initialIndex!,
                              scheduleType: controller.scheduleIndex.value),
                        );
                      } else {
                        BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                context)
                            .add(
                          FetchAllCompletedAppointments(
                              date: controller.formatDate(),
                              clinicId: controller.initialIndex!,
                              scheduleType: controller.scheduleIndex.value),
                        );
                      }
                    },
                    unselectedLabelStyle: TextStyle(
                      fontSize: size.width > 450 ? 11.sp : 12.sp,
                    ),
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: size.width > 450 ? 11.sp : 12.sp,
                        fontWeight: FontWeight.w600),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kMainColor),
                    // color: Color(0xff8ebcbf)),
                    tabs: [
                      //! up coming
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Upcoming",
                            ),
                          ),
                        ),
                      ),
                      //! completed
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Completed"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    getAllAppointmentsModel.appointments!.isEmpty
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
                                    "Patient Count (${getAllAppointmentsModel.appointments!.length.toString()})",
                                    style: size.width > 450
                                        ? blackTab9B600
                                        : black11Bbold,
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 3),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: getAllAppointmentsModel
                                      .appointments!.length,
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
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
                                                  AppointmentDetailsScreen(
                                                firstIndex:
                                                    getAllAppointmentsModel
                                                        .appointments![index]
                                                        .firstIndexStatus!,
                                                length: getAllAppointmentsModel
                                                    .appointments!.length,
                                                position: index,
                                                appointmentsDetails:
                                                    getAllAppointmentsModel
                                                        .appointments!,
                                                tokenId: getAllAppointmentsModel
                                                    .appointments![index].id
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: AppointmentCardWidget(
                                          tokenNumber: getAllAppointmentsModel
                                              .appointments![index].tokenNumber
                                              .toString(),
                                          patientImage: getAllAppointmentsModel
                                                      .appointments![index]
                                                      .userImage ==
                                                  null
                                              ? ""
                                              : getAllAppointmentsModel
                                                  .appointments![index]
                                                  .userImage
                                                  .toString(),
                                          patientName: getAllAppointmentsModel
                                              .appointments![index].patientName
                                              .toString(),
                                          time: getAllAppointmentsModel
                                              .appointments![index].startingtime
                                              .toString(),
                                          mediezyId: getAllAppointmentsModel
                                                      .appointments![index]
                                                      .mediezyPatientId ==
                                                  null
                                              ? ""
                                              : getAllAppointmentsModel
                                                  .appointments![index]
                                                  .mediezyPatientId
                                                  .toString(),
                                          mainSymptoms: getAllAppointmentsModel
                                                  .appointments![index]
                                                  .mainSymptoms!
                                                  .isEmpty
                                              ? getAllAppointmentsModel
                                                  .appointments![index]
                                                  .otherSymptoms!
                                                  .first
                                                  .symtoms
                                                  .toString()
                                              : getAllAppointmentsModel
                                                  .appointments![index]
                                                  .mainSymptoms!
                                                  .first
                                                  .symtoms
                                                  .toString(),
                                          onlineStatus: getAllAppointmentsModel
                                              .appointments![index].onlineStatus
                                              .toString(),
                                          reachedStatus: getAllAppointmentsModel
                                              .appointments![index].isReached
                                              .toString(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
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
                                    itemCount: getAllCompletedAppointmentsModel
                                        .appointments!.length,
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        const VerticalSpacingWidget(height: 3),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
<<<<<<< Updated upstream
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
=======
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      // AppointmentDemo()
                                                      AppointmentDetailsDemoScreen(
                                                        firstIndex:
                                                            getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .firstIndexStatus!,
                                                        length:
                                                            getAllAppointmentsModel
                                                                .appointments!
                                                                .length,
                                                        position: index,
                                                        appointmentsDetails:
                                                            getAllAppointmentsModel
                                                                .appointments!,
                                                        tokenId:
                                                            getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                        date: controller
                                                            .formatDate(),
                                                        patientName:
                                                            getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .patientName
                                                                .toString(),
                                                      )
                                                  //     AppointmentDetailsScreen(
                                                  //   // itemCount:
                                                  //   //     getAllAppointmentsModel
                                                  //   //         .appointments!.length,
                                                  //   firstIndex:
                                                  //       getAllAppointmentsModel
                                                  //           .appointments![index]
                                                  //           .firstIndexStatus!,
                                                  //   length: getAllAppointmentsModel
                                                  //       .appointments!.length,
                                                  //   position: index,
                                                  //   appointmentsDetails:
                                                  //       getAllAppointmentsModel
                                                  //           .appointments!,
                                                  //   tokenId: getAllAppointmentsModel
                                                  //       .appointments![index].id
                                                  //       .toString(),
                                                  //   date: controller.formatDate(),
                                                  //   // patientName:
                                                  //   //     getAllAppointmentsModel
                                                  //   //         .appointments![index]
                                                  //   //         .patientName
                                                  //   //         .toString(),
                                                  // ),
                                                  ),
                                            );
>>>>>>> Stashed changes
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
      }
      return Container();
    });
  }
}

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/patient_details_completed_widget.dart';

class CompletedAppointmentDetailsScreen extends StatefulWidget {
  const CompletedAppointmentDetailsScreen({
    super.key,
    required this.tokenId,
  });

  final String tokenId;

  @override
  State<CompletedAppointmentDetailsScreen> createState() =>
      CompletedAppointmentDetailsScreenState();
}

class CompletedAppointmentDetailsScreenState
    extends State<CompletedAppointmentDetailsScreen> {
  final HospitalController controller = Get.put(HospitalController());
  late GetAllCompletedAppointmentDetailsModel
      getAllCompletedAppointmentDetailsModel;

  @override
  void initState() {
    BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
        .add(FetchAllCompletedAppointmentDetails(tokenId: widget.tokenId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        BlocProvider.of<GetAllCompletedAppointmentsBloc>(context).add(
          FetchAllCompletedAppointments(
              date: controller.formatDate(),
              clinicId: controller.initialIndex!,
              scheduleType: controller.scheduleIndex.value),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<GetAllCompletedAppointmentsBloc>(context).add(
                  FetchAllCompletedAppointments(
                      date: controller.formatDate(),
                      clinicId: controller.initialIndex!,
                      scheduleType: controller.scheduleIndex.value),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Completed appointment"),
          centerTitle: true,
        ),
        body: BlocBuilder<GetAllCompletedAppointmentsBloc,
            GeAllCompletedAppointmentsState>(
          builder: (context, state) {
            if (state is GetAllCompletedAppointmentDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAllCompletedAppointmentDetailsError) {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
            if (state is GetAllCompletedAppointmentDetailsLoaded) {
              getAllCompletedAppointmentDetailsModel =
                  BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
                      .getAllCompletedAppointmentDetailsModel;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FadedScaleAnimation(
                              scaleDuration: const Duration(milliseconds: 400),
                              fadeDuration: const Duration(milliseconds: 400),
                              child: PatientImageWidget(
                                  patientImage:
                                      getAllCompletedAppointmentDetailsModel
                                                  .appointmentDetails!
                                                  .first
                                                  .patientUserImage ==
                                              null
                                          ? ""
                                          : getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .patientUserImage
                                              .toString(),
                                  radius: 40.r)),
                          const HorizontalSpacingWidget(width: 40),
                          //! name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getAllCompletedAppointmentDetailsModel
                                    .appointmentDetails!.first.patientName
                                    .toString(),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                              const VerticalSpacingWidget(height: 15),
                              Row(
                                children: [
                                  getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .mediezyPatientId ==
                                          null
                                      ? Container()
                                      : Text(
                                          "Patient Id : ",
                                          style: size.width > 450
                                              ? greyTabMain
                                              : greyMain,
                                        ),
                                  getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .mediezyPatientId ==
                                          null
                                      ? Container()
                                      : Text(
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .mediezyPatientId!,
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                ],
                              ),
                              const VerticalSpacingWidget(height: 15),
                              Text(
                                '${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.patientAge.toString()} years old',
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const VerticalSpacingWidget(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Appointment Date : ',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                              Text(
                                getAllCompletedAppointmentDetailsModel
                                    .appointmentDetails!.first.date
                                    .toString(),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Appointment time : ',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                              Text(
                                getAllCompletedAppointmentDetailsModel
                                    .appointmentDetails!.first.tokenStartTime
                                    .toString(),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Checkout time : ',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                              Text(
                                getAllCompletedAppointmentDetailsModel
                                    .appointmentDetails!.first.checkoutTime
                                    .toString(),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                          // const VerticalSpacingWidget(height: 10),
                          Row(
                            children: [
                              Text(
                                'Token Number : ',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                              Text(
                                getAllCompletedAppointmentDetailsModel
                                    .appointmentDetails!.first.tokenNumber
                                    .toString(),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                          PatientDetailsCompletedWidget(
                              getAllCompletedAppointmentDetailsModel:
                                  getAllCompletedAppointmentDetailsModel),
                          const VerticalSpacingWidget(height: 5),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals ==
                                  null
                              ? Container()
                              : Text(
                                  'Added Vitals : ',
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                          const VerticalSpacingWidget(height: 5),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals ==
                                  null
                              ? Container()
                              : Container(
                                  height: 100.h,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: kCardColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          getAllCompletedAppointmentDetailsModel
                                                      .appointmentDetails!
                                                      .first
                                                      .vitals!
                                                      .height ==
                                                  null
                                              ? Container()
                                              : ShortNamesWidget(
                                                  firstText: "Height : ",
                                                  secondText:
                                                      "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.height.toString()} cm",
                                                ),
                                          ShortNamesWidget(
                                            firstText: "Temperature : ",
                                            secondText:
                                                "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.temperature.toString()} °${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.temperatureType.toString()}",
                                          ),
                                          ShortNamesWidget(
                                            firstText: "BP : ",
                                            secondText:
                                                "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.sys.toString()} / ${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.dia.toString()}",
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ShortNamesWidget(
                                            firstText: "Weight : ",
                                            secondText:
                                                "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.weight.toString()} Kg",
                                          ),
                                          ShortNamesWidget(
                                              firstText: "spo2 : ",
                                              secondText:
                                                  "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.spo2.toString()} %"),
                                          ShortNamesWidget(
                                              firstText: "Heart Rate : ",
                                              secondText:
                                                  "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.vitals!.heartRate.toString()} BPM"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          const VerticalSpacingWidget(height: 5),
                          getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .doctorMedicines!
                                  .isEmpty
                              ? Container()
                              : Text(
                                  'Added Medicines :',
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                          getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .doctorMedicines!
                                  .isEmpty
                              ? Container()
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .doctorMedicines!
                                          .length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: kCardColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                getAllCompletedAppointmentDetailsModel
                                                            .appointmentDetails!
                                                            .first
                                                            .doctorMedicines![
                                                                index]
                                                            .medicalStoreName ==
                                                        null
                                                    ? Container()
                                                    : ShortNamesWidget(
                                                        firstText:
                                                            "Medical store : ",
                                                        secondText:
                                                            getAllCompletedAppointmentDetailsModel
                                                                .appointmentDetails!
                                                                .first
                                                                .doctorMedicines![
                                                                    index]
                                                                .medicalStoreName
                                                                .toString(),
                                                      ),
                                                ShortNamesWidget(
                                                  firstText: "Medicine : ",
                                                  secondText:
                                                      getAllCompletedAppointmentDetailsModel
                                                          .appointmentDetails!
                                                          .first
                                                          .doctorMedicines![
                                                              index]
                                                          .medicineName
                                                          .toString(),
                                                ),
                                                ShortNamesWidget(
                                                  firstText: "Dosage : ",
                                                  secondText:
                                                      getAllCompletedAppointmentDetailsModel
                                                          .appointmentDetails!
                                                          .first
                                                          .doctorMedicines![
                                                              index]
                                                          .dosage
                                                          .toString(),
                                                ),
                                                getAllCompletedAppointmentDetailsModel
                                                            .appointmentDetails!
                                                            .first
                                                            .doctorMedicines![
                                                                index]
                                                            .interval ==
                                                        null
                                                    ? Container()
                                                    : ShortNamesWidget(
                                                        firstText:
                                                            "Interval : ",
                                                        secondText:
                                                            "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.doctorMedicines![index].interval.toString()} ${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.doctorMedicines![index].timeSection.toString()}",
                                                      ),
                                                ShortNamesWidget(
                                                  firstText: "",
                                                  secondText: getAllCompletedAppointmentDetailsModel
                                                              .appointmentDetails!
                                                              .first
                                                              .doctorMedicines![
                                                                  index]
                                                              .type ==
                                                          1
                                                      ? "After Food"
                                                      : getAllCompletedAppointmentDetailsModel
                                                                  .appointmentDetails!
                                                                  .first
                                                                  .doctorMedicines![
                                                                      index]
                                                                  .type ==
                                                              2
                                                          ? "Before Food"
                                                          : "With Food",
                                                ),
                                                ShortNamesWidget(
                                                  firstText: "Days : ",
                                                  secondText:
                                                      getAllCompletedAppointmentDetailsModel
                                                          .appointmentDetails!
                                                          .first
                                                          .doctorMedicines![
                                                              index]
                                                          .noOfDays
                                                          .toString(),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getAllCompletedAppointmentDetailsModel
                                                                      .appointmentDetails!
                                                                      .first
                                                                      .doctorMedicines![
                                                                          index]
                                                                      .morning ==
                                                                  1
                                                              ? "Morning,"
                                                              : "",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                        Text(
                                                          getAllCompletedAppointmentDetailsModel
                                                                      .appointmentDetails!
                                                                      .first
                                                                      .doctorMedicines![
                                                                          index]
                                                                      .noon ==
                                                                  1
                                                              ? "Noon,"
                                                              : "",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                        Text(
                                                          getAllCompletedAppointmentDetailsModel
                                                                      .appointmentDetails!
                                                                      .first
                                                                      .doctorMedicines![
                                                                          index]
                                                                      .evening ==
                                                                  1
                                                              ? "Evening,"
                                                              : "",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                        Text(
                                                          getAllCompletedAppointmentDetailsModel
                                                                      .appointmentDetails!
                                                                      .first
                                                                      .doctorMedicines![
                                                                          index]
                                                                      .night ==
                                                                  1
                                                              ? "Night"
                                                              : "",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                          const VerticalSpacingWidget(height: 10),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.labName ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  firstText: "Lab name : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.labName
                                          .toString(),
                                ),
                          // const VerticalSpacingWidget(height: 10),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.labTest ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  firstText: "Lab test name : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.labTest
                                          .toString(),
                                ),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.scanName ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  firstText: "Scan name : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.scanName
                                          .toString()),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.scanTest ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  firstText: "Scan test name : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.scanTest
                                          .toString()),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.notes ==
                                  null
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Additional Note : ",
                                      style: size.width > 450
                                          ? greyTabMain
                                          : greyMain,
                                    ),
                                    Text(
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.notes
                                          .toString(),
                                      style: size.width > 450
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  ],
                                ),
                          // const VerticalSpacingWidget(height: 10),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!
                                      .first
                                      .prescriptionImage ==
                                  null
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Added Prescription Image : ",
                                      style: size.width > 450
                                          ? greyTabMain
                                          : greyMain,
                                    ),
                                    const VerticalSpacingWidget(height: 5),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewFileWidget(
                                                    viewFile:
                                                        getAllCompletedAppointmentDetailsModel
                                                            .appointmentDetails!
                                                            .first
                                                            .prescriptionImage
                                                            .toString())));
                                      },
                                      child: Container(
                                        height: 200.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              getAllCompletedAppointmentDetailsModel
                                                  .appointmentDetails!
                                                  .first
                                                  .prescriptionImage
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const VerticalSpacingWidget(height: 20)
                                  ],
                                ),
                        ],
                      ),
                      // const VerticalSpacingWidget(height: 10),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_medicines_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_vitals_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
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
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals ==
                                  null
                              ? Container()
                              : const VerticalSpacingWidget(height: 5),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals ==
                                  null
                              ? Container()
                              : GetVitalsWidget(
                                  dia: getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals!.dia,
                                  heartRate:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .vitals!
                                          .heartRate,
                                  height: getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals!.height,
                                  spo2: getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals!.spo2,
                                  sys: getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals!.sys,
                                  temperature:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .vitals!
                                          .temperature,
                                  temperatureType:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .vitals!
                                          .temperatureType,
                                  weight: getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.vitals!.weight,
                                ),
                          getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .doctorMedicines!
                                  .isEmpty
                              ? Container()
                              : const VerticalSpacingWidget(height: 5),
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
                                    return GetMedicinesWidget(
                                      medicineName:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .medicineName
                                              .toString(),
                                      dosage:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .dosage,
                                      noOfDays:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .noOfDays
                                              .toString(),
                                      timeSection:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .timeSection
                                              .toString(),
                                      evening:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .evening,
                                      interval:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .interval,
                                      morning:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .morning,
                                      night:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .night,
                                      noon:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .noon,
                                      type:
                                          getAllCompletedAppointmentDetailsModel
                                              .appointmentDetails!
                                              .first
                                              .doctorMedicines![index]
                                              .type,
                                    );
                                  }),
                          getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .doctorMedicines!
                                  .isEmpty
                              ? Container()
                              : const VerticalSpacingWidget(height: 10),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.reviewAfter ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  typeId: 1,
                                  firstText: "Review after : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.reviewAfter
                                          .toString(),
                                ),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.labName ==
                                  null
                              ? Container()
                              : ShortNamesWidget(
                                  typeId: 1,
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
                                  typeId: 1,
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
                                  typeId: 1,
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
                                  typeId: 1,
                                  firstText: "Scan test name : ",
                                  secondText:
                                      getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!.first.scanTest
                                          .toString()),
                          getAllCompletedAppointmentDetailsModel
                                      .appointmentDetails!.first.notes ==
                                  null
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Additional Note : ",
                                      style: size.width > 450
                                          ? greyTabMain
                                          : greyMain,
                                    ),
                                    Expanded(
                                      child: Text(
                                        getAllCompletedAppointmentDetailsModel
                                            .appointmentDetails!.first.notes
                                            .toString(),
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
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

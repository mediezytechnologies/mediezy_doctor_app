import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/previous_details/previous_details_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_medicines_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_vitals_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/PreviousBookingScreen/previous_patient_details_widget.dart';

import '../../../CommonWidgets/text_style_widget.dart';

class PreviousBookingDetailsScreen extends StatefulWidget {
  const PreviousBookingDetailsScreen({
    super.key,
    required this.appointmentId,
    required this.patientId,
  });

  final String appointmentId;
  final String patientId;

  @override
  State<PreviousBookingDetailsScreen> createState() =>
      _PreviousBookingDetailsScreenState();
}

class _PreviousBookingDetailsScreenState
    extends State<PreviousBookingDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<PreviousDetailsBloc>(context).add(
        FetchAllPreviousAppointmentDetails(
            patientId: widget.patientId, appointmentId: widget.appointmentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient details"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PreviousDetailsBloc, PreviousDetailsState>(
        builder: (context, state) {
          if (state is PreviousDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PreviousDetailsError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is PreviousDetailsLoaded) {
            final previousAppointmentDetailsModel =
                state.previousAppointmentDetailsModel;
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
                                patientImage: previousAppointmentDetailsModel
                                            .previousappointmentdetails!
                                            .first
                                            .patientUserImage ==
                                        null
                                    ? ""
                                    : previousAppointmentDetailsModel
                                        .previousappointmentdetails!
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
                              previousAppointmentDetailsModel
                                  .previousappointmentdetails!.first.patientName
                                  .toString(),
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                            const VerticalSpacingWidget(height: 15),
                            Row(
                              children: [
                                previousAppointmentDetailsModel
                                            .previousappointmentdetails!
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
                                previousAppointmentDetailsModel
                                            .previousappointmentdetails!
                                            .first
                                            .mediezyPatientId ==
                                        null
                                    ? Container()
                                    : Text(
                                        previousAppointmentDetailsModel
                                            .previousappointmentdetails!
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
                              '${previousAppointmentDetailsModel.previousappointmentdetails!.first.patientAge.toString()} years old',
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
                              style: size.width > 450 ? greyTabMain : greyMain,
                            ),
                            Text(
                              previousAppointmentDetailsModel
                                  .previousappointmentdetails!.first.date
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
                              style: size.width > 450 ? greyTabMain : greyMain,
                            ),
                            Text(
                              previousAppointmentDetailsModel
                                  .previousappointmentdetails!
                                  .first
                                  .tokenStartTime
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
                              style: size.width > 450 ? greyTabMain : greyMain,
                            ),
                            Text(
                              previousAppointmentDetailsModel
                                  .previousappointmentdetails!
                                  .first
                                  .checkoutTime
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
                              style: size.width > 450 ? greyTabMain : greyMain,
                            ),
                            Text(
                              previousAppointmentDetailsModel
                                  .previousappointmentdetails!.first.tokenNumber
                                  .toString(),
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          ],
                        ),
                        PreviousPatientDetailsWidget(
                          previousAppointmentDetailsModel:
                              state.previousAppointmentDetailsModel,
                        ),
                        const VerticalSpacingWidget(height: 5),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.vitals ==
                                null
                            ? Container()
                            : Text(
                                'Added Vitals : ',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                        const VerticalSpacingWidget(height: 5),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.vitals ==
                                null
                            ? Container()
                            : GetVitalsWidget(
                                dia: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .dia
                                    .toString(),
                                heartRate: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .heartRate
                                    .toString(),
                                height: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .height
                                    .toString(),
                                spo2: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .spo2
                                    .toString(),
                                sys: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .sys
                                    .toString(),
                                temperature: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .temperature
                                    .toString(),
                                temperatureType: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .temperatureType
                                    .toString(),
                                weight: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .vitals!
                                    .weight
                                    .toString(),
                              ),
                        const VerticalSpacingWidget(height: 5),
                        previousAppointmentDetailsModel
                                .previousappointmentdetails!
                                .first
                                .doctorMedicines!
                                .isEmpty
                            ? Container()
                            : Text(
                                'Added Medicines :',
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
                              ),
                        previousAppointmentDetailsModel
                                .previousappointmentdetails!
                                .first
                                .doctorMedicines!
                                .isEmpty
                            ? Container()
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .doctorMedicines!
                                    .length,
                                itemBuilder: (context, index) {
                                  return GetMedicinesWidget(
                                    medicineName:
                                        previousAppointmentDetailsModel
                                            .previousappointmentdetails!
                                            .first
                                            .doctorMedicines![index]
                                            .medicineName
                                            .toString(),
                                    dosage: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .dosage,
                                    noOfDays: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .noOfDays
                                        .toString(),
                                    timeSection: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .timeSection
                                        .toString(),
                                    evening: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .evening,
                                    interval: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .interval,
                                    morning: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .morning,
                                    night: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .night,
                                    noon: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .noon,
                                    type: previousAppointmentDetailsModel
                                        .previousappointmentdetails!
                                        .first
                                        .doctorMedicines![index]
                                        .type,
                                  );
                                }),
                        const VerticalSpacingWidget(height: 10),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .labName ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                typeId: 1,
                                firstText: "Lab name : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.labName
                                    .toString(),
                              ),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .labTest ==
                                null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lab test name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing:
                                          8.0, // Add spacing between surgery names
                                      children: previousAppointmentDetailsModel
                                          .previousappointmentdetails!
                                          .first
                                          .labTest!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final name = entry.value;
                                        final isLastItem = index ==
                                            previousAppointmentDetailsModel
                                                    .previousappointmentdetails!
                                                    .first
                                                    .labTest!
                                                    .length -
                                                1;
                                        return Text(
                                          "$name${isLastItem ? '' : ','}",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .scanName ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                typeId: 1,
                                firstText: "Scanning centre : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.scanName
                                    .toString()),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .scanTest ==
                                null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Scan test name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing:
                                          8.0, // Add spacing between surgery names
                                      children: previousAppointmentDetailsModel
                                          .previousappointmentdetails!
                                          .first
                                          .scanTest!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final name = entry.value;
                                        final isLastItem = index ==
                                            previousAppointmentDetailsModel
                                                    .previousappointmentdetails!
                                                    .first
                                                    .scanTest!
                                                    .length -
                                                1;
                                        return Text(
                                          "$name${isLastItem ? '' : ','}",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.notes ==
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
                                      previousAppointmentDetailsModel
                                          .previousappointmentdetails!
                                          .first
                                          .notes
                                          .toString(),
                                      style: size.width > 450
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  ),
                                ],
                              ),
                        // const VerticalSpacingWidget(height: 10),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
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
                                                      previousAppointmentDetailsModel
                                                          .previousappointmentdetails!
                                                          .first
                                                          .prescriptionImage
                                                          .toString())));
                                    },
                                    child: Container(
                                      height: 200.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            previousAppointmentDetailsModel
                                                .previousappointmentdetails!
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
    );
  }
}

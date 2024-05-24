import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/previous_details/previous_details_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
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
                                        previousAppointmentDetailsModel
                                                    .previousappointmentdetails!
                                                    .first
                                                    .vitals!
                                                    .height ==
                                                null
                                            ? Container()
                                            : ShortNamesWidget(
                                                firstText: "Height : ",
                                                secondText:
                                                    "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.height.toString()} cm",
                                              ),
                                        ShortNamesWidget(
                                          firstText: "Temperature : ",
                                          secondText:
                                              "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.temperature.toString()} °${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.temperatureType.toString()}",
                                        ),
                                        ShortNamesWidget(
                                          firstText: "BP : ",
                                          secondText:
                                              "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.sys.toString()} / ${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.dia.toString()}",
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
                                              "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.weight.toString()} Kg",
                                        ),
                                        ShortNamesWidget(
                                            firstText: "spo2 : ",
                                            secondText:
                                                "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.spo2.toString()} %"),
                                        ShortNamesWidget(
                                            firstText: "Heart Rate : ",
                                            secondText:
                                                "${previousAppointmentDetailsModel.previousappointmentdetails!.first.vitals!.heartRate.toString()} BPM"),
                                      ],
                                    ),
                                  ],
                                ),
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
                                              previousAppointmentDetailsModel
                                                          .previousappointmentdetails!
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
                                                          previousAppointmentDetailsModel
                                                              .previousappointmentdetails!
                                                              .first
                                                              .doctorMedicines![
                                                                  index]
                                                              .medicalStoreName
                                                              .toString(),
                                                    ),
                                              ShortNamesWidget(
                                                firstText: "Medicine : ",
                                                secondText:
                                                    previousAppointmentDetailsModel
                                                        .previousappointmentdetails!
                                                        .first
                                                        .doctorMedicines![index]
                                                        .medicineName
                                                        .toString(),
                                              ),
                                              ShortNamesWidget(
                                                firstText: "Dosage : ",
                                                secondText:
                                                    previousAppointmentDetailsModel
                                                        .previousappointmentdetails!
                                                        .first
                                                        .doctorMedicines![index]
                                                        .dosage
                                                        .toString(),
                                              ),
                                              ShortNamesWidget(
                                                firstText: "Interval : ",
                                                secondText:
                                                    "${previousAppointmentDetailsModel.previousappointmentdetails!.first.doctorMedicines![index].interval == null ? "" : previousAppointmentDetailsModel.previousappointmentdetails!.first.doctorMedicines![index].interval.toString()} ${previousAppointmentDetailsModel.previousappointmentdetails!.first.doctorMedicines![index].timeSection.toString()}",
                                              ),
                                              ShortNamesWidget(
                                                firstText: "",
                                                secondText: previousAppointmentDetailsModel
                                                            .previousappointmentdetails!
                                                            .first
                                                            .doctorMedicines![
                                                                index]
                                                            .type ==
                                                        1
                                                    ? "After Food"
                                                    : previousAppointmentDetailsModel
                                                                .previousappointmentdetails!
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
                                                    previousAppointmentDetailsModel
                                                        .previousappointmentdetails!
                                                        .first
                                                        .doctorMedicines![index]
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
                                                        previousAppointmentDetailsModel
                                                                    .previousappointmentdetails!
                                                                    .first
                                                                    .doctorMedicines![
                                                                        index]
                                                                    .morning ==
                                                                1
                                                            ? "Morning,"
                                                            : "",
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                      ),
                                                      Text(
                                                        previousAppointmentDetailsModel
                                                                    .previousappointmentdetails!
                                                                    .first
                                                                    .doctorMedicines![
                                                                        index]
                                                                    .noon ==
                                                                1
                                                            ? "Noon,"
                                                            : "",
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                      ),
                                                      Text(
                                                        previousAppointmentDetailsModel
                                                                    .previousappointmentdetails!
                                                                    .first
                                                                    .doctorMedicines![
                                                                        index]
                                                                    .evening ==
                                                                1
                                                            ? "Evening,"
                                                            : "",
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                      ),
                                                      Text(
                                                        previousAppointmentDetailsModel
                                                                    .previousappointmentdetails!
                                                                    .first
                                                                    .doctorMedicines![
                                                                        index]
                                                                    .night ==
                                                                1
                                                            ? "Night"
                                                            : "",
                                                        style: size.width > 450
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
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .labName ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                firstText: "Lab name : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.labName
                                    .toString(),
                              ),
                        // const VerticalSpacingWidget(height: 10),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .labTest ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                firstText: "Lab test name : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.labTest
                                    .toString(),
                              ),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .scanName ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                firstText: "Scan name : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.scanName
                                    .toString()),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .scanTest ==
                                null
                            ? Container()
                            : ShortNamesWidget(
                                firstText: "Scan test name : ",
                                secondText: previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.scanTest
                                    .toString()),
                        previousAppointmentDetailsModel
                                    .previousappointmentdetails!.first.notes ==
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
                                    previousAppointmentDetailsModel
                                        .previousappointmentdetails!.first.notes
                                        .toString(),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
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

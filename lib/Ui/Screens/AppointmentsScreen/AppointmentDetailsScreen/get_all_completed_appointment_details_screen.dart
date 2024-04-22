import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/patient_details_completed_widget.dart';

class GetAllCompletedAppointmentDetailsScreen extends StatefulWidget {
  const GetAllCompletedAppointmentDetailsScreen({
    super.key,
    required this.tokenId,
  });

  final String tokenId;

  @override
  State<GetAllCompletedAppointmentDetailsScreen> createState() =>
      _GetAllCompletedAppointmentDetailsScreenState();
}

class _GetAllCompletedAppointmentDetailsScreenState
    extends State<GetAllCompletedAppointmentDetailsScreen> {
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
    return Scaffold(
      appBar: AppBar(
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
                                radius: 40)),
                        const HorizontalSpacingWidget(width: 40),
                        //! name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!.first.patientName
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
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
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: kSubTextColor),
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
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 15),
                            Text(
                              '${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.patientAge.toString()} years old',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: kSubTextColor),
                            ),
                            Text(
                              getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!.first.date
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: kTextColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Appointment time : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: kSubTextColor),
                            ),
                            Text(
                              getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!.first.tokenStartTime
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: kTextColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Checkout time : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: kSubTextColor),
                            ),
                            Text(
                              getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!.first.checkoutTime
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: kTextColor),
                            ),
                          ],
                        ),
                        // const VerticalSpacingWidget(height: 10),
                        Row(
                          children: [
                            Text(
                              'Token Number : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: kSubTextColor),
                            ),
                            Text(
                              getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!.first.tokenNumber
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: kTextColor),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: Colors.grey),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    color: kSubTextColor),
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
                                              ShortNamesWidget(
                                                firstText: "Medicine : ",
                                                secondText:
                                                    getAllCompletedAppointmentDetailsModel
                                                        .appointmentDetails!
                                                        .first
                                                        .doctorMedicines![index]
                                                        .medicineName
                                                        .toString(),
                                              ),
                                              ShortNamesWidget(
                                                firstText: "Dosage : ",
                                                secondText:
                                                    getAllCompletedAppointmentDetailsModel
                                                        .appointmentDetails!
                                                        .first
                                                        .doctorMedicines![index]
                                                        .dosage
                                                        .toString(),
                                              ),
                                              ShortNamesWidget(
                                                firstText: "Interval : ",
                                                secondText:
                                                    "${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.doctorMedicines![index].interval == null ? "" : getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.doctorMedicines![index].interval.toString()} ${getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.doctorMedicines![index].timeSection.toString()}",
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
                                                        getAllCompletedAppointmentDetailsModel
                                                                    .appointmentDetails!
                                                                    .first
                                                                    .doctorMedicines![
                                                                        index]
                                                                    .morning ==
                                                                1
                                                            ? "Morning,"
                                                            : "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.sp,
                                                            color: kTextColor),
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
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.sp,
                                                            color: kTextColor),
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
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.sp,
                                                            color: kTextColor),
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
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.sp,
                                                            color: kTextColor),
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
                                    .appointmentDetails!.first.labName ==
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp,
                                        color: kSubTextColor),
                                  ),
                                  Text(
                                    getAllCompletedAppointmentDetailsModel
                                        .appointmentDetails!.first.notes
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: kTextColor),
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp,
                                        color: kSubTextColor),
                                  ),
                                  const VerticalSpacingWidget(height: 5),
                                  Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              getAllCompletedAppointmentDetailsModel
                                                  .appointmentDetails!
                                                  .first
                                                  .prescriptionImage
                                                  .toString()),
                                        )),
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

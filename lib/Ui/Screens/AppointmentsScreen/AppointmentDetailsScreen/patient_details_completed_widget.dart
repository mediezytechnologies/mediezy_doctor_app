import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointment_details_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/names_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PatientDetailsCompletedWidget extends StatefulWidget {
  const PatientDetailsCompletedWidget(
      {super.key, required this.getAllCompletedAppointmentDetailsModel});

  final GetAllCompletedAppointmentDetailsModel
      getAllCompletedAppointmentDetailsModel;

  @override
  State<PatientDetailsCompletedWidget> createState() =>
      _PatientDetailsCompletedWidgetState();
}

class _PatientDetailsCompletedWidgetState
    extends State<PatientDetailsCompletedWidget> {
  bool isFirstCheckIn = true;

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! appointment for
        Text(
          'Appointment for : ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: kSubTextColor),
        ),
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                    .mainSymptoms ==
                null
            ? Container()
            : Text(
                widget.getAllCompletedAppointmentDetailsModel
                    .appointmentDetails!.first.mainSymptoms!.mainsymptoms
                    .toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: kTextColor),
              ),
        // const VerticalSpacingWidget(height: 5),
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                .otherSymptoms!.isEmpty
            ? Container()
            : Wrap(
          children: [
            Text(
              widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.otherSymptoms!
                  .map((symptom) => "${symptom.symtoms}")
                  .join(', '),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: kTextColor,
              ),
            ),
          ],
        ),
        NamesWidget(
          firstText: "When did it start : ",
          secondText: widget.getAllCompletedAppointmentDetailsModel
                      .appointmentDetails!.first.symptomFrequency ==
                  null
              ? ""
              : widget.getAllCompletedAppointmentDetailsModel
                  .appointmentDetails!.first.symptomFrequency
                  .toString(),
        ),
        NamesWidget(
          firstText: "Intensity : ",
          secondText: widget.getAllCompletedAppointmentDetailsModel
                      .appointmentDetails!.first.symptomStartTime ==
                  null
              ? ""
              : widget.getAllCompletedAppointmentDetailsModel
                  .appointmentDetails!.first.symptomStartTime
                  .toString(),
        ),
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                .allergies!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Allergy : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.getAllCompletedAppointmentDetailsModel
                                .appointmentDetails!.first.allergies!.length,
                            (index) {
                              final item = widget
                                  .getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .allergies![index];
                              final allergyName = item.allergyName.toString();
                              final allergyDetails = item.allergyDetails
                                      ?.toString() ??
                                  ''; // If allergyDetails is null, set it to an empty string
                              final text = allergyDetails.isEmpty
                                  ? allergyName
                                  : '$allergyName - $allergyDetails';
                              final isLastItem = index ==
                                  widget
                                          .getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .allergies!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kTextColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        // NamesWidget(
        //         firstText: "Allergy : ",
        //         secondText:
        //             "${widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.allergy!.allergy.toString()} - ${widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.allergy!.allergy == 'No' ? "" : widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first.allergyName.toString()}",
        //       ),
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                .surgeryName!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Surgery name : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget.getAllCompletedAppointmentDetailsModel
                          .appointmentDetails!.first.surgeryName!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget.getAllCompletedAppointmentDetailsModel
                                .appointmentDetails!.first.surgeryName!.length - 1;
                        return Text(
                          name == "Other"
                              ? "${widget.getAllCompletedAppointmentDetailsModel
                              .appointmentDetails!.first.surgeryDetails}${isLastItem ? '' : ','}"
                              : "$name" + (isLastItem ? '' : ','),
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: kTextColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),
        // NamesWidget(
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                .treatmentTaken!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Treatment taken : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget.getAllCompletedAppointmentDetailsModel
                          .appointmentDetails!.first.treatmentTaken!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget.getAllCompletedAppointmentDetailsModel
                                .appointmentDetails!.first.treatmentTaken!.length - 1;
                        return Text(
                          name == "Other"
                              ? "${widget.getAllCompletedAppointmentDetailsModel
                              .appointmentDetails!.first.treatmentTakenDetails}${isLastItem ? '' : ','}"
                              : "$name" + (isLastItem ? '' : ','),
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: kTextColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Regular Medicines : ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: kSubTextColor),
            ),
            widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!
                    .first.patientMedicines!.isEmpty
                ? Text(
                    "No",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: kTextColor,
                    ),
                  )
                : Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget
                                .getAllCompletedAppointmentDetailsModel
                                .appointmentDetails!
                                .first
                                .patientMedicines!
                                .length,
                            (index) {
                              final item = widget
                                  .getAllCompletedAppointmentDetailsModel
                                  .appointmentDetails!
                                  .first
                                  .patientMedicines![index];
                              final text =
                                  "${item.illness.toString()} - ${item.medicineName.toString()}";
                              final isLastItem = index ==
                                  widget
                                          .getAllCompletedAppointmentDetailsModel
                                          .appointmentDetails!
                                          .first
                                          .patientMedicines!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        const VerticalSpacingWidget(height: 5),
        widget.getAllCompletedAppointmentDetailsModel.appointmentDetails!.first
                    .patientId ==
                0
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HealthRecordScreen(
                        patientId: widget.getAllCompletedAppointmentDetailsModel
                            .appointmentDetails!.first.patientId
                            .toString(),
                        userId: widget.getAllCompletedAppointmentDetailsModel
                            .appointmentDetails!.first.patientUserId
                            .toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: mHeight * .07,
                  width: mWidth * .99,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            HorizontalSpacingWidget(width: 5.w),
                            const Text(
                              "Patient Reports",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

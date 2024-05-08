import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/Previous_appointment_details_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/names_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PreviousPatientDetailsWidget extends StatefulWidget {
  const PreviousPatientDetailsWidget(
      {super.key, required this.previousAppointmentDetailsModel});

  final PreviousAppointmentDetailsModel previousAppointmentDetailsModel;

  @override
  State<PreviousPatientDetailsWidget> createState() =>
      _PreviousPatientDetailsWidgetState();
}

class _PreviousPatientDetailsWidgetState
    extends State<PreviousPatientDetailsWidget> {
  bool isFirstCheckIn = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment for :',
          style: size.width > 400 ? greyTabMain : greyMain,
        ),
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                    .mainSymptoms ==
                null
            ? Container()
            : Text(
                widget
                    .previousAppointmentDetailsModel
                    .previousappointmentdetails!
                    .first
                    .mainSymptoms!
                    .mainsymptoms
                    .toString(),
                style: size.width > 400 ? blackTabMainText : blackMainText,
              ),
        // const VerticalSpacingWidget(height: 5),
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                .otherSymptoms!.isEmpty
            ? Container()
            : Wrap(
                children: [
                  Text(
                    widget.previousAppointmentDetailsModel
                        .previousappointmentdetails!.first.otherSymptoms!
                        .map((symptom) => "${symptom.symtoms}")
                        .join(', '),
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                  ),
                ],
              ),
        NamesWidget(
          firstText: "When did it start : ",
          secondText: widget.previousAppointmentDetailsModel
                      .previousappointmentdetails!.first.symptomFrequency ==
                  null
              ? ""
              : widget.previousAppointmentDetailsModel
                  .previousappointmentdetails!.first.symptomFrequency
                  .toString(),
        ),
        NamesWidget(
          firstText: "Intensity : ",
          secondText: widget.previousAppointmentDetailsModel
                      .previousappointmentdetails!.first.symptomStartTime ==
                  null
              ? ""
              : widget.previousAppointmentDetailsModel
                  .previousappointmentdetails!.first.symptomStartTime
                  .toString(),
        ),
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                .allergies!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Allergy : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget
                                .previousAppointmentDetailsModel
                                .previousappointmentdetails!
                                .first
                                .allergies!
                                .length,
                            (index) {
                              final item = widget
                                  .previousAppointmentDetailsModel
                                  .previousappointmentdetails!
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
                                          .previousAppointmentDetailsModel
                                          .previousappointmentdetails!
                                          .first
                                          .allergies!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: size.width > 400
                                      ? blackTabMainText
                                      : blackMainText,
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
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                .surgeryName!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Surgery name : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget.previousAppointmentDetailsModel
                          .previousappointmentdetails!.first.surgeryName!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget
                                    .previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .surgeryName!
                                    .length -
                                1;
                        return Text(
                          name == "Other"
                              ? "${widget.previousAppointmentDetailsModel.previousappointmentdetails!.first.surgeryDetails}${isLastItem ? '' : ','}"
                              : "$name${isLastItem ? '' : ','}",
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: size.width > 400
                              ? blackTabMainText
                              : blackMainText,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
        // NamesWidget(
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                .treatmentTaken!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Treatment taken : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget.previousAppointmentDetailsModel
                          .previousappointmentdetails!.first.treatmentTaken!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget
                                    .previousAppointmentDetailsModel
                                    .previousappointmentdetails!
                                    .first
                                    .treatmentTaken!
                                    .length -
                                1;
                        return Text(
                          name == "Other"
                              ? "${widget.previousAppointmentDetailsModel.previousappointmentdetails!.first.treatmentTakenDetails}${isLastItem ? '' : ','}"
                              : "$name${isLastItem ? '' : ','}",
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: size.width > 400
                              ? blackTabMainText
                              : blackMainText,
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
              style: size.width > 400 ? greyTabMain : greyMain,
            ),
            widget.previousAppointmentDetailsModel.previousappointmentdetails!
                    .first.patientMedicines!.isEmpty
                ? Text(
                    "No",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
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
                                .previousAppointmentDetailsModel
                                .previousappointmentdetails!
                                .first
                                .patientMedicines!
                                .length,
                            (index) {
                              final item = widget
                                  .previousAppointmentDetailsModel
                                  .previousappointmentdetails!
                                  .first
                                  .patientMedicines![index];
                              final text =
                                  "${item.illness.toString()} - ${item.medicineName.toString()}";
                              final isLastItem = index ==
                                  widget
                                          .previousAppointmentDetailsModel
                                          .previousappointmentdetails!
                                          .first
                                          .patientMedicines!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: size.width > 400
                                      ? blackTabMainText
                                      : blackMainText,
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
        widget.previousAppointmentDetailsModel.previousappointmentdetails!.first
                    .patientId ==
                0
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HealthRecordScreen(
                        patientId: widget.previousAppointmentDetailsModel
                            .previousappointmentdetails!.first.patientId
                            .toString(),
                        userId: widget.previousAppointmentDetailsModel
                            .previousappointmentdetails!.first.patientUserId
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
                            Text(
                              "Patient Reports",
                              style: size.width > 400
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: size.width > 400 ? 13.sp : 17.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),
        const VerticalSpacingWidget(height: 5),
      ],
    );
  }
}

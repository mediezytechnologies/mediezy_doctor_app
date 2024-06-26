import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/names_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PatientDetailsWidget extends StatefulWidget {
  const PatientDetailsWidget(
      {super.key, required this.appointmentDetailsPageModel});

  final AppointmentDetailsPageModel appointmentDetailsPageModel;

  @override
  State<PatientDetailsWidget> createState() => _PatientDetailsWidgetState();
}

class _PatientDetailsWidgetState extends State<PatientDetailsWidget> {
  bool isFirstCheckIn = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacingWidget(height: 10),
        //! appointment for
        Text('Appointment for',
            style: size.width > 450 ? greyTabMain : greyMain),
        widget.appointmentDetailsPageModel.bookingData!.mainSymptoms!.isEmpty
            ? Container()
            : Text(
                widget.appointmentDetailsPageModel.bookingData!.mainSymptoms!
                    .first.name
                    .toString(),
                style: size.width > 450 ? blackTabMainText : blackMainText,
              ),
        // const VerticalSpacingWidget(height: 5),
        widget.appointmentDetailsPageModel.bookingData!.otherSymptoms!.isEmpty
            ? Container()
            : Wrap(
                children: [
                  Text(
                    widget
                        .appointmentDetailsPageModel.bookingData!.otherSymptoms!
                        .map((symptom) => "${symptom.name}")
                        .join(', '),
                    style: size.width > 450 ? blackTabMainText : blackMainText,
                  ),
                ],
              ),
        NamesWidget(
          firstText: "When did it start : ",
          secondText:
              widget.appointmentDetailsPageModel.bookingData!.whenitcomes ==
                      null
                  ? ""
                  : widget.appointmentDetailsPageModel.bookingData!.whenitcomes
                      .toString(),
        ),
        NamesWidget(
          firstText: "Intensity : ",
          secondText:
              widget.appointmentDetailsPageModel.bookingData!.whenitstart ==
                      null
                  ? ""
                  : widget.appointmentDetailsPageModel.bookingData!.whenitstart
                      .toString(),
        ),
        widget.appointmentDetailsPageModel.bookingData!.allergiesDetails!
                .isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Allergy : ",
                    style: size.width > 450 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.appointmentDetailsPageModel.bookingData!
                                .allergiesDetails!.length,
                            (index) {
                              final item = widget.appointmentDetailsPageModel
                                  .bookingData!.allergiesDetails![index];
                              final allergyName = item.allergyName.toString();
                              final allergyDetails = item.allergyDetails
                                      ?.toString() ??
                                  ''; // If allergyDetails is null, set it to an empty string
                              final text = allergyDetails.isEmpty
                                  ? allergyName
                                  : '$allergyName - $allergyDetails';
                              final isLastItem = index ==
                                  widget
                                          .appointmentDetailsPageModel
                                          .bookingData!
                                          .allergiesDetails!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: size.width > 450
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
        widget.appointmentDetailsPageModel.bookingData!.surgeryName!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Surgery name : ",
                    style: size.width > 450 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget
                          .appointmentDetailsPageModel.bookingData!.surgeryName!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget.appointmentDetailsPageModel.bookingData!
                                    .surgeryName!.length -
                                1;
                        return Text(
                          name == "Other"
                              ? "${widget.appointmentDetailsPageModel.bookingData!.surgeryDetails}${isLastItem ? '' : ','}"
                              : "$name${isLastItem ? '' : ','}",
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: size.width > 450
                              ? blackTabMainText
                              : blackMainText,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
        // NamesWidget(
        widget.appointmentDetailsPageModel.bookingData!.treatmentTaken!.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Treatment taken : ",
                    style: size.width > 450 ? greyTabMain : greyMain,
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0, // Add spacing between surgery names
                      children: widget.appointmentDetailsPageModel.bookingData!
                          .treatmentTaken!
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final name = entry.value;
                        final isLastItem = index ==
                            widget.appointmentDetailsPageModel.bookingData!
                                    .treatmentTaken!.length -
                                1;
                        return Text(
                          name == "Other"
                              ? "${widget.appointmentDetailsPageModel.bookingData!.treatmentTakenDetails}${isLastItem ? '' : ','}"
                              : "$name${isLastItem ? '' : ','}",
                          // Replace "Other" with "Ashwin" and add comma after each surgery name
                          style: size.width > 450
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
              style: size.width > 450 ? greyTabMain : greyMain,
            ),
            widget.appointmentDetailsPageModel.bookingData!.medicineDetails!
                    .isEmpty
                ? Text(
                    "No",
                    style: size.width > 450 ? blackTabMainText : blackMainText,
                  )
                : Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.appointmentDetailsPageModel.bookingData!
                                .medicineDetails!.length,
                            (index) {
                              final item = widget.appointmentDetailsPageModel
                                  .bookingData!.medicineDetails![index];
                              final text =
                                  "${item.illness.toString()} - ${item.medicineName.toString()}";
                              final isLastItem = index ==
                                  widget
                                          .appointmentDetailsPageModel
                                          .bookingData!
                                          .medicineDetails!
                                          .length -
                                      1;

                              return Padding(
                                padding: EdgeInsets.only(
                                    right: isLastItem ? 0 : 8.0),
                                child: Text(
                                  isLastItem ? text : '$text,',
                                  style: size.width > 450
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
        widget.appointmentDetailsPageModel.bookingData!.patientId == 0
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HealthRecordScreen(
                        patientId: widget
                            .appointmentDetailsPageModel.bookingData!.patientId
                            .toString(),
                        userId: widget.appointmentDetailsPageModel.bookingData!
                            .bookedPersonId
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
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: size.width > 450 ? 13.sp : 17.sp,
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

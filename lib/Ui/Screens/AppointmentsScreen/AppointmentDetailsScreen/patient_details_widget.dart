import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/names_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PatientDetailsWidget extends StatefulWidget {
  const PatientDetailsWidget(
      {super.key,
      this.mainSymptoms,
      this.otherSymptoms,
      required this.whenitcomes,
      this.allergiesDetails,
      this.medicineDetails,
      this.surgeryName,
      this.treatmentTaken,
      required this.whenitstart,
      required this.patientId,
      required this.treatmentTakenDetails,
      required this.surgeryDetails,
      required this.bookedPersonId,
      required this.offlineStatus});

  final List<MainSymptoms>? mainSymptoms;
  final List<OtherSymptoms>? otherSymptoms;
  final List<AllergiesDetails>? allergiesDetails;
  final List<MedicineDetails>? medicineDetails;
  final List<String>? surgeryName;
  final List<String>? treatmentTaken;
  final String whenitcomes;
  final String whenitstart;
  final String bookedPersonId;
  final int patientId;
  final String? treatmentTakenDetails;
  final String surgeryDetails;
  final String offlineStatus;

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
      children: [
        Container(
          decoration: BoxDecoration(
              color: kCardColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacingWidget(height: 10),
              //! appointment for
              Text('Appointment for :',
                  style: size.width > 450 ? greyTabMain : greyMain),
              widget.mainSymptoms!.isEmpty
                  ? Container()
                  : Text(
                      widget.mainSymptoms!.first.name.toString(),
                      style:
                          size.width > 450 ? blackTabMainText : blackMainText,
                    ),
              widget.otherSymptoms!.isEmpty
                  ? Container()
                  : Wrap(
                      children: [
                        Text(
                          widget.otherSymptoms!
                              .map((symptom) => "${symptom.name}")
                              .join(', '),
                          style: size.width > 450
                              ? blackTabMainText
                              : blackMainText,
                        ),
                      ],
                    ),
              NamesWidget(
                firstText: "When did it start : ",
                secondText: widget.whenitcomes.toString(),
              ),
              NamesWidget(
                firstText: "Intensity : ",
                secondText: widget.whenitstart.toString(),
              ),
              widget.allergiesDetails!.isEmpty
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
                                  widget.allergiesDetails!.length,
                                  (index) {
                                    final item =
                                        widget.allergiesDetails![index];
                                    final allergyName =
                                        item.allergyName.toString();
                                    final allergyDetails =
                                        item.allergyDetails?.toString() ?? '';
                                    final text = allergyDetails.isEmpty
                                        ? allergyName
                                        : '$allergyName - $allergyDetails';
                                    final isLastItem = index ==
                                        widget.allergiesDetails!.length - 1;

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
              widget.surgeryName!.isEmpty
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
                            children: widget.surgeryName!
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final name = entry.value;
                              final isLastItem =
                                  index == widget.surgeryName!.length - 1;
                              return Text(
                                name == "Other" ||
                                        name == " Other" ||
                                        name == " Other "
                                    ? "${widget.surgeryDetails}${isLastItem ? '' : ','}"
                                    : "$name${isLastItem ? '' : ','}",
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
              widget.treatmentTaken!.isEmpty
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
                            children: widget.treatmentTaken!
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final name = entry.value;
                              final isLastItem =
                                  index == widget.treatmentTaken!.length - 1;
                              return Text(
                                name == "Other" ||
                                        name == " Other" ||
                                        name == " Other "
                                    ? "${widget.treatmentTakenDetails}${isLastItem ? '' : ','}"
                                    : "$name${isLastItem ? '' : ','}",
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
                  widget.medicineDetails!.isEmpty
                      ? Text(
                          "No",
                          style: size.width > 450
                              ? blackTabMainText
                              : blackMainText,
                        )
                      : Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.medicineDetails!.length,
                                  (index) {
                                    final item = widget.medicineDetails![index];
                                    final text =
                                        "${item.illness.toString()} - ${item.medicineName.toString()}";
                                    final isLastItem = index ==
                                        widget.medicineDetails!.length - 1;

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
            ],
          ),
        ),
        const VerticalSpacingWidget(height: 5),
        widget.offlineStatus == "offline"
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => HealthRecordScreen(
                        patientId: widget.patientId.toString(),
                        userId: widget.bookedPersonId.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: mHeight * .07,
                  width: mWidth * .99,
                  decoration: BoxDecoration(
                      color: kCardColor,
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

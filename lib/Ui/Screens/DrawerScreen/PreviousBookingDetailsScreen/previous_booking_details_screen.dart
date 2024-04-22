import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PreviousBookingDetailsScreen extends StatefulWidget {
  const PreviousBookingDetailsScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.whenItStart,
      required this.whenItCome,
      required this.appointmentFor,
      required this.bookedPersonId,
      required this.patientId,
      required this.appointmentDate,
      required this.appointmentTime,
      required this.tokenNumber,
      required this.usingRegularMedicine,
      required this.addedMedicines,
      required this.reviewAfter,
      required this.medicalShopeName,
      required this.labName,
      required this.labTestName,
      required this.prescriptionImage,
      required this.additionalNote});

  final String name;
  final String age;
  final String whenItStart;
  final String whenItCome;
  final List<Appoinmentfor2> appointmentFor;
  final String bookedPersonId;
  final String patientId;
  final String appointmentDate;
  final String appointmentTime;
  final String tokenNumber;
  final String usingRegularMedicine;
  final List<Medicines> addedMedicines;
  final String reviewAfter;
  final String medicalShopeName;
  final String labName;
  final String labTestName;
  final String prescriptionImage;
  final String additionalNote;

  @override
  State<PreviousBookingDetailsScreen> createState() =>
      _PreviousBookingDetailsScreenState();
}

class _PreviousBookingDetailsScreenState
    extends State<PreviousBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/icons/profile pic.png',
                        ),
                      ),
                    ),
                  ),
                  const HorizontalSpacingWidget(width: 40),
                  //! name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      const VerticalSpacingWidget(height: 30),
                      Text(
                        '${widget.age} years old',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
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
                    widget.appointmentDate.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              Row(
                children: [
                  Text(
                    'Appointment Time : ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Text(
                    widget.appointmentTime.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
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
                    widget.tokenNumber.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              Text(
                'Appointment for : ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    color: kSubTextColor),
              ),
              const VerticalSpacingWidget(height: 5),
              SizedBox(
                height: 20.h,
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Text(
                      "${widget.appointmentFor[index].symtoms}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: kTextColor),
                    );
                  }),
                  itemCount: widget.appointmentFor.length < 3
                      ? widget.appointmentFor.length
                      : 3,
                ),
              ),
              const VerticalSpacingWidget(height: 10),
              Row(
                children: [
                  Text(
                    "When did it start : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Text(
                    widget.whenItCome.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              Row(
                children: [
                  Text(
                    "When it's comes : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Text(
                    widget.whenItStart.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              Row(
                children: [
                  Text(
                    "Using Regular Medicine : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Text(
                    widget.usingRegularMedicine.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              widget.patientId == ""
                  ? Container()
                  : Text(
                      'Patient History :',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: kSubTextColor),
                    ),
              const VerticalSpacingWidget(height: 5),
              widget.patientId == ""
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => HealthRecordScreen(
                              patientId: widget.patientId,
                              userId: widget.bookedPersonId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
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
                                    "Patient History",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
              const VerticalSpacingWidget(height: 10),
              widget.addedMedicines.isEmpty
                  ? Container()
                  : Text(
                      'Added Medicines :',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: kSubTextColor),
                    ),
              const VerticalSpacingWidget(height: 5),
              widget.addedMedicines.isEmpty
                  ? Container()
                  : ListView.separated(
                      itemCount: widget.addedMedicines.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: ((context, index) =>
                          const VerticalSpacingWidget(height: 5)),
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: kCardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.addedMedicines[index].medicineName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                          color: kTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Dosage : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          widget.addedMedicines[index].dosage
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: kTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${widget.addedMedicines[index].noOfDays.toString()} Days",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: kTextColor),
                                  ),
                                ],
                              ),
                              const VerticalSpacingWidget(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.addedMedicines[index].type == 1
                                        ? "After Food"
                                        : "Before Food",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: kTextColor),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          widget.addedMedicines[index]
                                                      .morning ==
                                                  1
                                              ? "Morning,"
                                              : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: kTextColor),
                                        ),
                                        Text(
                                          widget.addedMedicines[index].noon == 1
                                              ? "Noon,"
                                              : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: kTextColor),
                                        ),
                                        Text(
                                          widget.addedMedicines[index].night ==
                                                  1
                                              ? "Night"
                                              : "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: kTextColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.reviewAfter == " "
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Review After : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: kSubTextColor),
                        ),
                        Text(
                          "${widget.reviewAfter.toString()} Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kTextColor),
                        ),
                      ],
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.medicalShopeName == " "
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Medical Shop : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: kSubTextColor),
                        ),
                        Text(
                          widget.medicalShopeName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kTextColor),
                        ),
                      ],
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.labName == " "
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Lab Name : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: kSubTextColor),
                        ),
                        Text(
                          widget.labName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kTextColor),
                        ),
                      ],
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.labTestName == " "
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Lab Test Name : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: kSubTextColor),
                        ),
                        Text(
                          widget.labTestName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kTextColor),
                        ),
                      ],
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.additionalNote == " "
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "Additional Note : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: kSubTextColor),
                        ),
                        Text(
                          widget.additionalNote.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kTextColor),
                        ),
                      ],
                    ),
              const VerticalSpacingWidget(height: 10),
              widget.prescriptionImage == " "
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
                                image: NetworkImage(widget.prescriptionImage),
                              )),
                        ),
                        const VerticalSpacingWidget(height: 20)
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

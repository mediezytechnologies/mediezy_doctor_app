import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/completed_appointments_ht_rcd_model.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/CompletedAppointmentDetailsHealthrecordScreen.dart';
class CompletedAppointmentCardWidget extends StatelessWidget {
  const CompletedAppointmentCardWidget(
      {super.key,
        required this.doctorName,
        required this.doctorImage,
        required this.clinicName,
        required this.symptoms,
        required this.tokenDate,
        required this.tokenTime,
        required this.patientName,
        required this.note,
        // required this.reviewAfter,
        required this.labTestName,
        required this.labName,
        required this.prescriptionImage,
        required this.prescriptions});

  final String doctorName;
  final String doctorImage;
  final String clinicName;
  final String symptoms;
  final String tokenDate;
  final String tokenTime;
  final String patientName;
  final String note;
  // final String reviewAfter;
  final String labTestName;
  final String labName;
  final String prescriptionImage;
  final List<DoctorMedicines> prescriptions;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompletedAppointmentDetailsHealthrecordScreen(
                  prescriptions: prescriptions,
                  clinicName: clinicName,
                  doctorImage: doctorImage,
                  doctorName: doctorName,
                  labName: labName,
                  labTestName: labTestName,
                  // medicalStoreName: medicalStoreName,
                  note: note,
                  patientName: patientName,
                  prescriptionImage: prescriptionImage,
                  // reviewAfter: reviewAfter,
                  symptoms: symptoms,
                  tokenDate: tokenDate,
                  tokenTime: tokenTime,
                )));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kCardColor),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 8.0.h, bottom: 18.0.h, left: 8.w, right: 10.w),
              child: Row(
                children: [
                  FadedScaleAnimation(
                    scaleDuration: const Duration(milliseconds: 400),
                    fadeDuration: const Duration(milliseconds: 400),
                    child: Image.network(
                      doctorImage,
                      height: 105.h,
                      width: 80.w,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 10),
                        Text(
                          "Dr.$doctorName",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          clinicName.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kSubTextColor),
                        ),
                        Text(
                          symptoms,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kSubTextColor),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  tokenDate,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " | ",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  tokenTime,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "For : ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                            Text(
                              patientName,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 5.w, 5.h),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "View More",
                  style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
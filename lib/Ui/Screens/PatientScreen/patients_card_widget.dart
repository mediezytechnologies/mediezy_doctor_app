import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/health_record_screen.dart';

class PatientsCardWidget extends StatefulWidget {
  const PatientsCardWidget({
    super.key,
    required this.patientId,
    required this.userId,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.userImage,
    required this.mediezyPatientId,
  });

  final String patientId;
  final String userId;
  final String patientName;
  final String age;
  final String gender;
  final String userImage;
  final String mediezyPatientId;

  @override
  State<PatientsCardWidget> createState() => _PatientsCardWidgetState();
}

class _PatientsCardWidgetState extends State<PatientsCardWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => HealthRecordScreen(
                      patientId: widget.patientId,
                      userId: widget.userId,
                    )));
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              height: size.width > 400 ? 82.h : 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  //! user image
                  FadedScaleAnimation(
                    scaleDuration: const Duration(milliseconds: 400),
                    fadeDuration: const Duration(milliseconds: 400),
                    child: PatientImageWidget(
                        patientImage: widget.userImage, radius: 30.r),
                  ),
                  const HorizontalSpacingWidget(width: 10),
                  SizedBox(
                    width: 180.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //! name
                        Text(
                          widget.patientName,
                          style: size.width > 400
                              ? blackTabMainText
                              : blackMainText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              "Patient Id : ",
                              style: size.width > 400 ? greyTabMain : greyMain,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.mediezyPatientId,
                              // patientsGetModel.patientData![index].age.toString(),
                              style: size.width > 400
                                  ? blackTab9B600
                                  : blackMainText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Age : ",
                              style: size.width > 400 ? greyTabMain : greyMain,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.age,
                              // patientsGetModel.patientData![index].age.toString(),
                              style: size.width > 400
                                  ? blackTab9B600
                                  : blackMainText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Gender : ",
                              style: size.width > 400 ? greyTabMain : greyMain,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.gender == "1" ? "Male" : "Female",
                              style: size.width > 400
                                  ? blackTab9B600
                                  : blackMainText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
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
    final size=MediaQuery.of(context).size;
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
              height: 100.h,
              width: double .infinity,
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
                   HorizontalSpacingWidget(width: 7.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //! name
                      Text(
                        widget.patientName,
                        style: TextStyle(
                          fontSize: size.width>450?13.sp: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            "Patient Id : ",
                            style: TextStyle(
                                fontSize: size.width>450?8.sp:13.sp,
                                fontWeight: FontWeight.w400,
                                color: kSubTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.mediezyPatientId,
                            // patientsGetModel.patientData![index].age.toString(),
                            style: TextStyle(
                              fontSize:  size.width>450?9.sp:14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Age : ",
                            style: TextStyle(
                                fontSize:  size.width>450?8.sp:13.sp,
                                fontWeight: FontWeight.w400,
                                color: kSubTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.age,
                            // patientsGetModel.patientData![index].age.toString(),
                            style: TextStyle(
                              fontSize:  size.width>450?9.sp:14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Gender : ",
                            style: TextStyle(
                                fontSize:  size.width>450?8.sp:13.sp,
                                fontWeight: FontWeight.w400,
                                color: kSubTextColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.gender == "1" ? "Male" : "Female",
                            style: TextStyle(
                              fontSize: size.width>450?9.sp:14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

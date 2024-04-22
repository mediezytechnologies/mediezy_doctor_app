import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class AppointmentCardWidget extends StatelessWidget {
  const AppointmentCardWidget({
    super.key,
    required this.tokenNumber,
    required this.patientImage,
    required this.patientName,
    required this.time,
    required this.mediezyId,
    required this.mainSymptoms,
    // required this.otherSymptoms,
    required this.onlineStatus,
    required this.reachedStatus,
  });

  final String patientName;
  final String tokenNumber;
  final String patientImage;
  final String time;
  final String mediezyId;
  final String mainSymptoms;
  // final String otherSymptoms;
  final String onlineStatus;
  final String reachedStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            FadedScaleAnimation(
              scaleDuration: const Duration(milliseconds: 400),
              fadeDuration: const Duration(milliseconds: 400),
              child: PatientImageWidget(
                patientImage: patientImage,
                radius: 30,
              ),
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
                    patientName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //! appointment for
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      mainSymptoms,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: kSubTextColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      mediezyId == ""
                          ? Container()
                          : Text(
                              "Patient Id : ",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                      mediezyId == ""
                          ? Container()
                          : Text(
                              mediezyId,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                  //! date and time
                  Row(
                    children: [
                      Text(
                        "Token No : ${tokenNumber.toString()}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            const HorizontalSpacingWidget(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onlineStatus == "offline"
                    ? Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          ),
                          const HorizontalSpacingWidget(width: 5),
                          Text(
                            onlineStatus,
                            style: const TextStyle(color: Colors.red),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kMainColor,
                            radius: 5,
                          ),
                          const HorizontalSpacingWidget(width: 5),
                          Text(
                            onlineStatus,
                            style: TextStyle(color: kMainColor),
                          )
                        ],
                      ),
                reachedStatus == "1"
                    ?Row(
                  children: [
                     CircleAvatar(
                      backgroundColor: kMainColor,
                      radius: 5,
                    ),
                    const HorizontalSpacingWidget(width: 5),
                    Text(
                      reachedStatus=="1"?"Reached":"",
                      style:  TextStyle(color:kMainColor ),
                    )
                  ],
                ): Container()

              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    required this.noStatus,
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
  final int noStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        height: 90.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kCardColor,
        //  color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            FadedScaleAnimation(
              scaleDuration: const Duration(milliseconds: 400),
              fadeDuration: const Duration(milliseconds: 400),
              child: PatientImageWidget(
                patientImage: patientImage,
                radius: 30.r,
              ),
            ),
            const HorizontalSpacingWidget(width: 10),
            Container(
      //color: const Color.fromARGB(255, 23, 22, 21),
              width: 190.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //! name
                  Text(
                    patientName,
                    style: TextStyle(
                      fontSize: 10.sp,
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
                          fontSize: 8.sp,
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
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                      mediezyId == ""
                          ? Container()
                          : Text(
                              mediezyId,
                              style: TextStyle(
                                fontSize: 9.sp,
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
                          fontSize: 8.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " | ",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 9.sp,
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
            noStatus==1?Container():
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
                            radius: 5.r,
                          ),
                          const HorizontalSpacingWidget(width: 5),
                          Text(
                            onlineStatus,
                            style: TextStyle(color: kMainColor,fontSize: 9.sp),
                          )
                        ],
                      ),
                reachedStatus == "1"
                    ? Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: kMainColor,
                            radius: 5,
                          ),
                          const HorizontalSpacingWidget(width: 5),
                          Text(
                            reachedStatus == "1" ? "Reached" : "",
                            style: TextStyle(color: kMainColor),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

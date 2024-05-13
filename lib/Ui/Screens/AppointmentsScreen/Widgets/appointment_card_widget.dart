import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        height: size.width > 450 ? size.height * .14 : size.height * .1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kCardColor,
          //  color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: size.width > 450
              ? EdgeInsets.symmetric(vertical: 8.w)
              : EdgeInsets.symmetric(vertical: .5.w),
          child: Row(
            children: [
              FadedScaleAnimation(
                scaleDuration: const Duration(milliseconds: 400),
                fadeDuration: const Duration(milliseconds: 400),
                child: PatientImageWidget(
                  patientImage: patientImage,
                  radius: size.width > 450 ? 50 : 30,
                ),
              ),
              const HorizontalSpacingWidget(width: 10),
              SizedBox(
                width: size.width > 450 ? size.width * .64 : size.width * .55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //! name
                    Text(
                      patientName,
                      style: size.width > 450 ? blackTab10B600 : blackTab15B600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //! appointment for
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        mainSymptoms,
                        style: size.width > 450 ? greyTab8B400 : grey12B400,
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
                                style: size.width > 450
                                    ? greyTab8B400
                                    : grey12B400,
                              ),
                        mediezyId == ""
                            ? Container()
                            : Text(
                                mediezyId,
                                style: size.width > 450
                                    ? blackTab9B600
                                    : black11Bbold,
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
                          style:
                              size.width > 450 ? blackTab9B600 : black11Bbold,
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
                          style:
                              size.width > 450 ? blackTab9B600 : black11Bbold,
                        ),
                        const HorizontalSpacingWidget(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
              const HorizontalSpacingWidget(width: 10),
              noStatus == 1
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        onlineStatus == "offline"
                            ? Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: size.width > 450 ? 9 : 5,
                                  ),
                                  const HorizontalSpacingWidget(width: 5),
                                  Text(
                                    onlineStatus,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            size.width > 450 ? 9.sp : 12.sp),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kMainColor,
                                    radius: size.width > 450 ? 9 : 5,
                                  ),
                                  const HorizontalSpacingWidget(width: 5),
                                  Text(
                                    onlineStatus,
                                    style: TextStyle(
                                        color: kMainColor,
                                        fontSize:
                                            size.width > 450 ? 9.sp : 12.sp),
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
      ),
    );
  }
}

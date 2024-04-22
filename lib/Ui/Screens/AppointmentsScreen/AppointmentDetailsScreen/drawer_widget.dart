import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  final ProfileGetModel profileGetModel;

  const DrawerWidget({
    Key? key,
    required this.profileGetModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: kMainColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadedScaleAnimation(
                  scaleDuration: const Duration(milliseconds: 400),
                  fadeDuration: const Duration(milliseconds: 400),
                  child: PatientImageWidget(
                      patientImage: profileGetModel.doctorDetails!
                          .first.docterImage ==
                          null
                          ? ""
                          : profileGetModel
                          .doctorDetails!.first.docterImage
                          .toString(),
                      radius: 30),
                ),
                Text(
                  "Dr.${profileGetModel.doctorDetails!.first.firstname.toString()} ${profileGetModel.doctorDetails!.first.secondname.toString()}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "+91 ${profileGetModel.doctorDetails!.first.mobileNumber.toString()}",
                  style: TextStyle(
                      fontSize: 14.sp, color: Colors.white),
                ),
              ],
            ),
          ),
          // Rest of the drawer items...
        ],
      ),
    );
  }
}

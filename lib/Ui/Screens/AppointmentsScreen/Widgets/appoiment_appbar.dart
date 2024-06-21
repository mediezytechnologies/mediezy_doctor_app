import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

const sWidth = ScreenUtil.defaultSize;

class AppoimentAppbar extends StatefulWidget implements PreferredSizeWidget {
  const AppoimentAppbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppoimentAppbarState createState() => _AppoimentAppbarState();

  @override
  Size get preferredSize => Size(double.infinity, 120.h);
}

class _AppoimentAppbarState extends State<AppoimentAppbar> {
  String? firstName;
  String? secondName;
  String? drImage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      firstName = preference.getString('drFirstName');
      secondName = preference.getString('drSecondName');
      drImage = preference.getString('drImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 20.sp),
      backgroundColor: kMainColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: size.width > 450 ? size.width * .00 : size.width * 0.04,
          ),
          child: SizedBox(
            height: size.height * 0.04,
            width: 100.w,
            child: Image.asset("assets/icons/mediezy logo small.png"),
          ),
        )
      ],
      flexibleSpace: SizedBox(
        height: size.width > 450 ? size.height * 0.17 : size.height * 0.27,
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: size.width > 450 ? size.height * .1 : size.height * 0.12,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kMainColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi,",
                              style:TextStyle(
                                      fontSize: size.width > 450? 11.sp : 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)
                                
                            ),
                            Text(
                              "Dr $firstName $secondName",
                              style: size.width > 450
                                  ? TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                                  : TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            Text(
                              "Manage Your Practice With Us",
                              style: size.width > 450
                                  ? TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)
                                  : TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                            ),
                          ],
                        ),
                        // Uncomment and adjust as necessary for PatientImageWidget
                        FadedScaleAnimation(
                          scaleDuration: const Duration(milliseconds: 400),
                          fadeDuration: const Duration(milliseconds: 400),
                          child: PatientImageWidget(
                              patientImage:
                                  drImage == null ? "" : drImage.toString(),
                              radius: size.width > 450 ? 28.r : 35.r),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

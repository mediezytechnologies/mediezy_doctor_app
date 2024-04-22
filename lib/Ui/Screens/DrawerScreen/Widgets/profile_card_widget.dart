import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';


class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon, required this.onTapFunction});

  final String title;
  final String subTitle;
  final IconData icon;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
      scaleDuration: const Duration(milliseconds: 400),
      fadeDuration: const Duration(milliseconds: 400),
      child: InkWell(
        onTap: () {
          onTapFunction();
        },
        child: Container(
          decoration: BoxDecoration(
              color: kCardColor, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(height: 10),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kTextColor),
                ),
                const VerticalSpacingWidget(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kSubTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(flex: 1, child: Icon(icon, color: kSubTextColor))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

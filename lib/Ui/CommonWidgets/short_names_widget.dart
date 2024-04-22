import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class ShortNamesWidget extends StatelessWidget {
  const ShortNamesWidget(
      {super.key, required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          firstText,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: kSubTextColor),
        ),
        Text(
          secondText,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14.sp, color: kTextColor),
        ),
      ],
    );
  }
}

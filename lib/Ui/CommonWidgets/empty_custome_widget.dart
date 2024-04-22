import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class EmptyCutomeWidget extends StatelessWidget {
  const EmptyCutomeWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/animations/emptyDoctor.json"),
        const VerticalSpacingWidget(height: 20),
        Text(
          text,
          style: TextStyle(
              fontSize: 19.sp, fontWeight: FontWeight.w500, color: kMainColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
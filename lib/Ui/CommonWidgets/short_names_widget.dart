import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class ShortNamesWidget extends StatelessWidget {
  const ShortNamesWidget(
      {super.key, required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          firstText,
          style: size.width > 400 ? greyTabMain : greyMain,
        ),
        Text(
          secondText,
          style: size.width > 400 ? blackTabMainText : blackMainText,
        ),
      ],
    );
  }
}

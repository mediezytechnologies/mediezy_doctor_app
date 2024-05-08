import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';

class NamesWidget extends StatelessWidget {
  const NamesWidget(
      {super.key, required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstText,
              style: size.width > 400 ? greyTabMain : greyMain,
            ),
            Expanded(
              child: Text(
                secondText,
                style: size.width > 400 ? blackTabMainText : blackMainText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

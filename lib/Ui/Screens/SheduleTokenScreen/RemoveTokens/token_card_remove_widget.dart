import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class TokenCardRemoveWidget extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String tokenNumber;
  final String time;
  const TokenCardRemoveWidget(
      {super.key,
      required this.color,
      required this.textColor,
      required this.tokenNumber,
      required this.time});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kMainColor, width: 1.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            tokenNumber,
            style: size.width > 400
                ? TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor)
                : TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor),
          ),
          Text(
            time,
            style: size.width > 400
                ? TextStyle(
                    fontSize: 7.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor)
                : TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor),
          )
        ],
      ),
    );
  }
}

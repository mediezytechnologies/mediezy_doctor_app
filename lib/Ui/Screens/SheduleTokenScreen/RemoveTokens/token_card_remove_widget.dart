import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class TokenCardRemoveWidget extends StatelessWidget {
  final Color color;
  final String tokenNumber;
  final String time;
  final int isBooked;
  final int isTimedOut;
  final int isReserved;
  final Color textColor;

  const TokenCardRemoveWidget({
    Key? key,
    required this.color,
    required this.tokenNumber,
    required this.isTimedOut,
    required this.isReserved,
    required this.isBooked,
    required this.time,
    required this.textColor,
  }) : super(key: key);

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
            style: TextStyle(
              fontSize: size.width > 450 ? 12.sp : 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor, // Use the provided textColor
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: size.width > 450 ? 7.sp : 9.sp,
              fontWeight: FontWeight.bold,
              color: textColor, // Use the provided textColor
            ),
          ),
        ],
      ),
    );
  }
}

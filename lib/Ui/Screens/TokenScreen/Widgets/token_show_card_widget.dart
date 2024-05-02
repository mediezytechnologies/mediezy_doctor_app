import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class TokenShowCardWidget extends StatelessWidget {
  const TokenShowCardWidget(
      {super.key, required this.tokenNumber, required this.tokenTime});

  final String tokenNumber;
  final String tokenTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 120.w,
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            tokenNumber,
            style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Text(
            tokenTime,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

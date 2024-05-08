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
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width > 400 ? size.height * .17 : size.height * .16,
      width: size.width > 400 ? size.width * .22 : size.width * .33,
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            tokenNumber,
            style: size.width > 400
                ? TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)
                : TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
          ),
          Text(
            tokenTime,
            style: size.width > 400
                ? TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)
                : TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
          ),
        ],
      ),
    );
  }
}

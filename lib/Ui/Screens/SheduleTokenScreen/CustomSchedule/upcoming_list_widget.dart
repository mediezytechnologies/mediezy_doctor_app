import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class UpcomingListWidget extends StatelessWidget {
  UpcomingListWidget(
      {super.key,
      required this.scheduleType,
      required this.time,
      required this.date,
      required this.section,
      required this.clinicId,
      required this.scheduleId,
      required this.onPressed});

  final String scheduleType;
  final String time;
  final String date;
  final String clinicId;
  final String scheduleId;
  final String section;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width > 450 ? 55.h : 50.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: kScaffoldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  date,
                  style: size.width > 450 ? blackTabMainText : blackMainText,
                ),
                Text(
                  "Schedule $scheduleType - $time mint $section",
                  style: size.width > 450 ? blackTabMainText : blackMainText,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.delete,
                color: kMainColor,
                size: size.width > 450 ? 15.sp : 20.sp,
              ))
        ],
      ),
    );
  }
}

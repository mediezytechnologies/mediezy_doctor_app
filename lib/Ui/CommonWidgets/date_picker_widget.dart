// ignore_for_file: deprecated_member_use

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime)? onDateChange;
  DatePickerWidget({super.key, this.onDateChange});
  @override
  DateTime selectedDate = DateTime.now();
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return EasyDateTimeLine(
      initialDate: selectedDate,
      disabledDates: _getDisabledDates(),
      onDateChange: onDateChange,
      activeColor: kMainColor,
      dayProps: EasyDayProps(
          height: size.width > 450 ? size.height * .1 : size.height * .11,
          width: size.width > 450 ? size.width * .12 : size.width * .17,
          inactiveDayStrStyle:
              TextStyle(fontSize: size.width > 450 ? 8.sp : 12.sp),
          inactiveDayNumStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width > 450 ? 10.sp : 16.sp),
          inactiveMothStrStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.width > 450 ? 8.sp : 12.sp),
          activeDayNumStyle: TextStyle(
              color: kCardColor,
              fontWeight: FontWeight.bold,
              fontSize: size.width > 450 ? 13.sp : 20.sp),
          activeDayStrStyle: TextStyle(
              color: kCardColor,
              fontWeight: FontWeight.w400,
              fontSize: size.width > 450 ? 8.sp : 12.sp),
          activeMothStrStyle: TextStyle(
              color: kCardColor,
              fontWeight: FontWeight.w400,
              fontSize: size.width > 450 ? 8.sp : 12.sp),
          todayHighlightStyle: TodayHighlightStyle.withBackground,
          todayMonthStrStyle: TextStyle(
              color: Colors.grey, fontSize: size.width > 450 ? 8.sp : 12.sp),
          todayNumStyle: TextStyle(fontSize: size.width > 450 ? 13.sp : 20.sp),
          todayStrStyle: TextStyle(
              color: Colors.grey, fontSize: size.width > 450 ? 8.sp : 12.sp),
          todayHighlightColor: const Color(0xffE1ECC8),
          borderColor: kMainColor),
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    // Iterate through the months and add all dates before the current date
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}

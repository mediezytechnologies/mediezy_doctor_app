import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class AppointmentDateCardWidget extends StatefulWidget {
  const AppointmentDateCardWidget(
      {super.key, required this.month, required this.date});

  final String month;
  final String date;

  @override
  State<AppointmentDateCardWidget> createState() =>
      _AppointmentDateCardWidgetState();
}

bool isSelected = false;

class _AppointmentDateCardWidgetState extends State<AppointmentDateCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        height: 75.h,
        width: 60.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? kMainColor : kCardColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.month,
              style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : kTextColor),
            ),
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : kTextColor),
            )
          ],
        ),
      ),
    );
  }
}

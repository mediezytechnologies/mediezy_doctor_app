// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class CommomUsedContainerWidget extends StatelessWidget {
  CommomUsedContainerWidget(
      {super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isClicked ? Colors.grey : kCardColor,
          border: Border.all(color: kMainColor, width: 1),
        ),
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(6.0),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: isClicked ? Colors.white : kTextColor),
        ),
      ),
    );
  }
}

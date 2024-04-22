import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      this.value,
      this.items,
      this.onChanged,
      this.width = 170});

  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: width,
      decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFF9C9C9C))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
            child: DropdownButtonFormField(
          iconEnabledColor: kMainColor,
          decoration: const InputDecoration.collapsed(hintText: ''),
          value: value,
          style: TextStyle(
              fontSize: 14.sp, fontWeight: FontWeight.w500, color: kTextColor),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items,
          onChanged: onChanged,
        )),
      ),
    );
  }
}

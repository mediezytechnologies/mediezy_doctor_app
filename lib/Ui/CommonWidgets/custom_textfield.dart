import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: TextFormField(
        style: TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
        cursorColor: kMainColor,
        controller: controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value!.isEmpty || value.length < 2) {
            return "Age is missing";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 13.h),
          hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
          hintText: hintText,
          filled: true,
          fillColor: kCardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

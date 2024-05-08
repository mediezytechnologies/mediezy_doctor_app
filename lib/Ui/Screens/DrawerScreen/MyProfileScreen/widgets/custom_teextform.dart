// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Consts/app_colors.dart';

// ignore: must_be_immutable
class CustomFomField extends StatelessWidget {
  CustomFomField({
    super.key,
    required this.titles,
    required this.textinputType,
    required this.validator,
    required this.controller,
     this.focusNode,
    required this.prefixIcon,
  });

  String titles;
  final TextInputType textinputType;

  final FormFieldValidator validator;
  final TextEditingController controller;
 
  final FocusNode? focusNode;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kMainColor,
      keyboardType: textinputType,

      controller: controller,
      textInputAction: TextInputAction.next,
      validator: validator,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: kMainColor,
        ),
        hintStyle: TextStyle(fontSize: 15.sp, color: kSubTextColor),
        hintText: titles,
        filled: true,
        fillColor: kCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

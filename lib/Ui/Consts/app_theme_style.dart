import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

ThemeData appThemeStyle(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return ThemeData(
    scaffoldBackgroundColor: kScaffoldColor,
    textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kScaffoldColor,
      iconTheme: IconThemeData(
          size: size.width > 450 ? 13.sp : 20.sp, color: kMainColor),
      centerTitle: false,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: size.width > 450 ? 12.sp : 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
  );
}

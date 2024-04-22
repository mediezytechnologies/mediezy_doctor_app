import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

ThemeData appThemeStyle(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: kScaffoldColor,
     textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kScaffoldColor,
      iconTheme: IconThemeData(color: kMainColor),
      centerTitle: false,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black),
    ),
  );
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
          centerTitle: true,
        ),
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              const VerticalSpacingWidget(height: 10),
              Text(
                "Welcome to Mediezy technologies, where health meets technology to empower individuals on their wellness journey. We are a dedicated team of healthcare professionals, technologists, and enthusiasts united by a common goal: to revolutionize healthcare accessibility and empower users to take control of their well-being",
                style: TextStyle(fontSize: size.width > 450 ? 11.sp : 14.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}

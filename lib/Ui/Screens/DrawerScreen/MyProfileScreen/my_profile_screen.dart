import 'dart:io';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileEdit/profile_edit_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/edit_profile_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    super.key,
    required this.drFirstName,
    required this.drSecondName,
    required this.drImage,
    required this.email,
    required this.phNo,
    required this.about,
    required this.hospitalName,
    required this.clinicName,
    required this.specifications,
    required this.subSpecification,
  });

  final String drFirstName;
  final String drSecondName;
  final String drImage;
  final String email;
  final String phNo;
  final String about;
  final String hospitalName;
  final List<Clinics> clinicName;
  final List specifications;
  final List subSpecification;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
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
            title: const Text("My Profile"),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                  patientImage: widget.drImage,
                                  firstname: widget.drFirstName,
                                  lastnamae: widget.drSecondName,
                                  number: widget.phNo,
                                )));
                  },
                  child: Text(
                    "Edit profile",
                    style:
                        TextStyle(fontSize: size.width > 450 ? 10.sp : 14.sp),
                  ))
            ],
          ),
          bottomNavigationBar: Platform.isIOS
              ? SizedBox(
                  height: size.height * 0.038,
                  width: double.infinity,
                )
              : const SizedBox(),
          body: BlocListener<ProfileEditBloc, ProfileEditState>(
            listener: (context, state) {
              if (state is ProfileEditLoaded) {
                GeneralServices.instance
                    .showSuccessMessage(context, "Profile Update Successfull");
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => BottomNavigationControlWidget(
                              selectedIndex: 0,
                            )));
              }
              if (state is ProfileEditError) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please fill in the blanks");
              }
            },
            child: FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //! first section
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //! image
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadedScaleAnimation(
                                scaleDuration:
                                    const Duration(milliseconds: 400),
                                fadeDuration: const Duration(milliseconds: 400),
                                child: Image.network(
                                  widget.drImage,
                                  height: 100.h,
                                  width: 110.w,
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 30),
                              //! select image
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: SizedBox(
                                  height: size.height * .12,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr.${widget.drFirstName} ${widget.drSecondName}",
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
                                      Text(
                                        widget.email,
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
                                      Text(
                                        widget.phNo,
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      const VerticalSpacingWidget(height: 10),
                      //! about
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kCardColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VerticalSpacingWidget(height: 15),
                            Text(
                              "About",
                              style:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
                            ),
                            const VerticalSpacingWidget(height: 10),
                            Text(
                              widget.about,
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                            const VerticalSpacingWidget(height: 15)
                          ],
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! third section
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kCardColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! clinic
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kCardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const VerticalSpacingWidget(height: 15),
                                  Text(
                                    "Clinics",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  const VerticalSpacingWidget(height: 15),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.clinicName.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        widget.clinicName[index].clinicName
                                            .toString(),
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const VerticalSpacingWidget(height: 3),
                                  ),
                                  const VerticalSpacingWidget(height: 10),
                                ],
                              ),
                            ),
                            const VerticalSpacingWidget(height: 15)
                          ],
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      //! fourth section
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kCardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VerticalSpacingWidget(height: 15),
                            Text(
                              "Specifications",
                              style:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
                            ),
                            const VerticalSpacingWidget(height: 15),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.specifications.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  widget.specifications[index],
                                  style: size.width > 450
                                      ? blackTabMainText
                                      : blackMainText,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const VerticalSpacingWidget(height: 3),
                            ),
                            const VerticalSpacingWidget(height: 10),
                          ],
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VerticalSpacingWidget(height: 15),
                            //! specifications
                            Text(
                              "Sub specifications",
                              style:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
                            ),

                            const VerticalSpacingWidget(height: 15),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.subSpecification.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  widget.subSpecification[index],
                                  style: size.width > 450
                                      ? blackTabMainText
                                      : blackMainText,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const VerticalSpacingWidget(height: 3),
                            ),
                            const VerticalSpacingWidget(height: 10),
                          ],
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10)
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

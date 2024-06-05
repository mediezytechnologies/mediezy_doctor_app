import 'dart:io';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ContactUs/contact_us_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../CommonWidgets/text_style_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusController = FocusNode();

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
          title: const Text("Contact Us"),
          centerTitle: true,
        ),
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        body: BlocListener<ContactUsBloc, ContactUsState>(
          listener: (context, state) {
            if (state is ContactUsError) {
              GeneralServices.instance
                  .showErrorMessage(context, state.errorMessage);
            }
            if (state is ContactUsLoaded) {
              GeneralServices.instance
                  .showSuccessMessage(context, state.successMessage);
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const VerticalSpacingWidget(height: 10),
                    Text(
                      "How may we\nhelp you?",
                      style: TextStyle(
                          fontSize: size.width > 450 ? 18.sp : 28.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const VerticalSpacingWidget(height: 13),
                    Text(
                      "Let us know your queries & feedbacks",
                      style: size.width > 450 ? greyTabMain : greyMain,
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! email
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 450 ? 11.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: kMainColor,
                          size: size.width > 450 ? 13.sp : 20.sp,
                        ),
                        hintStyle:
                            size.width > 450 ? greyTab10B600 : grey13B600,
                        hintText: "philipeaugustine@gmail.com",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 15),
                    //! message
                    TextFormField(
                      maxLines: 4,
                      cursorColor: kMainColor,
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyLight.edit,
                          color: kMainColor,
                          size: size.width > 450 ? 13.sp : 20.sp,
                        ),
                        hintStyle:
                            size.width > 450 ? greyTab10B600 : grey13B600,
                        hintText: "Write your message",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! submit
                    CommonButtonWidget(
                        title: "Submit",
                        onTapFunction: () {
                          BlocProvider.of<ContactUsBloc>(context).add(
                              AddContactUs(
                                  email: emailController.text,
                                  description: messageController.text));
                        }),
                    const VerticalSpacingWidget(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FadedScaleAnimation(
                        scaleDuration: const Duration(milliseconds: 400),
                        fadeDuration: const Duration(milliseconds: 400),
                        child: Image.asset(
                          'assets/images/hero_image.png',
                          height: size.width > 450
                              ? size.height * .41
                              : size.height * .35,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    messageController.dispose();
    messageFocusController.dispose();
  }
}

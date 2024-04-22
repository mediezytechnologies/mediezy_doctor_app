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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        centerTitle: true,
      ),
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
          // TODO: implement listener
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
                    style:
                        TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacingWidget(height: 13),
                  Text(
                    "Let us know your queries & feedbacks",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 20),
                  //! email
                  TextFormField(
                    cursorColor: kMainColor,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: kMainColor,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15.sp, color: kSubTextColor),
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
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15.sp, color: kSubTextColor),
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
                      child: Image.asset('assets/images/hero_image.png'),
                    ),
                  )
                ],
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

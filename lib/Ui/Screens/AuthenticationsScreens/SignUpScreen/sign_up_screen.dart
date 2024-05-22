import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode lastNameFocusController = FocusNode();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode phoneNumberFocusController = FocusNode();
  final FocusNode passwordFocusController = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoaded) {
          Navigator.pushAndRemoveUntil(
              context,
              // MaterialPageRoute(builder: (context) => const LoginDemoScreen()),
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
        if (state is LoginError) {
          showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                color: Colors.black,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "This email is not available",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(IconlyLight.arrowLeft2),
          ),
          title: const Text("Register Now"),
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const VerticalSpacingWidget(height: 20),
                    //! heading
                    Text(
                      "You have not registered yet.\nLet us know basic details for registration",
                      style: TextStyle(
                          fontSize: 15,
                          color: kSubTextColor,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacingWidget(height: 50),
                    //! first name
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "first name is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyLight.profile,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter your First Name",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 15),
                    //! last name
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      focusNode: lastNameFocusController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "last name is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyBroken.profile,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter your Last Name",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 15),
                    //! email
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@gmail.com")) {
                          return "Email is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter your Email",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 15),
                    //! phone number
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      focusNode: phoneNumberFocusController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Phone number is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter your Phone number",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 15),
                    //! password
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Password is missing and must have 7 digits";
                        } else {
                          return null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(IconlyLight.password, color: kMainColor),
                        suffixIcon: hidePassword
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  IconlyLight.hide,
                                  color: kMainColor,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  IconlyLight.show,
                                  color: kMainColor,
                                ),
                              ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 50),
                    //! signup
                    CommonButtonWidget(
                        title: "Sign up",
                        onTapFunction: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(FetchSignup(
                                email: emailController.text,
                                password: passwordController.text,
                                firstname: firstNameController.text,
                                secondname: lastNameController.text,
                                mobileNo: phoneNumberController.text));
                          }
                        }),
                    const VerticalSpacingWidget(height: 20),
                    //! log in
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => const LoginDemoScreen(),
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: kMainColor),
                          ),
                        ),
                      ],
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    lastNameFocusController.dispose();
    emailFocusController.dispose();
    phoneNumberFocusController.dispose();
    passwordFocusController.dispose();
  }
}

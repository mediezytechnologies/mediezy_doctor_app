import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class DummyRegisterScreen extends StatefulWidget {
  const DummyRegisterScreen({super.key});

  @override
  State<DummyRegisterScreen> createState() => _DummyRegisterScreenState();
}

class _DummyRegisterScreenState extends State<DummyRegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final FocusNode lastNameFocusController = FocusNode();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode phoneNumberFocusController = FocusNode();
  final FocusNode dobFocusController = FocusNode();
  final FocusNode hospitalNameFocusController = FocusNode();
  final FocusNode specializationFocusController = FocusNode();
  final FocusNode locationFocusController = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is DummyRegisterLoaded) {
          GeneralServices.instance.showToastMessage(state.successMessage);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
        if (state is DummyRegisterError) {
          GeneralServices.instance.showToastMessage(state.errorMessage);
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
                      style: size.width > 400 ? greyTabMain : greyMain,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! first name
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 11.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is missing";
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
                            size.width > 400 ? greyTab10B600 : grey13B600,
                        hintText: "Enter your Name",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 7),
                    //! email
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 11.sp : 14.sp),
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
                            size.width > 400 ? greyTab10B600 : grey13B600,
                        hintText: "Enter your Email",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 7),
                    //! phone number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220.w,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: size.width > 400 ? 11.sp : 14.sp),
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
                                  size.width > 400 ? greyTab10B600 : grey13B600,
                              hintText: "Enter your Phone number",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            SelectDate(
                              context: context,
                              date: selectDate,
                              onDateSelected: (DateTime picked) {
                                setState(() {
                                  selectDate = picked;
                                });
                              },
                            );
                          },
                          child: Container(
                            width: 110.w,
                            height: 50.h,
                            color: kCardColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: size.width > 400 ? 12.sp : 20.sp,
                                ),
                                Text(
                                  DateFormat("dd-MM-yyy").format(selectDate),
                                  style: size.width > 400
                                      ? blackTabMainText
                                      : blackMainText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 7),
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 11.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: hospitalNameController,
                      keyboardType: TextInputType.text,
                      focusNode: hospitalNameFocusController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Hospital Name is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.local_hospital,
                          color: kMainColor,
                        ),
                        hintStyle:
                            size.width > 400 ? greyTab10B600 : grey13B600,
                        hintText: "Enter your Hospital Name",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 7),
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 11.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: specializationController,
                      keyboardType: TextInputType.text,
                      focusNode: specializationFocusController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Specialization is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.medical_services_outlined,
                          color: kMainColor,
                        ),
                        hintStyle:
                            size.width > 400 ? greyTab10B600 : grey13B600,
                        hintText: "Enter your Specialization",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 7),
                    TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 11.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: locationController,
                      keyboardType: TextInputType.text,
                      focusNode: locationFocusController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Location is missing";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: kMainColor,
                        ),
                        hintStyle:
                            size.width > 400 ? greyTab10B600 : grey13B600,
                        hintText: "Enter your Location",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! signup
                    CommonButtonWidget(
                        title: "Sign up",
                        onTapFunction: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context)
                                .add(DummyRegister(
                              email: emailController.text,
                              firstname: firstNameController.text,
                              mobileNo: phoneNumberController.text,
                              location: locationController.text,
                              hospitalName: hospitalNameController.text,
                              specialization: specializationController.text,
                              dob: DateFormat("yyy-MM-dd").format(selectDate),
                            ));
                          }
                        }),
                    const VerticalSpacingWidget(height: 20),
                    //! log in
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: size.width > 400 ? blackTab9B400 : black13B500,
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: size.width > 400
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor,
                                    fontSize: 11.sp)
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor,
                                    fontSize: 15.sp),
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

  Future<void> SelectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: ((context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
            ),
          ),
          child: child!,
        );
      }),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }
}

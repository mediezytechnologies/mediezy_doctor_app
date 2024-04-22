import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Data/app_data.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/SignUpScreen/dummy_register_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import '../../../../Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusController = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HospitalController controller = Get.put(HospitalController());
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoaded) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationControlWidget()),
              (route) => false);
          controller.gethospitalService().then((value) =>
              BlocProvider.of<GetAllAppointmentsBloc>(context)
                  .add(FetchAllAppointments(
                date: controller.formatDate(),
                clinicId: controller.initialIndex!,
                scheduleType: controller.scheduleIndex.value,
              )));

          // selectedValue.toString()

          // selectedValue.toString()

          BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
              .add(FetchAllCompletedAppointments(
            date: controller.formatDate(),
            clinicId: controller.initialIndex!,
            scheduleType: controller.scheduleIndex.value,
          ));
          //    Future.delayed(Duration(seconds: 2)).then((value) => controller.gethospitalService());
        }
        if (state is LoginError) {
          GeneralServices.instance
              .showToastMessage("Please Enter Correct details");
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: FadedSlideAnimation(
            beginOffset: const Offset(0, 0.3),
            endOffset: const Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 400.h,
                      child: Swiper(
                        autoplay: true,
                        itemCount: loginScreenImages.length,
                        itemBuilder: ((context, index) {
                          return Image.asset(
                            loginScreenImages[index],
                            fit: BoxFit.cover,
                          );
                        }),
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeColor: Colors.grey[200],
                              size: 8.sp,
                              activeSize: 8.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          const VerticalSpacingWidget(height: 400),
                          //! email
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains("@gmail.com")) {
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
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: "Enter your email",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! password
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            focusNode: passwordFocusController,
                            textInputAction: TextInputAction.done,
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Password is missing and must have 7 digits";
                              } else {
                                return null;
                              }
                            },
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
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          // const VerticalSpacingWidget(height: 10),
                          // //! forgetpassword
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               const ForgetPasswordScreen(),
                          //         ),
                          //       );
                          //     },
                          //     child: Text(
                          //       "Forget password",
                          //       style: TextStyle(
                          //           fontSize: 15.sp,
                          //           fontWeight: FontWeight.bold,
                          //           color: kMainColor),
                          //     ),
                          //   ),
                          // ),
                          const VerticalSpacingWidget(height: 30),
                          //! login
                          CommonButtonWidget(
                              title: "Login",
                              onTapFunction: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      FetchLogin(
                                          email: emailController.text,
                                          password: passwordController.text));
                                }
                              }),
                          const VerticalSpacingWidget(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const DummyRegisterScreen()));
                                  },
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kMainColor,
                                        fontSize: 15.sp),
                                  )),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 10),
                        ],
                      ),
                    ),
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
    passwordController.dispose();
  }
}

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Data/app_data.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/SignUpScreen/dummy_register_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/SignUpScreen/guest_register.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../CommonWidgets/text_style_widget.dart';

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
    final size = MediaQuery.of(context).size;
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
                      width: double.infinity,
                      height: size.width > 400
                          ? size.height * .64
                          : size.height * .59,
                      child: Swiper(
                        autoplay: true,
                        itemCount: loginScreenImages.length,
                        itemBuilder: ((context, index) {
                          return Image.asset(
                            loginScreenImages[index],
                            fit: size.width > 400 ? BoxFit.fill : BoxFit.cover,
                          );
                        }),
                        pagination: SwiperPagination(
                          margin: EdgeInsets.only(bottom: 10.h),
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: Colors.grey[200],
                            size: size.width > 400 ? 6.sp : 8.sp,
                            activeSize: size.width > 400 ? 6.sp : 8.sp,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          VerticalSpacingWidget(
                              height: size.width > 400
                                  ? size.height * .357
                                  : size.height * .455),
                          //! email
                          TextFormField(
                            style: TextStyle(
                                fontSize: size.width > 400 ? 11.sp : 14.sp),
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
                                size: size.width > 400 ? 12.sp : 20.sp,
                              ),
                              hintStyle:
                                  size.width > 400 ? greyTab10B600 : grey13B600,
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
                            style: TextStyle(
                                fontSize: size.width > 400 ? 11.sp : 14.sp),
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
                              prefixIcon: Icon(
                                IconlyLight.password,
                                color: kMainColor,
                                size: size.width > 400 ? 12.sp : 20.sp,
                              ),
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
                                        size: size.width > 400 ? 12.sp : 20.sp,
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
                                        size: size.width > 400 ? 12.sp : 20.sp,
                                      ),
                                    ),
                              hintStyle:
                                  size.width > 400 ? greyTab10B600 : grey13B600,
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
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
                              Text(
                                "Don't have an account? ",
                                style: size.width > 400
                                    ? blackTab9B400
                                    : black13B500,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const GuestRegisterScreen()));
                                },
                                child: Text(
                                  "Signup",
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

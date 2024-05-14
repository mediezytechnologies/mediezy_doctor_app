// import 'package:animation_wrappers/animations/faded_slide_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
// import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
// import 'package:mediezy_doctor/Ui/Services/general_services.dart';

// class GuestRegisterScreen extends StatefulWidget {
//   const GuestRegisterScreen({super.key});

//   @override
//   State<GuestRegisterScreen> createState() => GuestRegisterScreenState();
// }

// class GuestRegisterScreenState extends State<GuestRegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final FocusNode lastNameFocusController = FocusNode();
//   final FocusNode emailFocusController = FocusNode();
//   final FocusNode phoneNumberFocusController = FocusNode();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   DateTime selectDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state is DummyRegisterLoaded) {
//           GeneralServices.instance.showToastMessage(state.successMessage);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const BottomNavigationControlWidget()),
//               (route) => false);
//         }
//         if (state is DummyRegisterError) {
//           GeneralServices.instance.showToastMessage(state.errorMessage);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(IconlyLight.arrowLeft2),
//           ),
//           title: const Text("Register Now"),
//           centerTitle: true,
//         ),
//         body: FadedSlideAnimation(
//           beginOffset: const Offset(0, 0.3),
//           endOffset: const Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     const VerticalSpacingWidget(height: 20),
//                     //! heading
//                     Text(
//                       "You have not registered yet.\nLet us know basic details for registration",
//                       style: size.width > 450 ? greyTabMain : greyMain,
//                       textAlign: TextAlign.center,
//                     ),
//                     const VerticalSpacingWidget(height: 50),
//                     //! first name
//                     TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 11.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       controller: nameController,
//                       keyboardType: TextInputType.name,
//                       textInputAction: TextInputAction.next,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Name is missing";
//                         } else {
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           IconlyLight.profile,
//                           color: kMainColor,
//                         ),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Enter your Name",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const VerticalSpacingWidget(height: 20),
//                     //! email
//                     TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 11.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       focusNode: emailFocusController,
//                       textInputAction: TextInputAction.next,
//                       validator: (value) {
//                         if (value!.isEmpty || !value.contains("@gmail.com")) {
//                           return "Email is missing";
//                         } else {
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.email_outlined,
//                           color: kMainColor,
//                         ),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Enter your Email",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const VerticalSpacingWidget(height: 20),
//                     //! phone number
//                     TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 11.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       maxLength: 10,
//                       controller: phoneNumberController,
//                       keyboardType: TextInputType.phone,
//                       focusNode: phoneNumberFocusController,
//                       textInputAction: TextInputAction.next,
//                       validator: (value) {
//                         if (value!.isEmpty || value.length < 10) {
//                           return "Phone number is missing";
//                         } else {
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         counterText: "",
//                         prefixIcon: Icon(
//                           Icons.phone_iphone,
//                           color: kMainColor,
//                         ),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Enter your Phone number",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     const VerticalSpacingWidget(height: 200),
//                     //! signup
//                     CommonButtonWidget(
//                       title: "Sign up",
//                       onTapFunction: () {
//                         if (_formKey.currentState!.validate()) {
//                           BlocProvider.of<LoginBloc>(context).add(GuestRegister(
//                               email: emailController.text,
//                               name: nameController.text,
//                               mobileNo: phoneNumberController.text));
//                         }
//                       },
//                     ),
//                     const VerticalSpacingWidget(height: 20),
//                     //! log in
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already have an account?",
//                           style: size.width > 450 ? blackTab9B400 : black13B500,
//                         ),
//                         const HorizontalSpacingWidget(width: 5),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const LoginScreen(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             "Login",
//                             style: size.width > 450
//                                 ? TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: kMainColor,
//                                     fontSize: 11.sp)
//                                 : TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: kMainColor,
//                                     fontSize: 15.sp),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

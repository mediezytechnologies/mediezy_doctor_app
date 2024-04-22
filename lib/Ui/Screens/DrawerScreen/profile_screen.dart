// import 'package:animation_wrappers/animations/faded_scale_animation.dart';
// import 'package:animation_wrappers/animations/faded_slide_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
// import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
// import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/ContactUsScreen/contact_us_screen.dart';
// import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/Labs/lab_screen.dart';
// import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/my_profile_screen.dart';
// import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/T&CScreen/t&c_screen.dart';
// import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/Widgets/profile_card_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProfileTile {
//   String? title;
//   String? subtitle;
//   IconData iconData;
//   Function onTap;
//
//   ProfileTile(this.title, this.subtitle, this.iconData, this.onTap);
// }
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({
//     super.key,
//   });
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? doctorFirstName;
//   String? doctorLastName;
//   @override
//   void initState() {
//     BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());
//     getUserName();
//     super.initState();
//   }
//
//   late ProfileGetModel profileGetModel;
//
//   Future<void> getUserName() async {
//     final preferences = await SharedPreferences.getInstance();
//     setState(() {
//       doctorFirstName = preferences.getString('doctorFirstName');
//       doctorLastName = preferences.getString('doctorLastName');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (ctx) => const BottomNavigationControlWidget()));
//         return Future.value(false);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Profile"),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 final preferences = await SharedPreferences.getInstance();
//                 await preferences.remove('token');
//                 await preferences.remove('doctorName');
//                 // ignore: use_build_context_synchronously
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const LoginScreen(),
//                   ),
//                 );
//               },
//               icon: const Icon(IconlyLight.logout),
//             )
//           ],
//         ),
//         body: BlocBuilder<ProfileGetBloc, ProfileGetState>(
//           builder: (context, state) {
//             if (state is ProfileGetLoaded) {
//               profileGetModel =
//                   BlocProvider.of<ProfileGetBloc>(context).profileGetModel;
//               return FadedSlideAnimation(
//                 beginOffset: const Offset(0, 0.3),
//                 endOffset: const Offset(0, 0),
//                 slideCurve: Curves.linearToEaseOut,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                     child: Column(
//                       children: [
//                         //! first section
//                         Container(
//                           decoration: BoxDecoration(
//                               color: kCardColor,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             //! image and name details
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 FadedScaleAnimation(
//                                   scaleDuration:
//                                       const Duration(milliseconds: 400),
//                                   fadeDuration:
//                                       const Duration(milliseconds: 400),
//                                   child: Image.network(
//                                     profileGetModel.doctorDetails!.first.docterImage
//                                         .toString(),
//                                     height: 100.h,
//                                     width: 110.w,
//                                   ),
//                                 ),
//                                 const HorizontalSpacingWidget(width: 30),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Text(
//                                       "Dr. ${profileGetModel.doctorDetails!.first.firstname.toString()}\n${profileGetModel.doctorDetails!.first.secondname.toString()}",
//                                       style: TextStyle(
//                                           fontSize: 20.sp,
//                                           fontWeight: FontWeight.bold,
//                                           color: kTextColor),
//                                     ),
//                                     const VerticalSpacingWidget(height: 10),
//                                     Text(
//                                       profileGetModel.doctorDetails!.first.mediezyDoctorId.toString(),
//                                        style: TextStyle(
//                                           fontSize: 20.sp,
//                                           fontWeight: FontWeight.bold,
//                                           color: kTextColor),
//                                     ),
//                                     const VerticalSpacingWidget(height: 10),
//                                     Text(
//                                       "+91 ${profileGetModel.doctorDetails!.first.mobileNumber.toString()}",
//                                       style: TextStyle(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w600,
//                                           color: kSubTextColor),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const VerticalSpacingWidget(height: 10),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ProfileCardWidget(
//                                 title: "My Profile",
//                                 subTitle: "Edit your profile",
//                                 icon: Icons.edit,
//                                 onTapFunction: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (ctx) => MyProfileScreen(
//                                         drFirstName: profileGetModel
//                                             .doctorDetails!.first.firstname
//                                             .toString(),
//                                         drSecondName: profileGetModel
//                                             .doctorDetails!.first.secondname
//                                             .toString(),
//                                         email: profileGetModel
//                                             .doctorDetails!.first.emailID
//                                             .toString(),
//                                         phNo: profileGetModel
//                                             .doctorDetails!.first.mobileNumber
//                                             .toString(),
//                                         about: profileGetModel
//                                             .doctorDetails!.first.about
//                                             .toString(),
//                                         hospitalName: profileGetModel
//                                             .doctorDetails!.first.mainHospital
//                                             .toString(),
//                                         clinicName: profileGetModel
//                                             .doctorDetails!.first.clinics!
//                                             .toList(),
//                                         specifications: profileGetModel
//                                             .doctorDetails!.first.specifications!
//                                             .toList(),
//                                         subSpecification: profileGetModel
//                                             .doctorDetails!.first.subspecifications!
//                                             .toList(),
//                                         drImage: profileGetModel
//                                             .doctorDetails!.first.docterImage
//                                             .toString(),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             const HorizontalSpacingWidget(width: 5),
//                             Expanded(
//                               child: ProfileCardWidget(
//                                   title: "T&C",
//                                   subTitle: "Policies",
//                                   icon: Icons.assignment_outlined,
//                                   onTapFunction: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             const TermsandConditionsScreen(),
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           ],
//                         ),
//                         const VerticalSpacingWidget(height: 10),
//                         Row(
//                           children: [
//                             Align(
//                               alignment: Alignment.bottomLeft,
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width * .47,
//                                 child: ProfileCardWidget(
//                                     title: "Contact Us",
//                                     subTitle: "Let us help you ",
//                                     icon: Icons.mail_outline_outlined,
//                                     onTapFunction: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               const ContactUsScreen(),
//                                         ),
//                                       );
//                                     }),
//                               ),
//                             ),
//                             const HorizontalSpacingWidget(width: 5),
//                             Expanded(
//                               child: ProfileCardWidget(
//                                   title: "Labs",
//                                   subTitle: "Policies",
//                                   icon: Icons.local_hospital,
//                                   onTapFunction: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const LabScreen(),
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           ],
//                         ),
//                         const VerticalSpacingWidget(height: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

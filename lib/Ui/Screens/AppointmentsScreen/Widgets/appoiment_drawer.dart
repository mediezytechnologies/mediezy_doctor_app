import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/AboutUsScreen/about_us_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/ContactUsScreen/contact_us_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/Labs/lab_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MedicalShoppe/medical_shoppe_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/my_profile_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/PreviousBookingScreen/previous_booking_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/SuggestionScreen/suggestion_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/T&CScreen/t&c_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/privacy_policy/privacy_policy.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/suggest_doctor/suggest_doctor_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Model/Profile/ProfileGetModel.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
   CustomDrawer({super.key});

 late ProfileGetModel profileGetModel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              BlocBuilder<ProfileGetBloc, ProfileGetState>(
                builder: (context, state) {
                  if (state is ProfileGetLoaded) {
                    profileGetModel = BlocProvider.of<ProfileGetBloc>(context)
                        .profileGetModel;
                    return DrawerHeader(
                      decoration: BoxDecoration(color: kMainColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: PatientImageWidget(
                                patientImage: profileGetModel
                                            .doctorDetails!.first.docterImage ==
                                        null
                                    ? ""
                                    : profileGetModel
                                        .doctorDetails!.first.docterImage
                                        .toString(),
                                radius: 20),
                          ),
                          Text(
                            "Dr.${profileGetModel.doctorDetails!.first.firstname.toString()} ${profileGetModel.doctorDetails!.first.secondname.toString()}",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            profileGetModel.doctorDetails!.first.mediezyDoctorId
                                .toString(),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          Text(
                            "+91 ${profileGetModel.doctorDetails!.first.mobileNumber.toString()}",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              ListTile(
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => MyProfileScreen(
                                drFirstName: profileGetModel
                                    .doctorDetails!.first.firstname
                                    .toString(),
                                drSecondName: profileGetModel
                                    .doctorDetails!.first.secondname
                                    .toString(),
                                email: profileGetModel
                                    .doctorDetails!.first.emailID
                                    .toString(),
                                phNo: profileGetModel
                                    .doctorDetails!.first.mobileNumber
                                    .toString(),
                                about: profileGetModel
                                    .doctorDetails!.first.about
                                    .toString(),
                                hospitalName: profileGetModel
                                    .doctorDetails!.first.mainHospital
                                    .toString(),
                                clinicName: profileGetModel
                                    .doctorDetails!.first.clinics!
                                    .toList(),
                                specifications: profileGetModel
                                    .doctorDetails!.first.specifications!
                                    .toList(),
                                subSpecification: profileGetModel
                                    .doctorDetails!.first.subspecifications!
                                    .toList(),
                                drImage: profileGetModel
                                    .doctorDetails!.first.docterImage
                                    .toString(),
                              ))); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Labs'),
                trailing: const Icon(Icons.science),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LabScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Medical Store'),
                trailing: const Icon(Icons.medical_services_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicalShoppeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Previous Bookings'),
                trailing: const Icon(Icons.book_online_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreviousBookingScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Suggest doctor'),
                trailing: Image(
                    height: 20.h,
                    image: const AssetImage("assets/icons/doctor_icon.png")),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuggestDoctorScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Feedback'),
                trailing: const Icon(Icons.edit_note_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuggestionScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Terms & Conditions'),
                trailing: const Icon(Icons.assignment_outlined),
                onTap: () {
                  // Handle item 2 tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsandConditionsScreen(),
                    ),
                  );
                },
              ),
                  ListTile(
                title: const Text('Privacy policy'),
                trailing: const Icon(Icons.assignment_outlined),
                onTap: () {
                  // Handle item 2 tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('About Us'),
                trailing: const Icon(Icons.assignment_turned_in_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Contact Us'),
                trailing: const Icon(Icons.mail_outline_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Log out'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  GeneralServices.instance.appCloseDialogue(
                      context, "Are you sure to log out", () async {
                    final preferences = await SharedPreferences.getInstance();
                    await preferences.remove('token');
                    await preferences.remove('doctorName');
                    await preferences.remove('DoctorId');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  });
                },
              ),
            ],
          ),
        );
  }
}
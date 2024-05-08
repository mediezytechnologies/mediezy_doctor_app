import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileEdit/profile_edit_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController workAtHospitalController =
      TextEditingController();
  final TextEditingController workAtClinicController = TextEditingController();
  final FocusNode lastNameFocusController = FocusNode();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode phoneNumberFocusController = FocusNode();
  final FocusNode aboutFocusController = FocusNode();
  final FocusNode workAtHospitalFocusController = FocusNode();
  final FocusNode workAtClinicFocusController = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
          child: CommonButtonWidget(
              title: "Update",
              onTapFunction: () {
                // print(">>>>>>>>>>>>>${lastNameController.text}");
                BlocProvider.of<ProfileEditBloc>(context).add(FetchProfileEdit(
                    firstname: firstNameController.text,
                    secondname: lastNameController.text,
                    mobileNo: phoneNumberController.text));
              }),
        ),
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
                      builder: (ctx) =>  const BottomNavigationControlWidget()));
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! first section
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: kCardColor,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     //! image
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         FadedScaleAnimation(
                    //           scaleDuration: const Duration(milliseconds: 400),
                    //           fadeDuration: const Duration(milliseconds: 400),
                    //           child: Image.network(
                    //             widget.drImage,
                    //             height: 100.h,
                    //             width: 110.w,
                    //           ),
                    //         ),
                    //         const HorizontalSpacingWidget(width: 30),
                    //         //! select image
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const VerticalSpacingWidget(height: 30),
                    //             IconButton(
                    //               onPressed: () {},
                    //               icon: Icon(
                    //                 Icons.camera_alt_outlined,
                    //                 color: kMainColor,
                    //                 size: 20.sp,
                    //               ),
                    //             ),
                    //             Text(
                    //               "Change Profile Picture",
                    //               style: TextStyle(
                    //                   fontSize: 15.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: kMainColor),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                   // const VerticalSpacingWidget(height: 10),
                    //! second section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const VerticalSpacingWidget(height: 15),
                          //! first name
                          TextFormField(
                            cursorColor: kMainColor,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                IconlyLight.profile,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.drFirstName,
                              filled: true,
                              fillColor: kScaffoldColor,
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                IconlyBroken.profile,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.drSecondName,
                              filled: true,
                              fillColor: kScaffoldColor,
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
                            decoration: InputDecoration(
                              enabled: false,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.email,
                              filled: true,
                              fillColor: kScaffoldColor,
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone_iphone,
                                color: kMainColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                              hintText: widget.phNo,
                              filled: true,
                              fillColor: kScaffoldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 15),
                        ],
                      ),
                    ),
                    // const VerticalSpacingWidget(height: 10),
                    // //! third section
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: kCardColor),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const VerticalSpacingWidget(height: 15),
                    //       Text(
                    //         "About",
                    //         style: TextStyle(
                    //             fontSize: 18.sp,
                    //             fontWeight: FontWeight.w500,
                    //             color: kSubTextColor),
                    //       ),
                    //       const VerticalSpacingWidget(height: 10),
                    //       //! about
                    //       TextFormField(
                    //         cursorColor: kMainColor,
                    //         controller: aboutController,
                    //         keyboardType: TextInputType.text,
                    //         focusNode: aboutFocusController,
                    //         textInputAction: TextInputAction.next,
                    //         maxLines: 3,
                    //         decoration: InputDecoration(
                    //           enabled: false,
                    //           prefixIcon: Icon(
                    //             Icons.description_outlined,
                    //             color: kMainColor,
                    //           ),
                    //           hintStyle: TextStyle(
                    //               fontSize: 15.sp, color: kSubTextColor),
                    //           filled: true,
                    //           fillColor: kScaffoldColor,
                    //           hintText: widget.about,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15)
                    //     ],
                    //   ),
                    // ),
                    // const VerticalSpacingWidget(height: 10),
                    //! third section
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: kCardColor),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const VerticalSpacingWidget(height: 15),
                    //       Text(
                    //         "Works At",
                    //         style: TextStyle(
                    //             fontSize: 18.sp,
                    //             fontWeight: FontWeight.w500,
                    //             color: kSubTextColor),
                    //       ),
                    //       const VerticalSpacingWidget(height: 10),
                    //       //! hospital
                    //       TextFormField(
                    //         cursorColor: kMainColor,
                    //         controller: workAtHospitalController,
                    //         keyboardType: TextInputType.text,
                    //         focusNode: workAtHospitalFocusController,
                    //         textInputAction: TextInputAction.next,
                    //         decoration: InputDecoration(
                    //           enabled: false,
                    //           prefixIcon: Icon(
                    //             Icons.local_hospital_outlined,
                    //             color: kMainColor,
                    //           ),
                    //           hintStyle: TextStyle(
                    //               fontSize: 15.sp, color: kSubTextColor),
                    //           filled: true,
                    //           fillColor: kScaffoldColor,
                    //           hintText: widget.hospitalName,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15),
                    //       //! clinic
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         width: double.infinity,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: kCardColor,
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const VerticalSpacingWidget(height: 15),
                    //             Text(
                    //               "Clinics",
                    //               style: TextStyle(
                    //                   fontSize: 14.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: kSubTextColor),
                    //             ),
                    //             const VerticalSpacingWidget(height: 15),
                    //             ListView.separated(
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               shrinkWrap: true,
                    //               itemCount: widget.clinicName.length,
                    //               itemBuilder: (context, index) {
                    //                 return Text(
                    //                   widget.clinicName[index].clinicName
                    //                       .toString(),
                    //                   style: TextStyle(
                    //                       fontSize: 15.sp,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: kTextColor),
                    //                 );
                    //               },
                    //               separatorBuilder: (context, index) =>
                    //                   const VerticalSpacingWidget(height: 3),
                    //             ),
                    //             const VerticalSpacingWidget(height: 10),
                    //           ],
                    //         ),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15)
                    //     ],
                    //   ),
                    // ),
                    // const VerticalSpacingWidget(height: 10),
                    //! fourth section
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: kCardColor,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const VerticalSpacingWidget(height: 15),
                    //       Text(
                    //         "Specifications",
                    //         style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.w600,
                    //             color: kSubTextColor),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15),
                    //       ListView.separated(
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: widget.specifications.length,
                    //         itemBuilder: (context, index) {
                    //           return Text(
                    //             widget.specifications[index],
                    //             style: TextStyle(
                    //                 fontSize: 15.sp,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: kTextColor),
                    //           );
                    //         },
                    //         separatorBuilder: (context, index) =>
                    //             const VerticalSpacingWidget(height: 3),
                    //       ),
                    //       const VerticalSpacingWidget(height: 10),
                    //     ],
                    //   ),
                    // ),
                    // const VerticalSpacingWidget(height: 10),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       color: kCardColor,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const VerticalSpacingWidget(height: 15),
                    //       //! specifications
                    //       Text(
                    //         "Sub specifications",
                    //         style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.w600,
                    //             color: kSubTextColor),
                    //       ),

                    //       const VerticalSpacingWidget(height: 15),
                    //       ListView.separated(
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: widget.subSpecification.length,
                    //         itemBuilder: (context, index) {
                    //           return Text(
                    //             widget.subSpecification[index],
                    //             style: TextStyle(
                    //                 fontSize: 15.sp,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: kTextColor),
                    //           );
                    //         },
                    //         separatorBuilder: (context, index) =>
                    //             const VerticalSpacingWidget(height: 3),
                    //       ),
                    //       const VerticalSpacingWidget(height: 10),
                    //     ],
                    //   ),
                    // ),
                    // const VerticalSpacingWidget(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    aboutController.dispose();
    emailController.dispose();
    workAtHospitalController.dispose();
    workAtClinicController.dispose();
    lastNameFocusController.dispose();
    emailFocusController.dispose();
    phoneNumberFocusController.dispose();
    aboutFocusController.dispose();
    workAtHospitalFocusController.dispose();
    workAtClinicFocusController.dispose();
  }

  showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16.sp);
  }
}

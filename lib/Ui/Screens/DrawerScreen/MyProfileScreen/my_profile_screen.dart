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
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/edit_profile_screen.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()));
                },
                child: Text(
                  "Edit profile",
                  style: TextStyle(fontSize: size.width > 400 ? 10.sp : 14.sp),
                ))
          ],
        ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        //   child: CommonButtonWidget(
        //       title: "Update",
        //       onTapFunction: () {
        //         // print(">>>>>>>>>>>>>${lastNameController.text}");
        //         BlocProvider.of<ProfileEditBloc>(context).add(FetchProfileEdit(
        //             firstname: firstNameController.text,
        //             secondname: lastNameController.text,
        //             mobileNo: phoneNumberController.text));
        //       }),
        // ),
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
                      builder: (ctx) => const BottomNavigationControlWidget()));
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Container(
                    //   height: size.height * .05,
                    //   width:
                    //       size.width > 400 ? size.width * .2 : size.width * .3,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: kMainColor),
                    //   child: Center(
                    //     child: Text("Edit",
                    //         style: size.width > 400 ? white9Bold : white12Bold),
                    //   ),
                    // ),
                    //! first section
                    Container(
                      decoration: BoxDecoration(
                          // color: kCardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        //! image
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadedScaleAnimation(
                              scaleDuration: const Duration(milliseconds: 400),
                              fadeDuration: const Duration(milliseconds: 400),
                              child: Image.network(
                                widget.drImage,
                                height: 100.h,
                                width: 110.w,
                              ),
                            ),
                            const HorizontalSpacingWidget(width: 30),
                            //! select image
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Container(
                                height: size.height * .12,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dr.${widget.drFirstName} ${widget.drSecondName}",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                    Text(
                                      widget.email,
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                    Text(
                                      widget.phNo,
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    //! second section
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   decoration: BoxDecoration(
                    //       color: kCardColor,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Column(
                    //     children: [
                    //       const VerticalSpacingWidget(height: 15),
                    //       //! first name
                    //       TextFormField(
                    //         style: TextStyle(
                    //             fontSize: size.width > 400 ? 12.sp : 14.sp),
                    //         cursorColor: kMainColor,
                    //         controller: firstNameController,
                    //         keyboardType: TextInputType.name,
                    //         textInputAction: TextInputAction.next,
                    //         decoration: InputDecoration(
                    //           prefixIcon: Icon(
                    //             IconlyLight.profile,
                    //             color: kMainColor,
                    //             size: size.width > 400 ? 12.sp : 19.sp,
                    //           ),
                    //           hintStyle:
                    //               size.width > 400 ? greyTab10B600 : grey13B600,
                    //           hintText: widget.drFirstName,
                    //           filled: true,
                    //           fillColor: kScaffoldColor,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //       // //! last name
                    //       // TextFormField(
                    //       //   style: TextStyle(
                    //       //       fontSize: size.width > 400 ? 12.sp : 14.sp),
                    //       //   cursorColor: kMainColor,
                    //       //   controller: lastNameController,
                    //       //   keyboardType: TextInputType.name,
                    //       //   textInputAction: TextInputAction.next,
                    //       //   focusNode: lastNameFocusController,
                    //       //   decoration: InputDecoration(
                    //       //     prefixIcon: Icon(
                    //       //       IconlyBroken.profile,
                    //       //       color: kMainColor,
                    //       //       size: size.width > 400 ? 12.sp : 19.sp,
                    //       //     ),
                    //       //     hintStyle:
                    //       //         size.width > 400 ? greyTab10B600 : grey13B600,
                    //       //     hintText: widget.drSecondName,
                    //       //     filled: true,
                    //       //     fillColor: kScaffoldColor,
                    //       //     border: OutlineInputBorder(
                    //       //       borderRadius: BorderRadius.circular(4),
                    //       //       borderSide: BorderSide.none,
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //       const VerticalSpacingWidget(height: 15),
                    //       //! email
                    //       TextFormField(
                    //         style: TextStyle(
                    //             fontSize: size.width > 400 ? 12.sp : 14.sp),
                    //         cursorColor: kMainColor,
                    //         controller: emailController,
                    //         keyboardType: TextInputType.emailAddress,
                    //         focusNode: emailFocusController,
                    //         textInputAction: TextInputAction.next,
                    //         decoration: InputDecoration(
                    //           enabled: false,
                    //           prefixIcon: Icon(
                    //             Icons.email_outlined,
                    //             color: kMainColor,
                    //             size: size.width > 400 ? 12.sp : 19.sp,
                    //           ),
                    //           hintStyle:
                    //               size.width > 400 ? greyTab10B600 : grey13B600,
                    //           hintText: widget.email,
                    //           filled: true,
                    //           fillColor: kScaffoldColor,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15),
                    //       //! phone number
                    //       TextFormField(
                    //         style: TextStyle(
                    //             fontSize: size.width > 400 ? 12.sp : 14.sp),
                    //         cursorColor: kMainColor,
                    //         controller: phoneNumberController,
                    //         keyboardType: TextInputType.phone,
                    //         focusNode: phoneNumberFocusController,
                    //         textInputAction: TextInputAction.next,
                    //         decoration: InputDecoration(
                    //           prefixIcon: Icon(
                    //             Icons.phone_iphone,
                    //             color: kMainColor,
                    //             size: size.width > 400 ? 12.sp : 19.sp,
                    //           ),
                    //           hintStyle:
                    //               size.width > 400 ? greyTab10B600 : grey13B600,
                    //           hintText: widget.phNo,
                    //           filled: true,
                    //           fillColor: kScaffoldColor,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //       const VerticalSpacingWidget(height: 15),
                    //     ],
                    //   ),
                    // ),
                    const VerticalSpacingWidget(height: 10),
                    //! about
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kCardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpacingWidget(height: 15),
                          Text(
                            "About",
                            style:
                                size.width > 400 ? greyTab10B600 : grey13B600,
                          ),
                          const VerticalSpacingWidget(height: 10),
                          Text(
                            widget.about,
                            style: size.width > 400
                                ? blackTabMainText
                                : blackMainText,
                          ),
                          const VerticalSpacingWidget(height: 15)
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    //! third section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kCardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! clinic
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kCardColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpacingWidget(height: 15),
                                Text(
                                  "Clinics",
                                  style: size.width > 400
                                      ? greyTab10B600
                                      : grey13B600,
                                ),
                                const VerticalSpacingWidget(height: 15),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.clinicName.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      widget.clinicName[index].clinicName
                                          .toString(),
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const VerticalSpacingWidget(height: 3),
                                ),
                                const VerticalSpacingWidget(height: 10),
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 15)
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    //! fourth section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kCardColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpacingWidget(height: 15),
                          Text(
                            "Specifications",
                            style:
                                size.width > 400 ? greyTab10B600 : grey13B600,
                          ),
                          const VerticalSpacingWidget(height: 15),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.specifications.length,
                            itemBuilder: (context, index) {
                              return Text(
                                widget.specifications[index],
                                style: size.width > 400
                                    ? blackTabMainText
                                    : blackMainText,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const VerticalSpacingWidget(height: 3),
                          ),
                          const VerticalSpacingWidget(height: 10),
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpacingWidget(height: 15),
                          //! specifications
                          Text(
                            "Sub specifications",
                            style:
                                size.width > 400 ? greyTab10B600 : grey13B600,
                          ),

                          const VerticalSpacingWidget(height: 15),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.subSpecification.length,
                            itemBuilder: (context, index) {
                              return Text(
                                widget.subSpecification[index],
                                style: size.width > 400
                                    ? blackTabMainText
                                    : blackMainText,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const VerticalSpacingWidget(height: 3),
                          ),
                          const VerticalSpacingWidget(height: 10),
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(height: 10)
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

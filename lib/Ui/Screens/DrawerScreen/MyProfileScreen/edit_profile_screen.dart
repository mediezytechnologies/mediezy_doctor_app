// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/widgets/custom_teextform.dart';

import '../../../CommonWidgets/common_button_widget.dart';
import '../../../CommonWidgets/vertical_spacing_widget.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({
    Key? key,
    required this.patientImage,
    required this.firstname,
    required this.lastnamae,
    required this.number,
  }) : super(key: key);
  final String patientImage;
  final String firstname;
  final String lastnamae;
  final  String number;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode emailFocusController = FocusNode();
  final FocusNode lastNameFocusController = FocusNode();
  final FocusNode phoneNumberFocusController = FocusNode();
  @override
  void initState() {
   
firstNameController.text =widget.firstname;
lastNameController.text =widget.lastnamae;
phoneNumberController.text= widget.number;


    super.initState();
  }

  String? imagePath;
  final ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.02),
        child: CommonButtonWidget(
            title: "Update",
            onTapFunction: () {
              final isValidate = _formKey.currentState!.validate();
              if (isValidate) {}
            }),
      ),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalSpacingWidget(height: 45),
                editImage(size),
                const VerticalSpacingWidget(height: 35),
                CustomFomField(
                  titles: "First Name",
                  textinputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "first name is missing";
                    } else {
                      return null;
                    }
                  },
                  controller: firstNameController,
                  prefixIcon: IconlyLight.profile,
                ),
                const VerticalSpacingWidget(height: 15),
                CustomFomField(
                  focusNode: lastNameFocusController,
                  titles: "Last Name",
                  textinputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "last name is missing";
                    } else {
                      return null;
                    }
                  },
                  controller: lastNameController,
                  prefixIcon: IconlyLight.profile,
                ),
                const VerticalSpacingWidget(height: 15),
                CustomFomField(
                    titles: "Phone number",
                    focusNode: phoneNumberFocusController,
                    textinputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return "Phone number is missing";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneNumberController,
                    prefixIcon: Icons.phone_iphone),
                const VerticalSpacingWidget(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack editImage(Size size) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: size.height * 0.16,
            width: size.width * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70.r),
            ),
            child: FadedScaleAnimation(
              scaleDuration: const Duration(milliseconds: 400),
              fadeDuration: const Duration(milliseconds: 400),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70.r),
                child: imagePath != null
                    ? Image.file(
                        File(imagePath!),
                        height: 80.h,
                        width: 80.w,
                        fit: BoxFit.cover,
                      )
                    : (widget.patientImage == ""
                        ? Image.asset(
                            "assets/icons/profile pic.png",
                            height: 80.h,
                            width: 80.w,
                            color: kMainColor,
                          )
                        : Image.network(
                            widget.patientImage,
                            height: 80.h,
                            width: 80.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                "assets/icons/profile pic.png",
                                height: 80.h,
                                width: 80.w,
                                color: kMainColor,
                              ),
                            ),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(80.r),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.h,
          right: size.width * 0.26,
          child: IconButton(
            onPressed: () {
              placePicImage();
            },
            icon: Icon(
              Icons.add_a_photo,
              size: 26.sp,
              weight: 5,
              color: kMainColor,
            ),
          ),
        ),
      ],
    );
  }

  Future placePicImage() async {
    var image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (image == null) return;
    final imageTemporary = image.path;
    setState(() {
      imagePath = imageTemporary;
      print("$imageTemporary======= image");
    });
  }
}

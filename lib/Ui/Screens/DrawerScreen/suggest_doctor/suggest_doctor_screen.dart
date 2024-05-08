import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/suggest_doctor/suggest_doctor_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../CommonWidgets/text_style_widget.dart';

class SuggestDoctorScreen extends StatefulWidget {
  const SuggestDoctorScreen({super.key});

  @override
  State<SuggestDoctorScreen> createState() => _SuggestDoctorScreenState();
}

class _SuggestDoctorScreenState extends State<SuggestDoctorScreen> {
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommend Doctor"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: CommonButtonWidget(
            title: "Done",
            onTapFunction: () {
              if (doctorNameController.text.isEmpty) {
                GeneralServices.instance
                    .showErrorMessage(context, "Fill doctor name");
              } else if (locationController.text.isEmpty) {
                GeneralServices.instance
                    .showErrorMessage(context, "Fill location");
              } else {
                BlocProvider.of<SuggestDoctorBloc>(context).add(
                  AddSuggestDoctorEvent(
                      doctorName: doctorNameController.text,
                      location: locationController.text,
                      clinicName: clinicNameController.text,
                      specialization: specializationController.text,
                      phoneNumber: phoneNumberController.text),
                );
              }
            }),
      ),
      body: BlocListener<SuggestDoctorBloc, SuggestDoctorState>(
        listener: (context, state) {
          if (state is SuggestDoctorError) {
            return GeneralServices.instance
                .showErrorMessage(context, state.errorMessage);
          }
          if (state is SuggestDoctorLoaded) {
            return GeneralServices.instance
                .showSuccessMessage(context, state.successMessage);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Dotor name",
                  style: size.width > 400 ? greyTabMain : greyMain,
                ),
                const VerticalSpacingWidget(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
                    cursorColor: kMainColor,
                    controller: doctorNameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Enter doctor name",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Location",
                  style: size.width > 400 ? greyTabMain : greyMain,
                ),
                const VerticalSpacingWidget(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
                    cursorColor: kMainColor,
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Enter loaction",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Clinic name",
                  style: size.width > 400 ? greyTabMain : greyMain,
                ),
                const VerticalSpacingWidget(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
                    cursorColor: kMainColor,
                    controller: clinicNameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Enter clinic name",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Specialization",
                  style: size.width > 400 ? greyTabMain : greyMain,
                ),
                const VerticalSpacingWidget(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
                    cursorColor: kMainColor,
                    controller: specializationController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Enter specialization",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 5),
                Text(
                  "Phone number",
                  style: size.width > 400 ? greyTabMain : greyMain,
                ),
                const VerticalSpacingWidget(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: size.width > 400 ? 12.sp : 14.sp),
                    cursorColor: kMainColor,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Enter phone number",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    doctorNameController.dispose();
    locationController.dispose();
    clinicNameController.dispose();
    specializationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

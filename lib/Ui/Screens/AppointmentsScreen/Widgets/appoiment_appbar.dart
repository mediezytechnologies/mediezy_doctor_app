import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Model/Profile/ProfileGetModel.dart';
import '../../../../Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import '../../../CommonWidgets/patient_image_widget.dart';

const sWidth = ScreenUtil.defaultSize;

// ignore: must_be_immutable
class AppoimentAppbar extends StatelessWidget implements PreferredSizeWidget {
  AppoimentAppbar({super.key});

  late ProfileGetModel profileGetModel;

  @override
  Widget build(BuildContext context) {
    //   final sWidth = ScreenUtil.defaultSize;
    final size = MediaQuery.of(context).size;
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 20.sp),
      backgroundColor: kMainColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: size.width > 450 ? size.width * .00 : size.width * 0.04,
          ),
          child: SizedBox(
            height: size.height * 0.04,
            width: 100.w,
            child: Image.asset("assets/icons/mediezy logo small.png"),
          ),
        )
      ],
      flexibleSpace: SizedBox(
        height: size.width > 450 ? size.height * 0.17 : size.height * 0.27,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: BlocBuilder<ProfileGetBloc, ProfileGetState>(
            builder: (context, state) {
              if (state is ProfileGetLoading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: size.height * 0.135,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                );
              }
              if (state is ProfileGetLoaded) {
                profileGetModel =
                    BlocProvider.of<ProfileGetBloc>(context).profileGetModel;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height:
                      size.width > 450 ? size.height * .1 : size.height * 0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kMainColor,
                    // color: Colors.amber
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(sWidth.width.toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi,",
                                  style: size.width > 450
                                      ? TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)
                                      : TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                ),
                                Text(
                                  "Dr.${profileGetModel.doctorDetails!.first.firstname.toString()} ${profileGetModel.doctorDetails!.first.secondname.toString()}",
                                  style: size.width > 450
                                      ? TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)
                                      : TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                ),
                                Text(
                                  "Manage Your Practice With Us",
                                  style: size.width > 450
                                      ? TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)
                                      : TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                ),
                              ],
                            ),
                            FadedScaleAnimation(
                              scaleDuration: const Duration(milliseconds: 400),
                              fadeDuration: const Duration(milliseconds: 400),
                              child: PatientImageWidget(
                                  patientImage: profileGetModel.doctorDetails!
                                              .first.docterImage ==
                                          null
                                      ? ""
                                      : profileGetModel
                                          .doctorDetails!.first.docterImage
                                          .toString(),
                                  radius: size.width > 450 ? 28.r : 35.r),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 120.h);
}

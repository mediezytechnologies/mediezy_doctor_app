import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/AddFavouritesLab/add_favourites_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/RemoveFavLab/remove_fav_labs_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'horizontal_spacing_widget.dart';

class GetLabWidget extends StatefulWidget {
  const GetLabWidget({
    Key? key,
    required this.labName,
    required this.imageUrl,
    required this.mobileNo,
    required this.location,
    required this.labId,
    required this.favouritesStatus,
  }) : super(key: key);

  final String labName;
  final String imageUrl;
  final String mobileNo;
  final String location;
  final String labId;
  final String favouritesStatus;

  @override
  State<GetLabWidget> createState() => _GetLabWidgetState();
}

class _GetLabWidgetState extends State<GetLabWidget> {
  late bool isAddButtonVisible;

  @override
  void initState() {
    super.initState();
    isAddButtonVisible = widget.favouritesStatus != "1";
  }

  void toggleButton() {
    setState(() {
      isAddButtonVisible = !isAddButtonVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 8.0.h, bottom: 18.0.h, left: 8.w, right: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FadedScaleAnimation(
                    scaleDuration: const Duration(milliseconds: 400),
                    fadeDuration: const Duration(milliseconds: 400),
                    child: Image.network(
                      widget.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/no image.jpg",
                          height: 50.h,
                          width: 50.h,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      height: 50.h,
                      width: 60.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  HorizontalSpacingWidget(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacingWidget(height: 5),
                      Text(
                        widget.labName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const VerticalSpacingWidget(height: 5),
                      Row(
                        children: [
                          Text(
                            "Mobile No: ",
                            style: TextStyle(
                                fontSize: 12.sp, color: kSubTextColor),
                          ),
                          Text(
                            widget.mobileNo,
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          const HorizontalSpacingWidget(width: 8),
                        ],
                      ),
                      const VerticalSpacingWidget(height: 5),
                      Row(
                        children: [
                          Text(
                            "Location:",
                            style: TextStyle(
                                fontSize: 12.sp, color: kSubTextColor),
                          ),
                          Text(
                            widget.location,
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          const HorizontalSpacingWidget(width: 8),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  isAddButtonVisible
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            BlocProvider.of<AddFavouritesLabBloc>(context).add(
                              AddFavouritesLab(labId: widget.labId),
                            );
                            toggleButton();
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            BlocProvider.of<RemoveFavLabsBloc>(context)
                                .add(RemoveFavouritesLab(labId: widget.labId));
                            toggleButton();
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

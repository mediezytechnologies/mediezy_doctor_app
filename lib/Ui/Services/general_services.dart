import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class GeneralServices {
  static GeneralServices instance = GeneralServices();

  //* to show toast
  showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF56B89C),
        textColor: Colors.white,
        fontSize: 16.sp);
  }

  //* to close the app
  appCloseDialogue(
      BuildContext context, String title, void Function()? yesFunction) {
    final size = MediaQuery.of(context).size;
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) {
              return CupertinoAlertDialog(
                content: Text(
                  title,
                  style: size.width > 450
                      ? TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: kTextColor)
                      : TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: kTextColor),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: kTextColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    onPressed: yesFunction,
                    child: Text(
                      "Yes",
                      style: size.width > 450
                          ? TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red)
                          : TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                    ),
                  )
                ],
              );
            }),
          )
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                content: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kTextColor),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kTextColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    onPressed: yesFunction,
                    child: Text(
                      "Yes",
                      style: size.width > 450
                          ? TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red)
                          : TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                    ),
                  )
                ],
              );
            }),
          );
  }

  buildLoadingWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 400.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          itemCount: 60,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: size.width > 450 ? 8 : 5,
            mainAxisExtent: size.width > 450 ? 100 : 70,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kMainColor, width: 1.w),
              ),
            );
          },
        ),
      ),
    );
  }

  //*show dialogue
  showDialogue(BuildContext context, String title) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              content: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        : showDialog(
            barrierDismissible: false,
            context: context,
            builder: ((context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                content: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kTextColor),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }),
          );
  }

  //successfull pop up

  void showSuccessMessage(BuildContext context, String title) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Align(
                alignment: Alignment.center,
                child: Lottie.asset("assets/animations/confirm booking.json",
                    height: 120.h),
              ),
              content: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Lottie.asset("assets/animations/confirm booking.json",
                      height: 120.h),
                ),
                content: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
  }

  //error pop up

  void showErrorMessage(BuildContext context, String title) {
    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                    "assets/animations/Animation - 1708083154204.json",
                    height: 120.h),
              ),
              content: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                      "assets/animations/Animation - 1708083154204.json",
                      height: 120.h),
                ),
                content: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
  }

  //! select date
  Future<void> selectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: ((context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
            ),
          ),
          child: child!,
        );
      }),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  // Future<void> selectIosDate({
  //   required BuildContext context,
  //   required DateTime date,
  //   required Function(DateTime) onDateSelected,
  // }) async {
  //   final DateTime? picked = await showModalBottomSheet<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 300.0,
  //         child: CupertinoDatePicker(
  //           mode: CupertinoDatePickerMode.date,
  //           initialDateTime: date,
  //           minimumDate: DateTime(2101),
  //           maximumDate: DateTime.now(),
  //           onDateTimeChanged: (DateTime newDate) {
  //             onDateSelected(newDate);
  //           },
  //         ),
  //       );
  //     },
  //   );
  //}
  Future<void> selectIosDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          // height: 200.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: date,
            minimumDate: today,
            maximumDate: DateTime(2101),
            onDateTimeChanged: (DateTime newDateTime) {
              onDateSelected(newDateTime);
              // Do something when the date is changed (optional)
            },
          ),
        );
      },
    );
  }
}

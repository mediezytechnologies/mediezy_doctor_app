import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class GetMedicinesWidget extends StatelessWidget {
  // final List<DoctorMedicines>? medicine;
  final String medicineName;
  final String? dosage;
  final String timeSection;
  final String? interval;
  final String noOfDays;
  final int? type;
  final int? morning;
  final int? evening;
  final int? noon;
  final int? night;
  const GetMedicinesWidget(
      {super.key,
      // this.medicine,
      required this.medicineName,
      this.interval,
      required this.noOfDays,
      this.type,
      this.morning,
      this.evening,
      this.noon,
      this.night,
      required this.timeSection,
      this.dosage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShortNamesWidget(
                    firstText: "Medicine : ",
                    secondText: medicineName,
                  ),
                  dosage == null
                      ? Container()
                      : ShortNamesWidget(
                          firstText: "Dosage : ",
                          secondText: dosage.toString(),
                        ),
                  interval == null || interval == "null"
                      ? Container()
                      : ShortNamesWidget(
                          firstText: "Interval : ",
                          secondText: "$interval $timeSection",
                        ),
                  ShortNamesWidget(
                    firstText: "Days : ",
                    secondText: noOfDays,
                  ),
                  const VerticalSpacingWidget(height: 5),
                  ShortNamesWidget(
                    firstText: "",
                    secondText: type == 1
                        ? "After food"
                        : type == 2
                            ? "Before food"
                            : type == 3
                                ? "With food"
                                : "If required",
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (morning == 1)
                            Text(
                              "Morning",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (morning == 1 &&
                              (noon == 1 || evening == 1 || night == 1))
                            Text(
                              ",",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (noon == 1)
                            Text(
                              "Noon",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (noon == 1 && (evening == 1 || night == 1))
                            Text(
                              ",",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (evening == 1)
                            Text(
                              "Evening",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (evening == 1 && night == 1)
                            Text(
                              ",",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                          if (night == 1)
                            Text(
                              "Night",
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

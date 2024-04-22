import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class AddedMedicineWidget extends StatelessWidget {
  final int? itemCount;
  final String medicalStoreName;
  final String medicineName;
  final String noOfDays;
  final String dosage;
  final int morning;
  final int noon;
  final int evening;
  final int night;
  final int foodType;

  const AddedMedicineWidget({
    super.key,
    this.itemCount,
    required this.medicalStoreName,
    required this.medicineName,
    required this.noOfDays,
    required this.dosage,
    required this.morning,
    required this.noon,
    required this.evening,
    required this.night,
    required this.foodType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: kCardColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "Medical Shop : ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: kSubTextColor),
                  ),
                  Text(
                    medicalStoreName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kTextColor),
                  ),
                ],
              ),
              ShortNamesWidget(
                firstText: "",
                secondText: medicineName,
              ),
              ShortNamesWidget(
                firstText: "Days : ",
                secondText: noOfDays,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        morning == 1 ? "Morning," : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: kTextColor),
                      ),
                      Text(
                        noon == 1 ? "Noon," : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: kTextColor),
                      ),
                      Text(
                        evening == 1 ? "Evening," : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: kTextColor),
                      ),
                      Text(
                        night == 1 ? "Night" : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: kTextColor),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const VerticalSpacingWidget(height: 5),
              ShortNamesWidget(
                firstText: "Dosage : ",
                secondText: dosage,
              ),
              ShortNamesWidget(
                firstText: "",
                secondText: foodType == 1 ? "After Food" : "Before Food",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class GetVitalsWidget extends StatelessWidget {
  final String? height;
  final String? temperature;
  final String? temperatureType;
  final String? sys;
  final String? dia;
  final String? weight;
  final String? spo2;
  final String? heartRate;
  const GetVitalsWidget(
      {super.key,
      this.height,
      this.temperature,
      this.temperatureType,
      this.sys,
      this.dia,
      this.weight,
      this.spo2,
      this.heartRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
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
              height == null
                  ? Container()
                  : ShortNamesWidget(
                      firstText: "Height : ",
                      secondText: height == null ? "N/A" : "$height cm",
                    ),
              ShortNamesWidget(
                firstText: "Temperature : ",
                secondText: temperature == null
                    ? "N/A"
                    : "$temperature °$temperatureType",
              ),
              ShortNamesWidget(
                firstText: "BP : ",
                secondText: "${sys ?? "N/A"} / ${dia ?? "N/A"}",
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShortNamesWidget(
                firstText: "Weight : ",
                secondText: weight == null ? "N/A" : "$weight Kg",
              ),
              ShortNamesWidget(
                  firstText: "SpO2 : ",
                  secondText: spo2 == null ? "N/A" : "$spo2 %"),
              ShortNamesWidget(
                  firstText: "Heart Rate : ",
                  secondText: heartRate == null ? "N/A" : "$heartRate BPM"),
            ],
          ),
        ],
      ),
    );
  }
}

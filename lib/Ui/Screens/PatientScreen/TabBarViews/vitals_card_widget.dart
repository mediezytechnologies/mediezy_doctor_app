import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class VitalsCardWidget extends StatelessWidget {
  final String patientName;
  final String doctorName;
  final String appointmentDate;
  final String height;
  final String weight;
  final String temperature;
  final String temperatureType;
  final String heartRate;
  final String spo2;
  final String sys;
  final String dia;

  const VitalsCardWidget({
    super.key,
    required this.patientName,
    required this.doctorName,
    required this.appointmentDate,
    required this.height,
    required this.weight,
    required this.temperature,
    required this.temperatureType,
    required this.heartRate,
    required this.spo2,
    required this.sys,
    required this.dia,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Patient name : ",
                style: size.width > 400 ? greyTabMain : greyMain,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                patientName,
                style: size.width > 400 ? blackTabMainText : blackMainText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Appointment date : ",
                style: size.width > 400 ? greyTabMain : greyMain,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                appointmentDate,
                style: size.width > 400 ? blackTabMainText : blackMainText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Doctor name : ",
                style: size.width > 400 ? greyTabMain : greyMain,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                doctorName,
                style: size.width > 400 ? blackTabMainText : blackMainText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Height : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$height cm",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const HorizontalSpacingWidget(width: 20),
              Row(
                children: [
                  Text(
                    "Weight: ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$weight Kg",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Temperature : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$temperature °$temperatureType",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const HorizontalSpacingWidget(width: 20),
              Row(
                children: [
                  Text(
                    "Heart rate : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$heartRate BPM",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Spo2 : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$spo2 %",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const HorizontalSpacingWidget(width: 20),
              Row(
                children: [
                  Text(
                    "Bp : ",
                    style: size.width > 400 ? greyTabMain : greyMain,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${sys == "" ? "N/A" : sys} / ${dia == "" ? "N/A" : dia}",
                    style: size.width > 400 ? blackTabMainText : blackMainText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

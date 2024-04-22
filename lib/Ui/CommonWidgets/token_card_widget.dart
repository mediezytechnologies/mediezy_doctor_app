import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/GetTokensScreen/FillPatientDetailsScreen/fill_patient_details_screen.dart';

class TokenCardWidget extends StatefulWidget {
  const TokenCardWidget({
    Key? key,
    required this.tokenNumber,
    required this.formatedTime,
    required this.date,
    required this.isBooked,
    required this.scheduleType,
    required this.clinicId,
    required this.isTimedOut,
    required this.isReserved,
  }) : super(key: key);

  final String tokenNumber;
  final String formatedTime;
  final DateTime date;
  final int isBooked;
  final String clinicId;
  final String scheduleType;
  final int isTimedOut;
  final int isReserved;

  @override
  State<TokenCardWidget> createState() => _TokenCardWidgetState();
}

class _TokenCardWidgetState extends State<TokenCardWidget> {
  @override
  Widget build(BuildContext context) {
    Color? containerColor =
    widget.isBooked == 1 ? Colors.grey :
    widget.isTimedOut == 1 ? Colors.grey[200] :
    widget.isReserved == 1 ? Colors.greenAccent.shade100 :
    Colors.white;

    Color? textColor =
    widget.isBooked == 1 ? Colors. white:
    widget.isTimedOut == 1 ? Colors.grey :
    widget.isReserved == 1 ? Colors.black :
    kTextColor;

    return InkWell(
      onTap: () {
        if (widget.isBooked != 1 && widget.isTimedOut != 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FillPatientDetailsScreen(
                date: widget.date,
                tokenNumber: widget.tokenNumber,
                tokenTime: widget.formatedTime,
                clinicId: widget.clinicId,
                scheduleType: widget.scheduleType,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kMainColor, width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.tokenNumber,
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              widget.formatedTime,
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

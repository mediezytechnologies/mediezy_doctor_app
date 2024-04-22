import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class TokenDeleteCardWidget extends StatefulWidget {
  const TokenDeleteCardWidget(
      {super.key,
        required this.tokenNumber,
        required this.time,
        required this.date,
        required this.isBooked,
        required this.clinicId});

  final String tokenNumber;
  final String time;
  final DateTime date;
  final String isBooked;
  final String clinicId;

  @override
  State<TokenDeleteCardWidget> createState() => _TokenDeleteCardWidgetState();
}

class _TokenDeleteCardWidgetState extends State<TokenDeleteCardWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
         //      color: if(widget.isBooked == '1' || isSelected = true){
         //        return Colors.grey[200]
         //  }else{
         // return Colors.white
         //  },
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kMainColor, width: 1.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.tokenNumber,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: kTextColor),
          ),
          Text(
            widget.time,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: kTextColor),
          )
        ],
      ),
    );
  }
}
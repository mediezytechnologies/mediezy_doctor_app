import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class SelectionTokenWidget extends StatefulWidget {
  const SelectionTokenWidget({
    Key? key,
    required this.isBooked,
    required this.tokenNumber,
    required this.time,
    required this.isTimeout,
    required this.isReserved,
    required this.onTokenSelectionChanged,
  }) : super(key: key);

  final int isBooked;
  final int tokenNumber;
  final String time;
  final int isTimeout;
  final int isReserved;
  final Function(int, bool) onTokenSelectionChanged;

  @override
  State<SelectionTokenWidget> createState() => _SelectionTokenWidgetState();
}

class _SelectionTokenWidgetState extends State<SelectionTokenWidget> {
  late Color eveningContainerColor;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    updateColor();
  }

  void updateColor() {
    if (widget.isTimeout == 1) {
      eveningContainerColor = Colors.grey.shade200;
    } else if (widget.isBooked == 1) {
      eveningContainerColor = Colors.grey.shade200;
    } else if (isSelected) {
      eveningContainerColor = Colors.grey.shade500; // Change color when selected
    } else if (widget.isReserved == 1) {
      eveningContainerColor = Colors.greenAccent.shade100;
    } else {
      eveningContainerColor = kCardColor;
    }
  }

  void toggleTokenSelection() {
    setState(() {
      isSelected = !isSelected; // Toggle selection
      widget.onTokenSelectionChanged(widget.tokenNumber, isSelected);
      updateColor(); // Update color after toggling selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isBooked != 1) {
          toggleTokenSelection();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: eveningContainerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kMainColor, width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.tokenNumber.toString(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : kTextColor, // Change time color when selected
              ),
            )
          ],
        ),
      ),
    );
  }
}

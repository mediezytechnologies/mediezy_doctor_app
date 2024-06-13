import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DoubleTapBackPress extends StatelessWidget {
  DoubleTapBackPress(
      {super.key, required this.lastpressed, required this.widget});
  final Widget widget;
  DateTime? lastpressed;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      child: widget,
      onWillPop: () async {
        // DateTime? lastpressed;
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 1);
        final isWarning =
            lastpressed == null || now.difference(lastpressed!) > maxDuration;
        if (isWarning) {
          lastpressed = DateTime.now();
          final snackBar = SnackBar(
            width: 200.w,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Duble Tap to close app',
            ),
            duration: maxDuration,
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
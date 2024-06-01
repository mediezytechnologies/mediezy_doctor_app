// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class CustomTabbarWidget extends StatelessWidget {
  const CustomTabbarWidget(
      {Key? key,
      required this.height,
      required this.marginHorizontal,
      this.onTap,
      required this.controller,
      required this.unselectedLebelSize,
      required this.selectedLebelSize,
      required this.tabText1,
      required this.tabText2,
      this.tabText3,
      this.typeId = 2})
      : super(key: key);

  final double height;
  final double marginHorizontal;
  final void Function(int)? onTap;
  final TabController controller;
  final double unselectedLebelSize;
  final double selectedLebelSize;
  final String tabText1;
  final String tabText2;
  final String? tabText3;
  final int typeId;

  @override
  Widget build(BuildContext context) {
    List tabList = [
      Tab(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              tabText1,
            ),
          ),
        ),
      ),
      Tab(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(tabText2),
          ),
        ),
      ),
      Tab(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              tabText3.toString(),
            ),
          ),
        ),
      ),
    ];

    return Container(
      height: height,
      //size.width > 450 ? 60.h : 40.h,
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal.w),
      decoration: const BoxDecoration(
          color: Color.fromARGB(131, 187, 222, 251),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TabBar(
        onTap: onTap,
        controller: controller,
        physics: const ClampingScrollPhysics(),
        // padding: EdgeInsets.only(
        //     top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
        dividerColor: Colors.transparent,
        unselectedLabelColor: kTextColor,
        unselectedLabelStyle: TextStyle(
          fontSize: unselectedLebelSize,
          //size.width > 450 ? 10.sp : 13.sp,
        ),
        labelStyle: TextStyle(
          fontSize: selectedLebelSize,
          //size.width > 450 ? 11.sp : 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: kMainColor,
        ),
        tabs: List.generate(typeId, (index) => tabList[index]),
      ),
    );
  }
}

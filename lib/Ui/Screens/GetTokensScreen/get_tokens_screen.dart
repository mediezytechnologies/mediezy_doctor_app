// ignore_for_file: deprecated_member_use

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/token_card_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Model/GenerateToken/clinic_get_model.dart';

class GetTokensScreen extends StatefulWidget {
  const GetTokensScreen({super.key});

  @override
  State<GetTokensScreen> createState() => _GetTokensScreenState();
}

class _GetTokensScreenState extends State<GetTokensScreen> {
  bool _isLoading = true;
  DateTime selectedDate = DateTime.now();

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  late GetTokenModel getTokenModel;
  late ClinicGetModel clinicGetModel;

  //* for select clinic section
  late ValueNotifier<String> dropValueClinicNotifier;
  String clinicId = "";
  late String selectedClinicId;
  List<HospitalDetails> clinicValues = [];

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
        // BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());
        BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
        BlocProvider.of<GetTokenBloc>(context)
            .add(FetchTokens(date: formatDate(), clinicId: selectedClinicId));
      },
      child: WillPopScope(
        onWillPop: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BottomNavigationControlWidget()));
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Book Token"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: FadedSlideAnimation(
            beginOffset: const Offset(0, 0.3),
            endOffset: const Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Clinic",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: kSubTextColor),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    BlocBuilder<GetClinicBloc, GetClinicState>(
                      builder: (context, state) {
                        if (state is GetClinicLoading) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        }
                        if (state is GetClinicLoaded) {
                          clinicGetModel =
                              BlocProvider.of<GetClinicBloc>(context)
                                  .clinicGetModel;

                          if (clinicValues.isEmpty) {
                            clinicValues
                                .addAll(clinicGetModel.hospitalDetails!);
                            dropValueClinicNotifier =
                                ValueNotifier(clinicValues.first.clinicName!);
                            clinicId = clinicValues.first.clinicId.toString();
                            selectedClinicId =
                                clinicValues.first.clinicId.toString();
                          }
                          BlocProvider.of<GetTokenBloc>(context).add(
                              FetchTokens(
                                  date: formatDate(),
                                  clinicId: selectedClinicId));

                          return Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kCardColor,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: const Color(0xFF9C9C9C))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: dropValueClinicNotifier,
                                  builder: (BuildContext context,
                                      String dropValue, _) {
                                    return DropdownButtonFormField(
                                      iconEnabledColor: kMainColor,
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ''),
                                      value: dropValue,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: kTextColor),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: clinicValues
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          onTap: () {},
                                          value: value.clinicName!,
                                          child: Text(value.clinicName!),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        dropValue = value!;
                                        dropValueClinicNotifier.value = value;
                                        clinicId = value;
                                        selectedClinicId = clinicValues
                                            .where((element) => element
                                                .clinicName!
                                                .contains(value))
                                            .toList()
                                            .first
                                            .clinicId
                                            .toString();
                                        BlocProvider.of<GetTokenBloc>(context)
                                            .add(FetchTokens(
                                                date: formatDate(),
                                                clinicId: selectedClinicId));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    const VerticalSpacingWidget(height: 5),
                    _isLoading
                        ? _buildCalenderLoadingWidget()
                        : EasyDateTimeLine(
                            initialDate: selectedDate,
                            disabledDates: _getDisabledDates(),
                            onDateChange: (date) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(date);
                              selectedDate = date; // Update the selectedDate
                              BlocProvider.of<GetTokenBloc>(context).add(
                                  FetchTokens(
                                      date: formattedDate,
                                      clinicId: selectedClinicId));
                            },
                            activeColor: kMainColor,
                             headerProps: EasyHeaderProps(
                  selectedDateStyle: TextStyle(
                      fontSize: 9.0.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  monthStyle: TextStyle(
                      fontSize: 9.0.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  selectedDateFormat: SelectedDateFormat.monthOnly,
                ),
                            dayProps: EasyDayProps(
                                height: 80.h,
                                width: 65.w,
                                activeDayNumStyle: TextStyle(
                                    color: kCardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                                inactiveDayNumStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kMainColor),
                                inactiveDayStrStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kMainColor),
                                activeDayStrStyle: TextStyle(
                                    color: kCardColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp),
                                activeMothStrStyle: TextStyle(
                                    color: kCardColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp),
                                inactiveMothStrStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kMainColor),
                                todayHighlightStyle:
                                    TodayHighlightStyle.withBackground,
                                todayHighlightColor: const Color(0xffE1ECC8),
                                borderColor: kMainColor),
                          ),
                    const VerticalSpacingWidget(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: kMainColor)),
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Available",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: kMainColor)),
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Timeout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Booked",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: kMainColor)),
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Reserved",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  ! select date
                    BlocBuilder<GetTokenBloc, GetTokenState>(
                      builder: (context, state) {
                        if (state is GetTokenLoading) {
                          return _buildLoadingWidget();
                        }
                        if (state is GetTokenError) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const VerticalSpacingWidget(height: 100),
                              Center(
                                child: Image(
                                  height: 120.h,
                                  image: const AssetImage(
                                      "assets/images/something went wrong-01.png"),
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is GetTokenLoaded) {
                          getTokenModel = BlocProvider.of<GetTokenBloc>(context)
                              .getTokenModel;
                          if (getTokenModel.schedule == null) {
                            return Center(
                                child: EmptyCutomeWidget(
                                    text: getTokenModel.message.toString()));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpacingWidget(height: 10),
                              if (getTokenModel
                                      .schedule?.schedule1?.isNotEmpty ==
                                  true)
                                 Text(
                                  "Schedule 1",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (getTokenModel
                                      .schedule?.schedule1?.isNotEmpty ==
                                  true)
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shrinkWrap: true,
                                  itemCount:
                                      getTokenModel.schedule!.schedule1!.length,
                                  gridDelegate:
                                       SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 5,
                                    mainAxisExtent: 65.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TokenCardWidget(
                                      clinicId: selectedClinicId,
                                      date: selectedDate,
                                      tokenNumber: getTokenModel.schedule!
                                          .schedule1![index].tokenNumber
                                          .toString(),
                                      formatedTime: getTokenModel.schedule!
                                          .schedule1![index].formattedStartTime
                                          .toString(),
                                      isBooked: getTokenModel.schedule!
                                          .schedule1![index].isBooked!,
                                      isTimedOut: getTokenModel.schedule!
                                          .schedule1![index].isTimeout!,
                                      scheduleType: getTokenModel.schedule!
                                          .schedule1![index].scheduleType!,
                                      isReserved: getTokenModel.schedule!
                                          .schedule1![index].isReserved!,
                                    );
                                  },
                                ),
                              const VerticalSpacingWidget(height: 10),
                              if (getTokenModel
                                      .schedule!.schedule2?.isNotEmpty ==
                                  true)
                                const Text(
                                  "Schedule 2",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (getTokenModel
                                      .schedule!.schedule2?.isNotEmpty ==
                                  true)
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shrinkWrap: true,
                                  itemCount:
                                      getTokenModel.schedule!.schedule2!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 5,
                                    mainAxisExtent: 78,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TokenCardWidget(
                                      clinicId: selectedClinicId,
                                      date: selectedDate,
                                      tokenNumber: getTokenModel.schedule!
                                          .schedule2![index].tokenNumber
                                          .toString(),
                                      isBooked: getTokenModel.schedule!
                                          .schedule2![index].isBooked!,
                                      formatedTime: getTokenModel.schedule!
                                          .schedule2![index].formattedStartTime
                                          .toString(),
                                      isTimedOut: getTokenModel.schedule!
                                          .schedule2![index].isTimeout!,
                                      scheduleType: getTokenModel.schedule!
                                          .schedule2![index].scheduleType!,
                                      isReserved: getTokenModel.schedule!
                                          .schedule2![index].isReserved!,
                                    );
                                  },
                                ),
                              if (getTokenModel
                                      .schedule!.schedule3?.isNotEmpty ==
                                  true)
                                const Text(
                                  "Schedule 3",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (getTokenModel
                                      .schedule!.schedule3?.isNotEmpty ==
                                  true)
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shrinkWrap: true,
                                  itemCount:
                                      getTokenModel.schedule!.schedule3!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 5,
                                    mainAxisExtent: 78,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TokenCardWidget(
                                      clinicId: selectedClinicId,
                                      date: selectedDate,
                                      tokenNumber: getTokenModel.schedule!
                                          .schedule3![index].tokenNumber
                                          .toString(),
                                      isBooked: getTokenModel.schedule!
                                          .schedule3![index].isBooked!,
                                      formatedTime: getTokenModel.schedule!
                                          .schedule3![index].formattedStartTime
                                          .toString(),
                                      isTimedOut: getTokenModel.schedule!
                                          .schedule3![index].isTimeout!,
                                      scheduleType: getTokenModel.schedule!
                                          .schedule3![index].scheduleType!,
                                      isReserved: getTokenModel.schedule!
                                          .schedule3![index].isReserved!,
                                    );
                                  },
                                ),
                            ],
                          );
                        }
                        return Container(
                          color: Colors.yellow,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 400.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacingWidget(height: 10),
            Container(
              height: 10.h,
              width: 70.w,
              color: Colors.white,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              itemCount: 25,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                crossAxisCount: 5,
                mainAxisExtent: 78,
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
          ],
        ),
      ),
    );
  }

  Widget _buildCalenderLoadingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacingWidget(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 15.h,
                width: 50.w,
                color: Colors.white,
              ),
              Container(
                height: 15.h,
                width: 50.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const VerticalSpacingWidget(height: 10),
        SizedBox(
          height: 80.h,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: 6, // Choose a number of shimmer items
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    width: 65.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    // Iterate through the months and add all dates before the current date
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}

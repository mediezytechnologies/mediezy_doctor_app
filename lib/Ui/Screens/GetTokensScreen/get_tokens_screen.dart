// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_demo.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/token_card_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/GetTokensScreen/ScreenOne%20.dart';
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

  final HospitalController dController = Get.put(HospitalController());

  Future<void> _refreshData() async {
    BlocProvider.of<GetTokenBloc>(context).add(
        FetchTokens(date: formatDate(), clinicId: dController.initialIndex!));
  }

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetTokenBloc>(context).add(
        FetchTokens(date: formatDate(), clinicId: dController.initialIndex!));
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => const BottomNavigationControlWidget()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Token"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final connectivityResult = snapshot.data;
            if (connectivityResult == ConnectivityResult.none) {
              return Scaffold(
                backgroundColor: kCardColor,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 180.h,
                        width: 300.w,
                        child: Image.asset(
                          "assets/images/no connection.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    Text(
                      "Please check your internet connection",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: FadedSlideAnimation(
                        beginOffset: const Offset(0, 0.3),
                        endOffset: const Offset(0, 0),
                        slideCurve: Curves.linearToEaseOut,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(size.width.toString()),
                              Text(
                                "Select Clinic",
                                style: size.width > 450
                                    ? greyTab10B600
                                    : grey13B600,
                              ),
                              const VerticalSpacingWidget(height: 3),
                              GetBuilder<HospitalController>(builder: (clx) {
                                return CustomDropDown(
                                  width: double.infinity,
                                  value: dController.initialIndex,
                                  items: dController.hospitalDetails!.map((e) {
                                    return DropdownMenuItem(
                                      value: e.clinicId.toString(),
                                      child: Text(e.clinicName!),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    log(newValue!);
                                    dController.dropdownValueChanging(
                                        newValue, dController.initialIndex!);
                                    BlocProvider.of<GetTokenBloc>(context).add(
                                        FetchTokens(
                                            date: formatDate(),
                                            clinicId:
                                                dController.initialIndex!));
                                  },
                                );
                              }),
                              const VerticalSpacingWidget(height: 5),
                              _isLoading
                                  ? _buildCalenderLoadingWidget(context)
                                  : DatePickerDemoClass(
                                      height: size.width > 450
                                          ? size.height * .1
                                          : size.height * .14,
                                      width: size.width > 450
                                          ? size.width * .12
                                          : size.width * .17,
                                      DateTime.now(),
                                      initialSelectedDate: DateTime.now(),
                                      selectionColor: kMainColor,
                                      selectedTextColor: Colors.white,
                                      onDateChange: (date) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                        selectedDate = date;
                                        BlocProvider.of<GetTokenBloc>(context)
                                            .add(FetchTokens(
                                                date: formattedDate,
                                                clinicId:
                                                    dController.initialIndex!));
                                      },
                                      dateTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              size.width > 450 ? 10.sp : 16.sp),
                                      dayTextStyle: TextStyle(
                                          fontSize:
                                              size.width > 450 ? 8.sp : 12.sp),
                                      monthTextStyle: TextStyle(
                                          fontSize:
                                              size.width > 450 ? 8.sp : 12.sp),
                                    ),
                              // const VerticalSpacingWidget(height: 10),
                              // Center(
                              //   child: TextButton(
                              //       onPressed: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     const ScreenOne()));
                              //       },
                              //       child: const Text("data")),
                              // ),
                              // Text(size.width.toString()),
                              const VerticalSpacingWidget(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 20.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: kMainColor)),
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Text(
                                          "Available",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: kMainColor)),
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Text(
                                          "Timeout",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: kMainColor),
                                          ),
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Text(
                                          "Booked",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 20.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.greenAccent.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: kMainColor)),
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Text(
                                          "Reserved",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
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
                                  return _buildLoadingWidget(context);
                                }
                                if (state is GetTokenError) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  getTokenModel =
                                      BlocProvider.of<GetTokenBloc>(context)
                                          .getTokenModel;
                                  if (getTokenModel.schedule == null) {
                                    return Center(
                                        child: EmptyCutomeWidget(
                                            text: getTokenModel.message
                                                .toString()));
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const VerticalSpacingWidget(height: 10),
                                      if (getTokenModel.schedule?.schedule1
                                              ?.isNotEmpty ==
                                          true)
                                        Text(
                                          "Schedule 1",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
                                        ),
                                      if (getTokenModel.schedule?.schedule1
                                              ?.isNotEmpty ==
                                          true)
                                        GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shrinkWrap: true,
                                          itemCount: getTokenModel
                                              .schedule!.schedule1!.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            crossAxisCount:
                                                size.width > 450 ? 7 : 5,
                                            mainAxisExtent:
                                                size.width > 450 ? 130 : 78,
                                          ),
                                          itemBuilder: (context, index) {
                                            return TokenCardWidget(
                                              clinicId:
                                                  dController.initialIndex!,
                                              date: selectedDate,
                                              tokenNumber: getTokenModel
                                                  .schedule!
                                                  .schedule1![index]
                                                  .tokenNumber
                                                  .toString(),
                                              formatedTime: getTokenModel
                                                  .schedule!
                                                  .schedule1![index]
                                                  .formattedStartTime
                                                  .toString(),
                                              isBooked: getTokenModel.schedule!
                                                  .schedule1![index].isBooked!,
                                              isTimedOut: getTokenModel
                                                  .schedule!
                                                  .schedule1![index]
                                                  .isTimeout!,
                                              scheduleType: getTokenModel
                                                  .schedule!
                                                  .schedule1![index]
                                                  .scheduleType!,
                                              isReserved: getTokenModel
                                                  .schedule!
                                                  .schedule1![index]
                                                  .isReserved!,
                                            );
                                          },
                                        ),
                                      const VerticalSpacingWidget(height: 10),
                                      if (getTokenModel.schedule!.schedule2
                                              ?.isNotEmpty ==
                                          true)
                                        Text(
                                          "Schedule 2",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
                                        ),
                                      if (getTokenModel.schedule!.schedule2
                                              ?.isNotEmpty ==
                                          true)
                                        GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shrinkWrap: true,
                                          itemCount: getTokenModel
                                              .schedule!.schedule2!.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            crossAxisCount:
                                                size.width > 450 ? 7 : 5,
                                            mainAxisExtent:
                                                size.width > 450 ? 130 : 78,
                                          ),
                                          itemBuilder: (context, index) {
                                            return TokenCardWidget(
                                              clinicId:
                                                  dController.initialIndex!,
                                              date: selectedDate,
                                              tokenNumber: getTokenModel
                                                  .schedule!
                                                  .schedule2![index]
                                                  .tokenNumber
                                                  .toString(),
                                              isBooked: getTokenModel.schedule!
                                                  .schedule2![index].isBooked!,
                                              formatedTime: getTokenModel
                                                  .schedule!
                                                  .schedule2![index]
                                                  .formattedStartTime
                                                  .toString(),
                                              isTimedOut: getTokenModel
                                                  .schedule!
                                                  .schedule2![index]
                                                  .isTimeout!,
                                              scheduleType: getTokenModel
                                                  .schedule!
                                                  .schedule2![index]
                                                  .scheduleType!,
                                              isReserved: getTokenModel
                                                  .schedule!
                                                  .schedule2![index]
                                                  .isReserved!,
                                            );
                                          },
                                        ),
                                      if (getTokenModel.schedule!.schedule3
                                              ?.isNotEmpty ==
                                          true)
                                        Text(
                                          "Schedule 3",
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black11Bbold,
                                        ),
                                      if (getTokenModel.schedule!.schedule3
                                              ?.isNotEmpty ==
                                          true)
                                        GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shrinkWrap: true,
                                          itemCount: getTokenModel
                                              .schedule!.schedule3!.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            crossAxisCount:
                                                size.width > 450 ? 7 : 5,
                                            mainAxisExtent:
                                                size.width > 450 ? 130 : 78,
                                          ),
                                          itemBuilder: (context, index) {
                                            return TokenCardWidget(
                                              clinicId:
                                                  dController.initialIndex!,
                                              date: selectedDate,
                                              tokenNumber: getTokenModel
                                                  .schedule!
                                                  .schedule3![index]
                                                  .tokenNumber
                                                  .toString(),
                                              isBooked: getTokenModel.schedule!
                                                  .schedule3![index].isBooked!,
                                              formatedTime: getTokenModel
                                                  .schedule!
                                                  .schedule3![index]
                                                  .formattedStartTime
                                                  .toString(),
                                              isTimedOut: getTokenModel
                                                  .schedule!
                                                  .schedule3![index]
                                                  .isTimeout!,
                                              scheduleType: getTokenModel
                                                  .schedule!
                                                  .schedule3![index]
                                                  .scheduleType!,
                                              isReserved: getTokenModel
                                                  .schedule!
                                                  .schedule3![index]
                                                  .isReserved!,
                                            );
                                          },
                                        ),
                                    ],
                                  );
                                }
                                return Container(
                                  color: Colors.yellow,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                crossAxisCount: size.width > 450 ? 7 : 5,
                mainAxisExtent: size.width > 450 ? 130 : 78,
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

  Widget _buildCalenderLoadingWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              itemCount: 7, // Choose a number of shimmer items
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    height:
                        size.width > 450 ? size.height * .1 : size.height * .11,
                    width:
                        size.width > 450 ? size.width * .12 : size.width * .17,
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

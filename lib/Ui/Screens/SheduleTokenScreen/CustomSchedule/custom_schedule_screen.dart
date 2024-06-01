import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_break_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_early_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_late_model.dart';
import 'package:mediezy_doctor/Model/MessageShowModel/message_show_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/BetweenCustomSchedule/between_schedule_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/GetAllLate/get_all_late_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/LateCustomSchedule/late_schedule_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/CustomSchedule/upcoming_list_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../Model/GenerateToken/clinic_get_model.dart';

class CustomScheduleScreen extends StatefulWidget {
  const CustomScheduleScreen({super.key});

  @override
  State<CustomScheduleScreen> createState() => _CustomScheduleScreenState();
}

class _CustomScheduleScreenState extends State<CustomScheduleScreen>
    with TickerProviderStateMixin {
  final TextEditingController lateTimeController = TextEditingController();
  final TextEditingController earlyTimeController = TextEditingController();

  final HospitalController dController = Get.put(HospitalController());

  late TabController tabFirstController;

  DateTime lateDate = DateTime.now();
  DateTime leaveDate = DateTime.now();
  DateTime earlyDate = DateTime.now();
  DateTime startBreakDate = DateTime.now();
  DateTime endBreakDate = DateTime.now();
  TimeOfDay selectedStartingTime = TimeOfDay.now();
  TimeOfDay selectedEndingTime = TimeOfDay.now();

  late ClinicGetModel clinicGetModel;
  late MessageShowModel messageShowModel;
  late GetAllLateModel getAllLateModel;
  late GetAllEarlyModel getAllEarlyModel;
  late GetAllBreakModel getAllBreakModel;

  //! schedule dropDown

  String dropdownLateValue = 'Schedule 1';
  String dropdownEarlyValue = 'Schedule 1';
  String dropdownBreakValue = 'Schedule 1';

  late int? selectedLateValue;
  late int? selectedEarlyValue;
  late int? selectedBreakValue;

  bool checkBoxValue = false;
  String checkBoxStringValue = '0';

  final items = {
    'Schedule 1': 1,
    'Schedule 2': 2,
    'Schedule 3': 3,
  };

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    lateTimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllLateBloc>(context)
        .add(FetchAllLate(clinicId: dController.initialIndex!));
    // BlocProvider.of<GetAllLateBloc>(context).add(
    //     FetchAllEarly(clinicId: dController.initialIndex!));
    // BlocProvider.of<GetAllLateBloc>(context)
    //     .add(FetchAllBreak(clinicId: dController.initialIndex!));
    selectedLateValue = items['Schedule 1'];
    selectedEarlyValue = items['Schedule 1'];
    selectedBreakValue = items['Schedule 1'];
    tabFirstController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Custom Schedule",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            VerticalSpacingWidget(height: 10.h),
            Container(
              height: 50.h,
              color: kCardColor,
              child: TabBar(
                onTap: (d) {
                  if (tabFirstController.index == 0) {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<GetAllLateBloc>(context)
                        .add(FetchAllLate(clinicId: dController.initialIndex!));
                  } else if (tabFirstController.index == 1) {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<GetAllLateBloc>(context).add(
                        FetchAllEarly(clinicId: dController.initialIndex!));
                  } else {
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<GetAllLateBloc>(context).add(
                        FetchAllBreak(clinicId: dController.initialIndex!));
                  }
                },
                controller: tabFirstController,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                dividerColor: kCardColor,
                unselectedLabelColor: kTextColor,
                unselectedLabelStyle: TextStyle(
                  fontSize: size.width > 450 ? 10.sp : 13.sp,
                ),
                labelStyle: TextStyle(
                  fontSize: size.width > 450 ? 11.sp : 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kMainColor),
                tabs: [
                  //! late
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Late",
                        ),
                      ),
                    ),
                  ),
                  //! Early
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Early"),
                      ),
                    ),
                  ),
                  // ! break
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Break"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabFirstController,
                children: [
                  //! late
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Clinic",
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 5),
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
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllLate(
                                      clinicId: dController.initialIndex!));
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: lateDate,
                                        onDateSelected:
                                            (DateTime picked) async {
                                          setState(() {
                                            lateDate = picked;
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: lateDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            lateDate = picked;
                                          });
                                        },
                                      );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Select Date",
                                        style: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const HorizontalSpacingWidget(width: 5),
                                      IconButton(
                                        onPressed: () {
                                          Platform.isIOS
                                              ? GeneralServices.instance
                                                  .selectIosDate(
                                                  context: context,
                                                  date: lateDate,
                                                  onDateSelected:
                                                      (DateTime picked) async {
                                                    setState(() {
                                                      lateDate = picked;
                                                    });
                                                  },
                                                )
                                              : GeneralServices.instance
                                                  .selectDate(
                                                  context: context,
                                                  date: lateDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      lateDate = picked;
                                                    });
                                                  },
                                                );
                                        },
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                          size:
                                              size.width > 450 ? 15.sp : 20.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyy').format(lateDate),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 180.w,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: DropdownButtonFormField(
                                    iconEnabledColor: kMainColor,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    value: dropdownLateValue,
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.entries
                                        .map((MapEntry<String, int> entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.key),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownLateValue = newValue!;
                                        selectedLateValue = items[newValue];
                                        // print(selectedLateValue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        Text(
                          "Set late time",
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 10),
                        TextFormField(
                          focusNode: _focusNode,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 10.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: lateTimeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            hintText: "eg: 10 min late",
                            filled: true,
                            fillColor: kCardColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: kMainColor),
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 17),
                        BlocListener<LateScheduleBloc, LateScheduleState>(
                          listener: (context, state) {
                            if (state is LateScheduleLoaded) {
                              GeneralServices.instance.showSuccessMessage(
                                  context, "Late Schedule Added Successfull");
                              Future.delayed(const Duration(seconds: 1), () {
                                BlocProvider.of<GetAllLateBloc>(context).add(
                                    FetchAllLate(
                                        clinicId: dController.initialIndex!));
                              });
                            }
                            if (state is LateScheduleError) {
                              GeneralServices.instance.showErrorMessage(
                                  context, state.errorMessage);
                            }
                          },
                          child: CommonButtonWidget(
                            title: "Apply",
                            onTapFunction: () {
                              _focusNode.unfocus();
                              BlocProvider.of<LateScheduleBloc>(context)
                                  .add(AddLateSchedule(
                                date: DateFormat('yyy-MM-dd').format(lateDate),
                                clinicId: dController.initialIndex!,
                                scheduleType: selectedLateValue.toString(),
                                timeDuration: lateTimeController.text,
                              ));
                            },
                          ),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        BlocBuilder<GetAllLateBloc, GetAllLateState>(
                          builder: (context, state) {
                            if (state is DeleteLateLoaded) {
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllLate(
                                      clinicId: dController.initialIndex!));
                            }
                            if (state is GetAllLateLoaded) {
                              getAllLateModel =
                                  BlocProvider.of<GetAllLateBloc>(context)
                                      .getAllLateModel;
                              if (getAllLateModel.data!.isEmpty) {
                                return Container();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your upcoming Late",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  VerticalSpacingWidget(height: 5.h),
                                  SizedBox(
                                    height: 230.h,
                                    child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return UpcomingListWidget(
                                            scheduleType: getAllLateModel
                                                .data![index].scheduleType
                                                .toString(),
                                            time: getAllLateModel
                                                .data![index].rescheduleDuration
                                                .toString(),
                                            date: getAllLateModel
                                                .data![index].scheduleDate
                                                .toString(),
                                            clinicId: dController.initialIndex!,
                                            scheduleId: getAllLateModel
                                                .data![index].rescheduleId
                                                .toString(),
                                            section: 'late',
                                            onPressed: () {
                                              GeneralServices.instance
                                                  .appCloseDialogue(context,
                                                      "Are you sure you want to delete ?",
                                                      () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                BlocProvider.of<GetAllLateBloc>(
                                                        context)
                                                    .add(DeleteLate(
                                                        scheduleId:
                                                            getAllLateModel
                                                                .data![index]
                                                                .rescheduleId
                                                                .toString()));
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const VerticalSpacingWidget(
                                              height: 10);
                                        },
                                        itemCount:
                                            getAllLateModel.data!.length),
                                  )
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  //! Early
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Clinic",
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 5),
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
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllEarly(
                                      clinicId: dController.initialIndex!));
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: earlyDate,
                                        onDateSelected:
                                            (DateTime picked) async {
                                          setState(() {
                                            earlyDate = picked;
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: earlyDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            earlyDate = picked;
                                          });
                                        },
                                      );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Select Date",
                                        style: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const HorizontalSpacingWidget(width: 5),
                                      IconButton(
                                        onPressed: () {
                                          Platform.isIOS
                                              ? GeneralServices.instance
                                                  .selectIosDate(
                                                  context: context,
                                                  date: earlyDate,
                                                  onDateSelected:
                                                      (DateTime picked) async {
                                                    setState(() {
                                                      earlyDate = picked;
                                                    });
                                                  },
                                                )
                                              : GeneralServices.instance
                                                  .selectDate(
                                                  context: context,
                                                  date: earlyDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      earlyDate = picked;
                                                    });
                                                  },
                                                );
                                        },
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                          size:
                                              size.width > 450 ? 15.sp : 20.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyy').format(earlyDate),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 180.w,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: DropdownButtonFormField(
                                    iconEnabledColor: kMainColor,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    value: dropdownEarlyValue,
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.entries
                                        .map((MapEntry<String, int> entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.key),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      dropdownEarlyValue = newValue!;
                                      selectedEarlyValue = items[newValue];
                                      // print(selectedEarlyValue);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        Text(
                          "Set Early time",
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 10),
                        TextFormField(
                          focusNode: _focusNode,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 10.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: earlyTimeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            hintText: "eg: 10 min early",
                            filled: true,
                            fillColor: kCardColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: kMainColor),
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 17),
                        BlocListener<LateScheduleBloc, LateScheduleState>(
                          listener: (context, state) {
                            if (state is EarlyScheduleLoaded) {
                              GeneralServices.instance.showSuccessMessage(
                                  context, "Early Schedule Added Successfull");
                              Future.delayed(const Duration(seconds: 3), () {});
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllEarly(
                                      clinicId: dController.initialIndex!));
                            }
                            if (state is EarlyScheduleError) {
                              GeneralServices.instance.showErrorMessage(
                                  context, state.errorMessage);
                            }
                          },
                          child: CommonButtonWidget(
                              title: "Apply",
                              onTapFunction: () {
                                _focusNode.unfocus();
                                BlocProvider.of<LateScheduleBloc>(context)
                                    .add(AddEarlySchedule(
                                  date:
                                      DateFormat('yyy-MM-dd').format(earlyDate),
                                  clinicId: dController.initialIndex!,
                                  scheduleType: selectedEarlyValue.toString(),
                                  timeDuration: earlyTimeController.text,
                                ));
                              }),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        BlocBuilder<GetAllLateBloc, GetAllLateState>(
                          builder: (context, state) {
                            if (state is DeleteEarlyLoaded) {
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllEarly(
                                      clinicId: dController.initialIndex!));
                            }
                            if (state is GetAllEarlyLoaded) {
                              getAllEarlyModel =
                                  BlocProvider.of<GetAllLateBloc>(context)
                                      .getAllEarlyModel;
                              if (getAllEarlyModel.data!.isEmpty) {
                                return Container();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your upcoming Early",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  const VerticalSpacingWidget(height: 5),
                                  SizedBox(
                                    height: 230.h,
                                    child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return UpcomingListWidget(
                                            scheduleType: getAllEarlyModel
                                                .data![index].scheduleType
                                                .toString(),
                                            time: getAllEarlyModel
                                                .data![index].rescheduleDuration
                                                .toString(),
                                            date: getAllEarlyModel
                                                .data![index].scheduleDate
                                                .toString(),
                                            clinicId: dController.initialIndex!,
                                            scheduleId: getAllEarlyModel
                                                .data![index].rescheduleId
                                                .toString(),
                                            section: 'early',
                                            onPressed: () {
                                              GeneralServices.instance
                                                  .appCloseDialogue(context,
                                                      "Are you sure you want to delete ?",
                                                      () {
                                                BlocProvider.of<GetAllLateBloc>(
                                                        context)
                                                    .add(DeleteEarly(
                                                  scheduleId: getAllEarlyModel
                                                      .data![index].rescheduleId
                                                      .toString(),
                                                ));
                                                Navigator.pop(context);
                                              });
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const VerticalSpacingWidget(
                                              height: 10);
                                        },
                                        itemCount:
                                            getAllEarlyModel.data!.length),
                                  )
                                  // UpcomingListWidget(),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  //! break
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Clinic",
                                  style: size.width > 450
                                      ? greyTab10B600
                                      : grey13B600,
                                ),
                                // const VerticalSpacingWidget(height: 5),
                                //! select clinic
                                GetBuilder<HospitalController>(builder: (clx) {
                                  return CustomDropDown(
                                    width: 180.w,
                                    value: dController.initialIndex,
                                    items:
                                        dController.hospitalDetails!.map((e) {
                                      return DropdownMenuItem(
                                        value: e.clinicId.toString(),
                                        child: Text(e.clinicName!),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      log(newValue!);
                                      dController.dropdownValueChanging(
                                          newValue, dController.initialIndex!);
                                      BlocProvider.of<GetAllLateBloc>(context)
                                          .add(FetchAllBreak(
                                              clinicId:
                                                  dController.initialIndex!));
                                    },
                                  );
                                }),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Schedule",
                                  style: size.width > 450
                                      ? greyTab10B600
                                      : grey13B600,
                                ),
                                Container(
                                  height: size.height * 0.055,
                                  width: 145.w,
                                  decoration: BoxDecoration(
                                      color: kCardColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xFF9C9C9C))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Center(
                                      child: DropdownButtonFormField(
                                        iconEnabledColor: kMainColor,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: dropdownBreakValue,
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: items.entries
                                            .map((MapEntry<String, int> entry) {
                                          return DropdownMenuItem(
                                            value: entry.key,
                                            child: Text(entry.key),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          dropdownBreakValue = newValue!;
                                          selectedBreakValue = items[newValue];
                                          // print(selectedValue);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: startBreakDate,
                                        onDateSelected:
                                            (DateTime picked) async {
                                          setState(() {
                                            startBreakDate = picked;
                                            endBreakDate = picked;
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: startBreakDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            startBreakDate = picked;
                                            endBreakDate = picked;
                                          });
                                        },
                                      );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const HorizontalSpacingWidget(width: 5),
                                      IconButton(
                                        onPressed: () {
                                          Platform.isIOS
                                              ? GeneralServices.instance
                                                  .selectIosDate(
                                                  context: context,
                                                  date: startBreakDate,
                                                  onDateSelected:
                                                      (DateTime picked) async {
                                                    setState(() {
                                                      startBreakDate = picked;
                                                      endBreakDate = picked;
                                                    });
                                                  },
                                                )
                                              : GeneralServices.instance
                                                  .selectDate(
                                                  context: context,
                                                  date: startBreakDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      startBreakDate = picked;
                                                      endBreakDate = picked;
                                                    });
                                                  },
                                                );
                                        },
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                          size:
                                              size.width > 450 ? 15.sp : 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    DateFormat('dd-MM-yyy')
                                        .format(startBreakDate),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: endBreakDate,
                                        onDateSelected:
                                            (DateTime picked) async {
                                          setState(() {
                                            endBreakDate = picked;
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: endBreakDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            endBreakDate = picked;
                                          });
                                        },
                                      );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "End Date",
                                        style: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const HorizontalSpacingWidget(width: 5),
                                      IconButton(
                                        onPressed: () {
                                          Platform.isIOS
                                              ? GeneralServices.instance
                                                  .selectIosDate(
                                                  context: context,
                                                  date: endBreakDate,
                                                  onDateSelected:
                                                      (DateTime picked) async {
                                                    setState(() {
                                                      endBreakDate = picked;
                                                    });
                                                  },
                                                )
                                              : GeneralServices.instance
                                                  .selectDate(
                                                  context: context,
                                                  date: endBreakDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      endBreakDate = picked;
                                                    });
                                                  },
                                                );
                                        },
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                          size:
                                              size.width > 450 ? 15.sp : 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    DateFormat('dd-MM-yyy')
                                        .format(endBreakDate),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        Text(
                          "Select Break Time",
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //! starting time
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Starting Time",
                                      style: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                    ),
                                    const HorizontalSpacingWidget(width: 5),
                                    Icon(
                                      IconlyLight.timeCircle,
                                      size: size.width > 450 ? 15.sp : 20.sp,
                                      color: kMainColor,
                                    ),
                                  ],
                                ),
                                const VerticalSpacingWidget(height: 5),
                                InkWell(
                                  onTap: () {
                                    selectStartingTime(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    height: 35.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: kScaffoldColor,
                                        border: Border.all(color: kMainColor),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Text(
                                        selectedStartingTime.format(context),
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //! ending time
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Ending Time",
                                      style: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                    ),
                                    const HorizontalSpacingWidget(width: 5),
                                    Icon(
                                      IconlyLight.timeCircle,
                                      color: kMainColor,
                                      size: size.width > 450 ? 15.sp : 20.sp,
                                    ),
                                  ],
                                ),
                                const VerticalSpacingWidget(height: 5),
                                InkWell(
                                  onTap: () {
                                    selectEndingTime(context);
                                  },
                                  child: Container(
                                    height: 35.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: kScaffoldColor,
                                        border: Border.all(color: kMainColor),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Text(
                                        selectedEndingTime.format(context),
                                        style: size.width > 450
                                            ? blackTabMainText
                                            : blackMainText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Stack(
                          children: [
                            BlocListener<BetweenScheduleBloc,
                                BetweenScheduleState>(
                              listener: (context, state) {
                                if (state is BetweenScheduleLoaded) {
                                  GeneralServices.instance.showSuccessMessage(
                                      context,
                                      "Break Schedule Added Successfully");
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    BlocProvider.of<GetAllLateBloc>(context)
                                        .add(FetchAllBreak(
                                            clinicId:
                                                dController.initialIndex!));
                                  });
                                }
                                if (state is BetweenScheduleError) {
                                  GeneralServices.instance.showErrorMessage(
                                      context, state.errorMessage);
                                  // No need to delay if an error occurs
                                }
                              },
                              child: CommonButtonWidget(
                                title: "Apply",
                                onTapFunction: () {
                                  FocusScope.of(context).unfocus();
                                  BlocProvider.of<BetweenScheduleBloc>(context)
                                      .add(FetchBetweenSchedule(
                                    clinicId: dController.initialIndex!,
                                    startTime:
                                        formatTimeOfDay(selectedStartingTime),
                                    endTime:
                                        formatTimeOfDay(selectedEndingTime),
                                    startDate: DateFormat('yyy-MM-dd')
                                        .format(startBreakDate),
                                    endDate: DateFormat('yyy-MM-dd')
                                        .format(endBreakDate),
                                    scheduleType: selectedBreakValue.toString(),
                                  ));
                                },
                              ),
                            ),
                            BlocBuilder<BetweenScheduleBloc,
                                BetweenScheduleState>(
                              builder: (context, state) {
                                if (state is BetweenScheduleLoading) {
                                  // Show loading indicator here
                                  return const Positioned.fill(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                        const VerticalSpacingWidget(height: 10),
                        BlocListener<GetAllLateBloc, GetAllLateState>(
                          listener: (context, state) {
                            if (state is DeleteBreakLoaded) {
                              GeneralServices.instance.showSuccessMessage(
                                  context, "Break deleted successfully");
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllBreak(
                                      clinicId: dController.initialIndex!));
                            }
                            if (state is DeleteBreakError) {
                              GeneralServices.instance.showErrorMessage(
                                  context, "Please fill correct details");
                            }
                          },
                          child: BlocBuilder<GetAllLateBloc, GetAllLateState>(
                            builder: (context, state) {
                              if (state is GetAllBreakLoaded) {
                                getAllBreakModel =
                                    BlocProvider.of<GetAllLateBloc>(context)
                                        .getAllBreakModel;
                                if (getAllBreakModel.data!.isEmpty) {
                                  return Container();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your upcoming Break's",
                                      style: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                    ),
                                    VerticalSpacingWidget(height: 5.h),
                                    SizedBox(
                                      height: 230.h,
                                      child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: size.width > 450
                                                  ? 55.h
                                                  : 50.h,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 5.h),
                                              decoration: BoxDecoration(
                                                color: kScaffoldColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "${getAllBreakModel.data![index].breakFromDate.toString()} to ${getAllBreakModel.data![index].breakToDate.toString()}",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                        Text(
                                                          "Schedule ${getAllBreakModel.data![index].scheduleType.toString()} :${getAllBreakModel.data![index].breakStartTime} - ${getAllBreakModel.data![index].breakEndTime}",
                                                          style: size.width >
                                                                  400
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        GeneralServices.instance
                                                            .appCloseDialogue(
                                                                context,
                                                                "Are you sure you want to delete ?",
                                                                () {
                                                          BlocProvider.of<
                                                                      GetAllLateBloc>(
                                                                  context)
                                                              .add(DeleteBreak(
                                                                  reScheduleId: getAllBreakModel
                                                                      .data![
                                                                          index]
                                                                      .rescheduleId
                                                                      .toString()));
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete,
                                                          size: size.width > 450
                                                              ? 15.sp
                                                              : 20.sp,
                                                          color: kMainColor))
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const VerticalSpacingWidget(
                                                height: 10);
                                          },
                                          itemCount:
                                              getAllBreakModel.data!.length),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //! select starting date
  Future<void> selectStartingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedStartingTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
                backgroundColor: kCardColor,
                dayPeriodTextColor: kMainColor,
                dialHandColor: kMainColor,
                entryModeIconColor: kMainColor,
                inputDecorationTheme:
                    InputDecorationTheme(focusColor: kMainColor)),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedStartingTime) {
      setState(() {
        selectedStartingTime = pickedTime;
      });
    }
  }

  //! select Ending time
  Future<void> selectEndingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedEndingTime,
    );
    if (pickedTime != null && pickedTime != selectedEndingTime) {
      setState(() {
        selectedEndingTime = pickedTime;
      });
    }
  }

  // Create a database with separate tables for starting and ending times
  Future<void> createBreakDatabase() async {
    // Open database
    // ignore: unused_local_variable
    final Database db1 = await openDatabase('your_database.db1', version: 1,
        onCreate: (Database db1, int version) async {
      // Create the tables for starting and ending times
      await db1.execute(
        "CREATE TABLE starting_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
      );
      await db1.execute(
        "CREATE TABLE ending_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
      );
    });
  }

  Future<void> fetchBreakSelectedStartingTime() async {
    // Open database
    final Database db1 = await openDatabase('your_database.db1');

    // Query database to get selected starting time
    final List<Map<String, dynamic>> maps = await db1.query('starting_times');

    // Check if there is any data
    if (maps.isNotEmpty) {
      final Map<String, dynamic> map = maps.first;
      final TimeOfDay selectedTime =
          TimeOfDay(hour: map['hour'], minute: map['minute']);

      setState(() {
        selectedStartingTime = selectedTime;
      });
    }
  }

  Future<void> fetchBreakSelectedEndingTime() async {
    // Open database
    final Database db1 = await openDatabase('your_database.db1');

    // Query database to get selected ending time
    final List<Map<String, dynamic>> maps = await db1.query('ending_times');

    // Check if there is any data
    if (maps.isNotEmpty) {
      final Map<String, dynamic> map = maps.first;
      final TimeOfDay selectedTime =
          TimeOfDay(hour: map['hour'], minute: map['minute']);

      setState(() {
        selectedEndingTime = selectedTime;
      });
    }
  }

  // Save selected starting time to the database
  Future<void> saveBreakStartingSelectedTime(TimeOfDay selectedTime) async {
    final Database db1 = await openDatabase('your_database.db1');

    await db1.execute(
      'CREATE TABLE IF NOT EXISTS starting_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)',
    );

    await db1.rawInsert(
      'INSERT OR REPLACE INTO starting_times (id, hour, minute) VALUES (?, ?, ?)',
      [1, selectedTime.hour, selectedTime.minute],
    );
  }

// Save selected ending time to the database
  Future<void> saveBreakEndingSelectedTime(TimeOfDay selectedTime) async {
    final Database db1 = await openDatabase('your_database.db1');

    await db1.execute(
      'CREATE TABLE IF NOT EXISTS ending_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)',
    );

    await db1.rawInsert(
      'INSERT OR REPLACE INTO ending_times (id, hour, minute) VALUES (?, ?, ?)',
      [1, selectedTime.hour, selectedTime.minute],
    );
  }

  //! format time
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat('H:mm').format(dateTime);
    return formattedTime;
  }
}

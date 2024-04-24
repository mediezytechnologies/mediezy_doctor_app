import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_break_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_early_model.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_late_model.dart';
import 'package:mediezy_doctor/Model/MessageShowModel/message_show_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/BetweenCustomSchedule/between_schedule_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/GetAllLate/get_all_late_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/LateCustomSchedule/late_schedule_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
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

  //* for late section
  late ValueNotifier<String> dropValueLateNotifier;
  String clinicLateId = "";
  late String selectedLateClinicId;
  List<HospitalDetails> clinicValuesLate = [];

  //* for early section
  late ValueNotifier<String> dropValueEarlyNotifier;
  String clinicEarlyId = "";
  late String selectedEarlyClinicId;
  List<HospitalDetails> clinicValuesEarly = [];

  //* for between section
  late ValueNotifier<String> dropValueBreakNotifier;
  String clinicBreakId = "";
  late String selectedBreakClinicId;
  List<HospitalDetails> clinicValuesBreak = [];

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

  @override
  void initState() {
    super.initState();

    selectedLateValue = items['Schedule 1'];
    selectedEarlyValue = items['Schedule 1'];
    selectedBreakValue = items['Schedule 1'];
    tabFirstController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Custom Schedule",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
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
                controller: tabFirstController,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                dividerColor: kCardColor,
                unselectedLabelColor: kTextColor,
                unselectedLabelStyle: TextStyle(
                  fontSize: 13.sp,
                ),
                labelStyle: TextStyle(
                  fontSize: 15.sp,
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
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        BlocBuilder<GetClinicBloc, GetClinicState>(
                          builder: (context, state) {
                            if (state is GetClinicLoaded) {
                              clinicGetModel =
                                  BlocProvider.of<GetClinicBloc>(context)
                                      .clinicGetModel;
                              if (clinicValuesLate.isEmpty) {
                                clinicValuesLate
                                    .addAll(clinicGetModel.hospitalDetails!);
                                dropValueLateNotifier = ValueNotifier(
                                    clinicValuesLate.first.clinicName!);
                                clinicLateId =
                                    clinicValuesLate.first.clinicId.toString();
                                selectedLateClinicId =
                                    clinicValuesLate.first.clinicId.toString();
                              }
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllLate(clinicId: selectedLateClinicId));
                              return Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: kCardColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xFF9C9C9C))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Center(
                                    child: ValueListenableBuilder(
                                      valueListenable: dropValueLateNotifier,
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
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          onChanged: (String? value) {
                                            dropValue = value!;
                                            dropValueLateNotifier.value = value;
                                            clinicLateId = value;
                                            selectedLateClinicId =
                                                clinicValuesLate
                                                    .where((element) => element
                                                        .clinicName!
                                                        .contains(value))
                                                    .toList()
                                                    .first
                                                    .clinicId
                                                    .toString();
                                            BlocProvider.of<GetAllLateBloc>(
                                                    context)
                                                .add(FetchAllLate(
                                                    clinicId:
                                                        selectedLateClinicId));
                                          },
                                          items: clinicValuesLate
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              value: value.clinicName!,
                                              child: Text(value.clinicName!),
                                            );
                                          }).toList(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    GeneralServices.instance.selectDate(
                                      context: context,
                                      date: lateDate,
                                      onDateSelected: (DateTime picked) {
                                        setState(() {
                                          lateDate = picked;
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kSubTextColor),
                                      ),
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyy').format(lateDate),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                ),
                              ],
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
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: kTextColor),
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
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: lateTimeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14.sp, color: kSubTextColor),
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
                              Future.delayed(const Duration(seconds: 3), () {});
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllLate(clinicId: selectedLateClinicId));
                            }
                            if (state is LateScheduleError) {
                              GeneralServices.instance.showErrorMessage(
                                  context, state.errorMessage);
                            }
                          },
                          child: CommonButtonWidget(
                            title: "Apply",
                            onTapFunction: () {
                              if (lateTimeController.text.isEmpty) {
                                GeneralServices.instance.showErrorMessage(
                                    context, "Please fill your late time");
                              }
                              BlocProvider.of<LateScheduleBloc>(context)
                                  .add(AddLateSchedule(
                                date: DateFormat('yyy-MM-dd').format(lateDate),
                                clinicId: selectedLateClinicId,
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
                                  FetchAllLate(clinicId: selectedLateClinicId));
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: kSubTextColor),
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
                                            clinicId: selectedLateClinicId,
                                            scheduleId: getAllLateModel
                                                .data![index].rescheduleId
                                                .toString(),
                                            section: 'late',
                                            onPressed: () {
                                              GeneralServices.instance
                                                  .appCloseDialogue(context,
                                                      "Are you sure you want to delete ?",
                                                      () {
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
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        BlocBuilder<GetClinicBloc, GetClinicState>(
                          builder: (context, state) {
                            if (state is GetClinicLoaded) {
                              clinicGetModel =
                                  BlocProvider.of<GetClinicBloc>(context)
                                      .clinicGetModel;
                              if (clinicValuesEarly.isEmpty) {
                                clinicValuesEarly
                                    .addAll(clinicGetModel.hospitalDetails!);
                                dropValueEarlyNotifier = ValueNotifier(
                                    clinicValuesEarly.first.clinicName!);
                                clinicEarlyId =
                                    clinicValuesEarly.first.clinicId.toString();
                                selectedEarlyClinicId =
                                    clinicValuesEarly.first.clinicId.toString();
                              }
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllEarly(
                                      clinicId: selectedEarlyClinicId));
                              return Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: kCardColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xFF9C9C9C))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Center(
                                    child: ValueListenableBuilder(
                                      valueListenable: dropValueEarlyNotifier,
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
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          onChanged: (String? value) {
                                            dropValue = value!;
                                            dropValueEarlyNotifier.value =
                                                value;
                                            clinicEarlyId = value;
                                            selectedEarlyClinicId =
                                                clinicValuesEarly
                                                    .where((element) => element
                                                        .clinicName!
                                                        .contains(value))
                                                    .toList()
                                                    .first
                                                    .clinicId
                                                    .toString();
                                            BlocProvider.of<GetAllLateBloc>(
                                                    context)
                                                .add(FetchAllEarly(
                                                    clinicId:
                                                        selectedEarlyClinicId));
                                          },
                                          items: clinicValuesEarly
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              value: value.clinicName!,
                                              child: Text(value.clinicName!),
                                            );
                                          }).toList(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    GeneralServices.instance.selectDate(
                                      context: context,
                                      date: earlyDate,
                                      onDateSelected: (DateTime picked) {
                                        setState(() {
                                          earlyDate = picked;
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kSubTextColor),
                                      ),
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyy').format(earlyDate),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                ),
                              ],
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
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: kTextColor),
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
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        TextFormField(
                          cursorColor: kMainColor,
                          controller: earlyTimeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14.sp, color: kSubTextColor),
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
                                      clinicId: selectedEarlyClinicId));
                            }
                            if (state is EarlyScheduleError) {
                              GeneralServices.instance.showErrorMessage(
                                  context, state.errorMessage);
                            }
                          },
                          child: CommonButtonWidget(
                              title: "Apply",
                              onTapFunction: () {
                                if (earlyTimeController.text.isEmpty) {
                                  GeneralServices.instance.showErrorMessage(
                                      context, "Please fill your early time");
                                }
                                BlocProvider.of<LateScheduleBloc>(context)
                                    .add(AddEarlySchedule(
                                  date:
                                      DateFormat('yyy-MM-dd').format(earlyDate),
                                  clinicId: selectedEarlyClinicId,
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
                                      clinicId: selectedEarlyClinicId));
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: kSubTextColor),
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
                                            clinicId: selectedEarlyClinicId,
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
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                // const VerticalSpacingWidget(height: 5),
                                //! select clinic
                                BlocBuilder<GetClinicBloc, GetClinicState>(
                                  builder: (context, state) {
                                    if (state is GetClinicLoaded) {
                                      clinicGetModel =
                                          BlocProvider.of<GetClinicBloc>(
                                                  context)
                                              .clinicGetModel;
                                      if (clinicValuesBreak.isEmpty) {
                                        clinicValuesBreak.addAll(
                                            clinicGetModel.hospitalDetails!);
                                        dropValueBreakNotifier = ValueNotifier(
                                            clinicValuesBreak
                                                .first.clinicName!);
                                        clinicBreakId = clinicValuesBreak
                                            .first.clinicId
                                            .toString();
                                        selectedBreakClinicId =
                                            clinicValuesBreak.first.clinicId
                                                .toString();
                                      }
                                      BlocProvider.of<GetAllLateBloc>(context)
                                          .add(FetchAllBreak(
                                              clinicId: selectedBreakClinicId));
                                      return Container(
                                        height: 40.h,
                                        width: 180.w,
                                        decoration: BoxDecoration(
                                            color: kCardColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFF9C9C9C))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Center(
                                            child: ValueListenableBuilder(
                                              valueListenable:
                                                  dropValueBreakNotifier,
                                              builder: (BuildContext context,
                                                  String dropValue, _) {
                                                return DropdownButtonFormField(
                                                  iconEnabledColor: kMainColor,
                                                  decoration:
                                                      const InputDecoration
                                                          .collapsed(
                                                          hintText: ''),
                                                  value: dropValue,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: kTextColor),
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  onChanged: (String? value) {
                                                    dropValue = value!;
                                                    dropValueBreakNotifier
                                                        .value = value;
                                                    clinicBreakId = value;
                                                    selectedBreakClinicId =
                                                        clinicValuesBreak
                                                            .where((element) =>
                                                                element
                                                                    .clinicName!
                                                                    .contains(
                                                                        value))
                                                            .toList()
                                                            .first
                                                            .clinicId
                                                            .toString();
                                                    BlocProvider.of<
                                                                GetAllLateBloc>(
                                                            context)
                                                        .add(FetchAllBreak(
                                                            clinicId:
                                                                selectedBreakClinicId));
                                                  },
                                                  items: clinicValuesBreak.map<
                                                      DropdownMenuItem<
                                                          String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.clinicName!,
                                                      child: Text(
                                                          value.clinicName!),
                                                    );
                                                  }).toList(),
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
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Schedule",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                Container(
                                  height: 40.h,
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
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    GeneralServices.instance.selectDate(
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
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kSubTextColor),
                                      ),
                                      IconButton(
                                        onPressed: () {
                              Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: startBreakDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              startBreakDate =
                                                                  picked;
                                                                   endBreakDate = picked;
                                                            });
                                                          },
                                                        )
                                                      :              GeneralServices.instance.selectDate(
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
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                  DateFormat('dd-MM-yyy')
                                      .format(startBreakDate),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                               Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: endBreakDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              endBreakDate =
                                                                  picked;
                                                            });
                                                          },
                                                        )
                                                      :       GeneralServices.instance.selectDate(
                                      context: context,
                                      date: endBreakDate,
                                      onDateSelected: (DateTime picked) {
                                        setState(() {
                                          endBreakDate = picked;
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "End Date",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kSubTextColor),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                    Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: endBreakDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              endBreakDate =
                                                                  picked;
                                                            });
                                                          },
                                                        )
                                                      :            GeneralServices.instance.selectDate(
                                            context: context,
                                            date: endBreakDate,
                                            onDateSelected: (DateTime picked) {
                                              setState(() {
                                                endBreakDate = picked;
                                              });
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          color: kMainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                  DateFormat('dd-MM-yyy').format(endBreakDate),
                                ),
                              ],
                            ),
                          ],
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        Text(
                          "Select Break Time",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //! starting time
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Starting Time",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextColor),
                                    ),
                                    Icon(
                                      IconlyLight.timeCircle,
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
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //! ending time
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Ending Time",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextColor),
                                    ),
                                    Icon(
                                      IconlyLight.timeCircle,
                                      color: kMainColor,
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
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kTextColor),
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
                                            clinicId: selectedBreakClinicId));
                                  });
                                }
                                if (state is BetweenScheduleError) {
                                  GeneralServices.instance.showErrorMessage(
                                      context,
                                      "No matching token details found");
                                  // No need to delay if an error occurs
                                }
                              },
                              child: CommonButtonWidget(
                                title: "Apply",
                                onTapFunction: () {
                                  BlocProvider.of<BetweenScheduleBloc>(context)
                                      .add(FetchBetweenSchedule(
                                    clinicId: selectedBreakClinicId,
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
                                  context, "Delete your Break Successfully");
                              BlocProvider.of<GetAllLateBloc>(context).add(
                                  FetchAllBreak(
                                      clinicId: selectedBreakClinicId));
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                          color: kSubTextColor),
                                    ),
                                    VerticalSpacingWidget(height: 5.h),
                                    SizedBox(
                                      height: 230.h,
                                      child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 50.h,
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
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
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  kTextColor),
                                                        ),
                                                        Text(
                                                          "Schedule ${getAllBreakModel.data![index].scheduleType.toString()} :${getAllBreakModel.data![index].breakStartTime} - ${getAllBreakModel.data![index].breakEndTime}",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  kTextColor),
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

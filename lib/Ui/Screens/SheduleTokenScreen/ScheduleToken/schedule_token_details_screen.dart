// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GenerateToken/generated_schedules.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GenerateTokenFinal/generate_token_final_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/generated_schedules/generated_schedules_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/ScheduleToken/schedule_help_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:sqflite/sqflite.dart';
import '../../../CommonWidgets/short_names_widget.dart';

class ScheduleTokenDetailsScreen extends StatefulWidget {
  const ScheduleTokenDetailsScreen({super.key});

  @override
  State<ScheduleTokenDetailsScreen> createState() =>
      _ScheduleTokenDetailsScreenState();
}

class _ScheduleTokenDetailsScreenState
    extends State<ScheduleTokenDetailsScreen> {
  final TextEditingController timeDuration1Controller = TextEditingController();

  final FocusNode timeDurationFocusController = FocusNode();

  DateTime startSchedule1Date = DateTime.now();

  DateTime selectedDate11 = DateTime.now();

  DateTime endScheduleDate = DateTime.now().add(const Duration(days: 30));

  TimeOfDay selectedSchedule1StartingTime = TimeOfDay.now();
  TimeOfDay selectedSchedule1EndingTime = TimeOfDay.now();

  Map<String, bool> checkboxData = {};

  List<String> getSelectedDays(Map<String, bool> checkboxData) {
    List<String> selectedDays = [];
    checkboxData.forEach((day, isSelected) {
      if (isSelected) {
        selectedDays.add(day);
      }
    });
    return selectedDays;
  }

  int tokenCount = 0;
  List<String> tokenDetails = [];

  final List<String> _days1 = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final List<String> _selectedDays1 = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // ignore: unused_element
  void _handleCheckboxChange1(String day, bool isChecked) {
    setState(() {
      if (isChecked) {
        _selectedDays1.add(day);
        FocusScope.of(context).requestFocus(FocusNode());
      } else {
        _selectedDays1.remove(day);
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Schedule 1';
  late int? selectedValue;

  late DateTime selectedDate;

  String? selectedDateString;

  final items = {
    'Schedule 1': 1,
    'Schedule 2': 2,
    'Schedule 3': 3,
  };

  late ClinicGetModel clinicGetModel;

  final HospitalController dController = Get.put(HospitalController());

  bool generateToken1 = false;

  @override
  void initState() {
    BlocProvider.of<GeneratedSchedulesBloc>(context)
        .add(FetchGeneratedSchedules());
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    selectedValue = items['Schedule 1'];
    DateTime currentDate = DateTime.now();
    DateTime initialDate = currentDate.add(const Duration(days: 30));
    selectedDateString = DateFormat('dd-MM-yyyy').format(initialDate);
    selectedDate = DateTime.now();
    fetchSelectedStartingTime();
    fetchSelectedEndingTime();

    setState(() {
      // ignore: avoid_function_literals_in_foreach_calls
      _days1.forEach((day) {
        if (day != 'Sunday') {
          checkboxData[day] = true;
        }
      });
    });

    fetchCheckboxData().then((data) {
      setState(() {
        checkboxData.addAll(data);
      });
    });
    super.initState();
  }

  void _handleCheckboxChange(String label, bool newValue) {
    setState(() {
      checkboxData[label] = newValue;
    });
    saveCheckboxData(label, newValue);
  }

  @override
  void dispose() {
    timeDuration1Controller.dispose();
    timeDurationFocusController.dispose();
    super.dispose();
  }

  int bookLength = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> selectedDays = getSelectedDays(checkboxData);
    return Scaffold(
      backgroundColor: kCardColor,
      appBar: appBarMethod(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child:
                    //   BlocBuilder<GeneratedSchedulesBloc, GeneratedSchedulesState>(
                    // builder: (context, states) {
                    //   if (states is GeneratedSchedulesLoaded) {
                    //     return
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! first section (Daily shedule)
                    Container(
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VerticalSpacingWidget(height: 10),
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
                                    //! select clinic
                                    GetBuilder<HospitalController>(
                                        builder: (clx) {
                                      return CustomDropDown(
                                        width: 195.w,
                                        value: dController.initialIndex.value,
                                        items: dController.hospitalDetails!
                                            .map((e) {
                                          return DropdownMenuItem(
                                            value: e.clinicId.toString(),
                                            child: Text(e.clinicName!),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          log(newValue!);
                                          dController.dropdownValueChanging(
                                              newValue,
                                              dController.initialIndex.value);
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color(0xFF9C9C9C))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Center(
                                          child: DropdownButtonFormField(
                                            iconEnabledColor: kMainColor,
                                            decoration:
                                                const InputDecoration.collapsed(
                                                    hintText: ''),
                                            value: dropdownValue,
                                            style: size.width > 450
                                                ? blackTabMainText
                                                : blackMainText,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items.entries.map(
                                                (MapEntry<String, int> entry) {
                                              return DropdownMenuItem(
                                                value: entry.key,
                                                child: Text(entry.key),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              dropdownValue = newValue!;
                                              selectedValue = items[newValue];
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
                            const VerticalSpacingWidget(height: 5),
                            startEndDatePicker(size),

                            const VerticalSpacingWidget(height: 10),
                            //! select starting and ending time
                            startEndeTimePicker(size, context),
                            const VerticalSpacingWidget(height: 10),

                            Row(
                              children: [
                                //! time Duration
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time Duration",
                                        style: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const VerticalSpacingWidget(height: 5),
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a number';
                                            }
                                            if (int.tryParse(value) == null) {
                                              return 'Please enter a valid number';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                           
                                              fontSize: size.width > 450
                                                  ? 10.sp
                                                  : 14.sp),
                                          // autofocus: true,
                                          cursorColor: kMainColor,
                                          controller: timeDuration1Controller,
                                          keyboardType: TextInputType.number,
                                          textInputAction:
                                              TextInputAction.done,
                                          focusNode:
                                              timeDurationFocusController,
                                          decoration: InputDecoration(
                                            hintStyle: size.width > 450
                                                ? greyTab10B600
                                                : grey13B600,
                                            hintText: "10 min",
                                            filled: true,
                                            fillColor: kCardColor,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kMainColor)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: kMainColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const HorizontalSpacingWidget(width: 5),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 10),
                            //! select days
                            Text(
                              "Select Days",
                              style:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
                            ),
                            const VerticalSpacingWidget(height: 5),
                            //! sunday monday tuesday
                            selectDaysCheckBox(context, selectedDays, size),
                            BlocConsumer<GenerateTokenFinalBloc,
                                GenerateTokenFinalState>(
                              listener: (context, state) {
                                if (state is GenerateTokenFinalError) {
                                  log(state.errorMessage);
                                  GeneralServices.instance.showErrorMessage(
                                      context, state.errorMessage);
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    Navigator.pop(context);
                                  });
                                }
                                // final size = MediaQuery.of(context).size;
                                //  if (timeDuration1Controller.text=="") {
                                //                      GeneralServices.instance.showErrorMessage(
                                // context, 'The each token duration field is required');
                                // Future.delayed(const Duration(seconds: 3),
                                //     () {
                                //   Navigator.pop(context);
                                // });
                                //                   }
                                if (state is GenerateTokenFinalLoaded) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // Avoid potential overflow
                                          children: [
                                            Lottie.asset(
                                                "assets/animations/confirm booking.json",
                                                height: 120.h),
                                            const SizedBox(height: 10.0),
                                            Text(
                                              state.successMessage,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Text(
                                              'Note: Check the booking section to see how this shows to patients',
                                              style: TextStyle(fontSize: 13.sp),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  Future.delayed(const Duration(seconds: 5),
                                      () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationControlWidget(
                                                  selectedIndex: 2)),
                                      (route) => false,
                                    );
                                  });
                                }
                              },
                              builder: (context, state) {
                                bool isLoading =
                                    state is GenerateTokenFinalLoading;
                                return SizedBox(
                                  height: Platform.isIOS
                                      ? size.height * 0.107
                                      : size.height * 0.08,
                                  child: Column(
                                    children: [
                                      BlocBuilder<GeneratedSchedulesBloc,
                                          GeneratedSchedulesState>(
                                        builder: (context, states) {
                                          if (states
                                              is GeneratedSchedulesLoaded) {
                                            return InkWell(
                                              onTap: isLoading
                                                  ? null
                                                  : () {
                                                      bool isValid = _formKey
                                                          .currentState!
                                                          .validate();

                                                      if (isValid) {
                                                        if (timeDuration1Controller
                                                                .text ==
                                                            "") {
                                                          GeneralServices
                                                              .instance
                                                              .showErrorMessage(
                                                                  context,
                                                                  'The each token duration field is required');
                                                        } else {
                                                          Schedules?
                                                              matchingSchedule;

                                                          try {
                                                            matchingSchedule =
                                                                states
                                                                    .generatedSchedulesModel
                                                                    .schedules!
                                                                    .firstWhere(
                                                              (e) =>
                                                                  e.clinicId ==
                                                                      int.parse(dController
                                                                          .initialIndex
                                                                          .value) &&
                                                                  e.scheduleType ==
                                                                      selectedValue,
                                                            );
                                                          } catch (e) {
                                                            matchingSchedule =
                                                                null;
                                                          }
                                                          if (matchingSchedule !=
                                                              null) {
                                                            bookLength =
                                                                matchingSchedule
                                                                    .bookingCount!;
                                                            if (bookLength >
                                                                0) {
                                                              GeneralServices()
                                                                  .appCloseDialogue(
                                                                context,
                                                                "You have bookings on this schedule, which may be lost if you change it. Are you sure you want to change the schedule?",
                                                                () {
                                                                  BlocProvider.of<
                                                                              GenerateTokenFinalBloc>(
                                                                          context)
                                                                      .add(
                                                                    FetchGenerateTokenFinal(
                                                                      clinicId: dController
                                                                          .initialIndex
                                                                          .value,
                                                                      selecteddays:
                                                                          selectedDays,
                                                                      startDate:
                                                                          '${startSchedule1Date.year}-${startSchedule1Date.month}-${startSchedule1Date.day}',
                                                                      endDate:
                                                                          '${endScheduleDate.year}-${endScheduleDate.month}-${endScheduleDate.day}',
                                                                      startTime:
                                                                          formatTimeOfDay(
                                                                              selectedSchedule1StartingTime),
                                                                      endTime:
                                                                          formatTimeOfDay(
                                                                              selectedSchedule1EndingTime),
                                                                      timeDuration:
                                                                          timeDuration1Controller
                                                                              .text,
                                                                      scheduleType:
                                                                          selectedValue
                                                                              .toString(),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              log("=================== $bookLength catched");
                                                              BlocProvider.of<
                                                                          GenerateTokenFinalBloc>(
                                                                      context)
                                                                  .add(
                                                                FetchGenerateTokenFinal(
                                                                  clinicId:
                                                                      dController
                                                                          .initialIndex
                                                                          .value,
                                                                  selecteddays:
                                                                      selectedDays,
                                                                  startDate:
                                                                      '${startSchedule1Date.year}-${startSchedule1Date.month}-${startSchedule1Date.day}',
                                                                  endDate:
                                                                      '${endScheduleDate.year}-${endScheduleDate.month}-${endScheduleDate.day}',
                                                                  startTime:
                                                                      formatTimeOfDay(
                                                                          selectedSchedule1StartingTime),
                                                                  endTime:
                                                                      formatTimeOfDay(
                                                                          selectedSchedule1EndingTime),
                                                                  timeDuration:
                                                                      timeDuration1Controller
                                                                          .text,
                                                                  scheduleType:
                                                                      selectedValue
                                                                          .toString(),
                                                                ),
                                                              );
                                                            }

                                                            log("Matching schedule found. Booking count: $bookLength");
                                                          } else {
                                                            BlocProvider.of<
                                                                        GenerateTokenFinalBloc>(
                                                                    context)
                                                                .add(
                                                              FetchGenerateTokenFinal(
                                                                clinicId:
                                                                    dController
                                                                        .initialIndex
                                                                        .value,
                                                                selecteddays:
                                                                    selectedDays,
                                                                startDate:
                                                                    '${startSchedule1Date.year}-${startSchedule1Date.month}-${startSchedule1Date.day}',
                                                                endDate:
                                                                    '${endScheduleDate.year}-${endScheduleDate.month}-${endScheduleDate.day}',
                                                                startTime:
                                                                    formatTimeOfDay(
                                                                        selectedSchedule1StartingTime),
                                                                endTime:
                                                                    formatTimeOfDay(
                                                                        selectedSchedule1EndingTime),
                                                                timeDuration:
                                                                    timeDuration1Controller
                                                                        .text,
                                                                scheduleType:
                                                                    selectedValue
                                                                        .toString(),
                                                              ),
                                                            );
                                                            bookLength = 0;
                                                            log("No matching schedule found. Current bookLength: $bookLength");
                                                          }
                                                        }
                                                        // }else{
                                                        //  GeneralServices.instance.showErrorMessage(context, "Time duration contain only degits ");
                                                      }

                                                      // if (states
                                                      //     .generatedSchedulesModel
                                                      //     .schedules!
                                                      //     .isNotEmpty) {

                                                      //   if (states
                                                      //       .generatedSchedulesModel
                                                      //       .schedules!
                                                      //       .any((e) =>
                                                      //           e.clinicId ==
                                                      //               int.parse(dController
                                                      //                   .initialIndex
                                                      //                   .value) &&
                                                      //           e.scheduleType ==
                                                      //               selectedValue)) {
                                                      //     log("-------------------- $bookLength");
                                                      //   } else {
                                                      //     log("================= $bookLength");
                                                      //   }
                                                      // }

                                                      // else {
                                                      //   log("==============lllllll============= $bookLength");

                                                      //   log('klfjdklsdfjklsdfjkldsf');
                                                      // }
                                                    },
                                              child: Container(
                                                width: double.infinity,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  color: kMainColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: isLoading
                                                    ? Center(
                                                        child: LoadingAnimationWidget
                                                            .staggeredDotsWave(
                                                                color: Colors
                                                                    .white,
                                                                size: 30))
                                                    : Center(
                                                        child: Text(
                                                          "Generate token",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.width >
                                                                          450
                                                                      ? 12.sp
                                                                      : 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const VerticalSpacingWidget(height: 5),
                            BlocListener<GeneratedSchedulesBloc,
                                GeneratedSchedulesState>(
                              listener: (context, state) {
                                if (state is DeleteSchedulesLoaded) {
                                  BlocProvider.of<GeneratedSchedulesBloc>(
                                          context)
                                      .add(FetchGeneratedSchedules());
                                }
                                if (state is DeleteSchedulesError) {
                                  GeneralServices.instance
                                      .showToastMessage(state.errorMessage);
                                }
                              },
                              child: BlocBuilder<GeneratedSchedulesBloc,
                                  GeneratedSchedulesState>(
                                builder: (context, state) {
                                  if (state is GeneratedSchedulesLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is GeneratedSchedulesError) {
                                    return const Center(
                                      child: Text("Something went wrong"),
                                    );
                                  } else if (state
                                      is GeneratedSchedulesLoaded) {
                                    final model = state.generatedSchedulesModel;

                                    if (model.schedules == null) {
                                      return Container();
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Generated schedules",
                                          style: size.width > 450
                                              ? greyTab10B600
                                              : grey13B600,
                                        ),
                                        const VerticalSpacingWidget(height: 3),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: model.schedules!.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                          itemBuilder: (context, index) {
                                            final schedule =
                                                model.schedules![index];
                                            bookLength = model.schedules![index]
                                                .bookingCount!;

                                            String formattedStartDate =
                                                DateFormat('dd-MM-yyyy').format(
                                                    DateFormat('yyyy-MM-dd')
                                                        .parse(schedule
                                                            .startDate
                                                            .toString()));

                                            String formattedEndDate =
                                                DateFormat('dd-MM-yyyy').format(
                                                    DateFormat('yyyy-MM-dd')
                                                        .parse(schedule.endDate
                                                            .toString()));
                                            return SingleChildScrollView(
                                              child: Card(
                                                color: const Color.fromARGB(
                                                    255, 243, 247, 250),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.w,
                                                      bottom: 6.h,
                                                      top: 6.h),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              schedule
                                                                  .clinicName
                                                                  .toString(),
                                                              style: size.width >
                                                                      450
                                                                  ? blackTabMainText
                                                                  : blackMainText,
                                                            ),
                                                            // ShortNamesWidget(
                                                            //   typeId: 1,
                                                            //   firstText:
                                                            //       " Booking count : ",
                                                            //   secondText:
                                                            //       "count ${schedule.bookingCount}",
                                                            // ),
                                                            ShortNamesWidget(
                                                              typeId: 1,
                                                              firstText:
                                                                  "schedule type : ",
                                                              secondText:
                                                                  "schedule ${schedule.scheduleType}",
                                                            ),
                                                            ShortNamesWidget(
                                                              typeId: 1,
                                                              firstText:
                                                                  "Date : ",
                                                              secondText:
                                                                  "$formattedStartDate  to  $formattedEndDate",
                                                            ),
                                                            ShortNamesWidget(
                                                              typeId: 1,
                                                              firstText:
                                                                  "Time : ",
                                                              secondText:
                                                                  "${schedule.startTime} to ${schedule.endTime}",
                                                            ),
                                                            ShortNamesWidget(
                                                              typeId: 1,
                                                              firstText:
                                                                  "Time duration : ",
                                                              secondText: schedule
                                                                  .eachTokenDuration
                                                                  .toString(),
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Days : ",
                                                                  style: size.width >
                                                                          450
                                                                      ? greyTabMain
                                                                      : greyMain,
                                                                ),
                                                                SizedBox(
                                                                  width: 240.w,
                                                                  child: Text(
                                                                    schedule
                                                                        .selectedDays
                                                                        .toString(),
                                                                    maxLines: 3,
                                                                    style: size.width >
                                                                            450
                                                                        ? blackTabMainText
                                                                        : blackMainText,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            GeneralServices()
                                                                .appCloseDialogue(
                                                              context,
                                                              "You have bookings on this schedule, which may be lost if you delete it. Are you sure you want to delete the schedule ?",
                                                              () {
                                                                BlocProvider.of<
                                                                            GeneratedSchedulesBloc>(
                                                                        context)
                                                                    .add(DeleteGeneratedSchedules(
                                                                        scheduleId: schedule
                                                                            .scheduleId
                                                                            .toString()));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          },
                                                          child: const Icon(
                                                              CupertinoIcons
                                                                  .delete),
                                                        )
                                                        // Column(
                                                        //   children: [
                                                        //     PopupMenuButton(
                                                        //       iconSize:
                                                        //           size.width > 450
                                                        //               ? 14.sp
                                                        //               : 20.sp,
                                                        //       icon: Icon(
                                                        //         Icons.more_vert,
                                                        //         color: kMainColor,
                                                        //       ),
                                                        //       itemBuilder: (context) =>
                                                        //           <PopupMenuEntry<
                                                        //               dynamic>>[
                                                        //         PopupMenuItem(
                                                        //           onTap: () {
                                                        //             GeneralServices
                                                        //                 .instance
                                                        //                 .appCloseDialogue(
                                                        //               context,
                                                        //               "Are you sure want to delete this schedule?",
                                                        //               () {
                                                        // BlocProvider.of<GeneratedSchedulesBloc>(context).add(DeleteGeneratedSchedules(
                                                        //     scheduleId: schedule
                                                        //         .scheduleId
                                                        //         .toString()));
                                                        // Navigator.pop(
                                                        //     context);
                                                        //               },
                                                        //             );
                                                        //           },
                                                        //           child: Text(
                                                        //             "Delete",
                                                        //             style: size.width >
                                                        //                     450
                                                        //                 ? blackTabMainText
                                                        //                 : blackMainText,
                                                        //             overflow:
                                                        //                 TextOverflow
                                                        //                     .ellipsis,
                                                        //           ),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                //   } else {
                //     return const Center(
                //       child: Text("Unexpected state"),
                //     );
                //   }
                // },
                // ),
                ),
          ),
        ),
      ),
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      backgroundColor: kCardColor,
      centerTitle: true,
      title: const Text(
        "Schedule Token",
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const ScheduleHelpScreen(
                            clinicName: "",
                          )));
            },
            icon: const Icon(Icons.help_outline))
      ],
    );
  }

  Padding selectDaysCheckBox(
      BuildContext context, List<String> selectedDays, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .12,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 5,
          ),
          itemCount: _days1.length,
          itemBuilder: (context, index) {
            log("$selectedDays");
            final day = _days1[index];
            final isChecked = checkboxData[day] ?? false;
            return GestureDetector(
              onTap: () => _handleCheckboxChange(day, !isChecked),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                    child: Transform.scale(
                      scale: size.width > 450 ? 1.5 : 0.9,
                      child: Checkbox(
                        activeColor: kMainColor,
                        value: isChecked,
                        onChanged: (value) =>
                            _handleCheckboxChange(day, value ?? false),
                      ),
                    ),
                  ),
                  const HorizontalSpacingWidget(width: 10),
                  SizedBox(
                    width: 68.w,
                    child: Text(
                      day,
                      style: size.width > 450 ? blackTabMainText : black12B500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Row timeDurationForm(Size size) {
  //   return Row(
  //     children: [
  //       //! time Duration
  //       Expanded(
  //         flex: 3,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Time Duration",
  //               style: size.width > 450 ? greyTab10B600 : grey13B600,
  //             ),
  //             const VerticalSpacingWidget(height: 5),
  //             Form(
  //               key: _formKey,
  //               child: SizedBox(
  //                 height: 40.h,
  //                 child: TextFormField(
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter a number';
  //                     }
  //                     if (int.tryParse(value) == null) {
  //                       return 'Please enter a valid number';
  //                     }
  //                     return null;
  //                   },
  //                   style:
  //                       TextStyle(fontSize: size.width > 450 ? 10.sp : 14.sp),
  //                   // autofocus: true,
  //                   cursorColor: kMainColor,
  //                   controller: timeDuration1Controller,
  //                   inputFormatters: [
  //                     FilteringTextInputFormatter.digitsOnly,
  //                     _RemoveNonDigitsFormatter(),
  //                   ],
  //                   keyboardType: TextInputType.phone,
  //                   textInputAction: TextInputAction.done,
  //                   focusNode: timeDurationFocusController,
  //                   decoration: InputDecoration(
  //                     hintStyle: size.width > 450 ? greyTab10B600 : grey13B600,
  //                     hintText: "10 min",
  //                     filled: true,
  //                     fillColor: kCardColor,
  //                     enabledBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color: kMainColor)),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(7),
  //                       borderSide: BorderSide(color: kMainColor),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const HorizontalSpacingWidget(width: 5),
  //     ],
  //   );
  // }

  Row startEndeTimePicker(Size size, BuildContext context) {
    return Row(
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
                  style: size.width > 450 ? greyTab10B600 : grey13B600,
                ),
                const HorizontalSpacingWidget(width: 5),
                Icon(
                  IconlyLight.timeCircle,
                  color: kMainColor,
                  size: size.width > 450 ? 12.sp : 18.sp,
                ),
              ],
            ),
            const VerticalSpacingWidget(height: 5),
            InkWell(
              onTap: () async {
                selectSchedule1StartingTime(context);
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
                    selectedSchedule1StartingTime.format(context),
                    style: size.width > 450 ? blackTabMainText : black14B600,
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
                  style: size.width > 450 ? greyTab10B600 : grey13B600,
                ),
                const HorizontalSpacingWidget(width: 5),
                Icon(
                  IconlyLight.timeCircle,
                  color: kMainColor,
                  size: size.width > 450 ? 12.sp : 18.sp,
                ),
              ],
            ),
            const VerticalSpacingWidget(height: 5),
            InkWell(
              onTap: () {
                selectSchedule1EndingTime(context);
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
                    selectedSchedule1EndingTime.format(context),
                    style: size.width > 450 ? blackTabMainText : black14B600,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row startEndDatePicker(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButtonTheme(
          data: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          child: Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Platform.isIOS
                    ? GeneralServices.instance.selectIosDate(
                        context: context,
                        date: startSchedule1Date,
                        onDateSelected: (DateTime picked) async {
                          setState(() {
                            startSchedule1Date = picked;
                            endScheduleDate =
                                picked.add(const Duration(days: 30));
                          });
                        },
                      )
                    : GeneralServices.instance.selectDate(
                        context: context,
                        date: startSchedule1Date,
                        onDateSelected: (DateTime picked) {
                          setState(() {
                            startSchedule1Date = picked;
                            endScheduleDate =
                                picked.add(const Duration(days: 30));
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
                        "Start Date",
                        style: size.width > 450 ? greyTab10B600 : grey13B600,
                      ),
                      IconButton(
                        onPressed: () {
                          Platform.isIOS
                              ? GeneralServices.instance.selectIosDate(
                                  context: context,
                                  date: startSchedule1Date,
                                  onDateSelected: (DateTime picked) async {
                                    setState(() {
                                      startSchedule1Date = picked;
                                      endScheduleDate =
                                          picked.add(const Duration(days: 30));
                                    });
                                  },
                                )
                              : GeneralServices.instance.selectDate(
                                  context: context,
                                  date: startSchedule1Date,
                                  onDateSelected: (DateTime picked) {
                                    setState(() {
                                      startSchedule1Date = picked;
                                      endScheduleDate =
                                          picked.add(const Duration(days: 30));
                                    });
                                  },
                                );
                        },
                        icon: Icon(
                          IconlyLight.calendar,
                          color: kMainColor,
                          size: size.width > 450 ? 12.sp : 19.sp,
                        ),
                      )
                    ],
                  ),
                  Text(
                    DateFormat("dd-MM-yyy").format(startSchedule1Date),
                    style: size.width > 450 ? blackTabMainText : black14B600,
                  ),
                ],
              ),
            );
          }),
        ),
        TextButtonTheme(
          data: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          child: Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Platform.isIOS
                    ? GeneralServices.instance.selectIosDate(
                        context: context,
                        date: endScheduleDate,
                        onDateSelected: (DateTime picked) async {
                          setState(() {
                            endScheduleDate = picked;
                          });
                        },
                      )
                    : GeneralServices.instance.selectDate(
                        context: context,
                        date: endScheduleDate,
                        onDateSelected: (DateTime picked) {
                          setState(() {
                            endScheduleDate = picked;
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
                        "End Date",
                        style: size.width > 450 ? greyTab10B600 : grey13B600,
                      ),
                      IconButton(
                        onPressed: () {
                          Platform.isIOS
                              ? GeneralServices.instance.selectIosDate(
                                  context: context,
                                  date: endScheduleDate,
                                  onDateSelected: (DateTime picked) async {
                                    setState(() {
                                      endScheduleDate = picked;
                                    });
                                  },
                                )
                              : GeneralServices.instance.selectDate(
                                  context: context,
                                  date: endScheduleDate,
                                  onDateSelected: (DateTime picked) {
                                    setState(() {
                                      endScheduleDate = picked;
                                    });
                                  },
                                );
                        },
                        icon: Icon(
                          IconlyLight.calendar,
                          color: kMainColor,
                          size: size.width > 450 ? 12.sp : 19.sp,
                        ),
                      )
                    ],
                  ),
                  Text(
                    DateFormat('dd-MM-yyy').format(endScheduleDate),
                    // Display the selected and formatted date
                    style: size.width > 450 ? blackTabMainText : black14B600,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

//! select schedule 1 starting time

  Future<void> selectSchedule1StartingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedSchedule1StartingTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: kCardColor,
              dayPeriodTextColor: kMainColor,
              dialHandColor: kMainColor,
              entryModeIconColor: kMainColor,
              inputDecorationTheme:
                  InputDecorationTheme(focusColor: kMainColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedSchedule1StartingTime) {
      setState(() {
        selectedSchedule1StartingTime = pickedTime;
      });

      // Save selected time to local database
      await saveStartingSelectedTime(selectedSchedule1StartingTime);
    }
  }

  //! select Schedule 1 Ending time

  Future<void> selectSchedule1EndingTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: selectedSchedule1EndingTime);
    if (pickedTime != null) {
      // setState(() {
      selectedSchedule1EndingTime = pickedTime;
      timeDurationFocusController.requestFocus(); // Focus on the text field
      // });
      await saveEndingSelectedTime(selectedSchedule1EndingTime);
    }
  }

  Future<void> createDatabase() async {
    // Open database
    // ignore: unused_local_variable
    final Database db = await openDatabase('your_database.db', version: 1,
        onCreate: (Database db, int version) async {
      // Create the tables for starting and ending times
      await db.execute(
        "CREATE TABLE starting_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
      );
      await db.execute(
        "CREATE TABLE ending_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)",
      );
    });
  }

  Future<void> fetchSelectedStartingTime() async {
    // Open database
    final Database db = await openDatabase('your_database.db');

    // Query database to get selected starting time
    final List<Map<String, dynamic>> maps = await db.query('starting_times');

    // Check if there is any data
    if (maps.isNotEmpty) {
      final Map<String, dynamic> map = maps.first;
      final TimeOfDay selectedTime =
          TimeOfDay(hour: map['hour'], minute: map['minute']);

      setState(() {
        selectedSchedule1StartingTime = selectedTime;
      });
    }
  }

  Future<void> fetchSelectedEndingTime() async {
    // Open database
    final Database db = await openDatabase('your_database.db');

    // Query database to get selected ending time
    final List<Map<String, dynamic>> maps = await db.query('ending_times');

    // Check if there is any data
    if (maps.isNotEmpty) {
      final Map<String, dynamic> map = maps.first;
      final TimeOfDay selectedTime =
          TimeOfDay(hour: map['hour'], minute: map['minute']);

      setState(() {
        selectedSchedule1EndingTime = selectedTime;
      });
    }
  }

  // Save selected starting time to the database
  Future<void> saveStartingSelectedTime(TimeOfDay selectedTime) async {
    final Database db = await openDatabase('your_database.db');

    await db.execute(
      'CREATE TABLE IF NOT EXISTS starting_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)',
    );

    await db.rawInsert(
      'INSERT OR REPLACE INTO starting_times (id, hour, minute) VALUES (?, ?, ?)',
      [1, selectedTime.hour, selectedTime.minute],
    );
  }

// Save selected ending time to the database
  Future<void> saveEndingSelectedTime(TimeOfDay selectedTime) async {
    final Database db = await openDatabase('your_database.db');

    await db.execute(
      'CREATE TABLE IF NOT EXISTS ending_times(id INTEGER PRIMARY KEY, hour INTEGER, minute INTEGER)',
    );

    await db.rawInsert(
      'INSERT OR REPLACE INTO ending_times (id, hour, minute) VALUES (?, ?, ?)',
      [1, selectedTime.hour, selectedTime.minute],
    );
  }

  // checkBox

  Future<void> saveCheckboxData(String label, bool isChecked) async {
    final Database db = await openDatabase('your_database.db');

    await db.execute(
      'CREATE TABLE IF NOT EXISTS checkbox_data(id INTEGER PRIMARY KEY, label TEXT, isChecked INTEGER)',
    );

    await db.rawInsert(
      'INSERT OR REPLACE INTO checkbox_data (label, isChecked) VALUES (?, ?)',
      [label, isChecked ? 1 : 0],
    );
  }

  Future<Map<String, bool>> fetchCheckboxData() async {
    final Database db = await openDatabase('your_database.db');

    final List<Map<String, dynamic>> maps = await db.query('checkbox_data');

    Map<String, bool> checkboxData = {};

    for (final map in maps) {
      checkboxData[map['label']] = map['isChecked'] == 1;
    }

    return checkboxData;
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

class _RemoveNonDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    return TextEditingValue(
      text: cleanedText,
      selection: TextSelection.collapsed(offset: cleanedText.length),
    );
  }
}

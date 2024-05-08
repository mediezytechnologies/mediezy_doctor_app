// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/GenerateTokenErrorModel.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GenerateTokenFinal/generate_token_final_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/ScheduleToken/schedule_help_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:sqflite/sqflite.dart';

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

  late GenerateTokenErrorModel generateTokenErrorModel;

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

  String dropdownValue = 'Schedule 1';
  late int? selectedValue;

  late DateTime selectedDate;

  String? selectedDateString;

  // late String selectedDateString;

  final items = {
    'Schedule 1': 1,
    'Schedule 2': 2,
    'Schedule 3': 3,
  };

  late ClinicGetModel clinicGetModel;

  // late ValueNotifier<String> dropValueClinicNotifier;
  // String clinicId = "";
  // late String selectedClinicId;
  // List<HospitalDetails> clinicValues = [];

  final HospitalController dController = Get.put(HospitalController());

  bool generateToken1 = false;

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    selectedValue = items['Schedule 1'];
    DateTime currentDate = DateTime.now();
    DateTime initialDate = currentDate.add(const Duration(days: 30));
    selectedDateString = DateFormat('dd-MM-yyyy').format(initialDate);
    selectedDate = DateTime.now();
    fetchSelectedStartingTime();
    fetchSelectedEndingTime();

    setState(() {
      _days1.forEach((day) {
        if (day != 'Sunday') {
          checkboxData[day] =
              true; // Set Monday to Saturday as initially selected
        }
      });
    });

    // Fetch checkbox data from the database
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> selectedDays = getSelectedDays(checkboxData);
    return Scaffold(
      backgroundColor: kCardColor,
      appBar: AppBar(
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
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: BlocListener<GenerateTokenFinalBloc, GenerateTokenFinalState>(
            listener: (context, state) {
              if (state is GenerateTokenFinalLoaded) {
                GeneralServices.instance
                    .showSuccessMessage(context, state.successMessage);
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  generateToken1 = true; // Change the button color to grey
                });
              }
              if (state is GenerateTokenFinalError) {
                GeneralServices.instance
                    .showErrorMessage(context, state.errorMessage);
                Future.delayed(const Duration(seconds: 3), () {
                  // Navigator.pop(context);
                });
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
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
                                      style: size.width > 400
                                          ? greyTab10B600
                                          : grey13B600,
                                    ),
                                    // const VerticalSpacingWidget(height: 5),
                                    //! select clinic
                                    GetBuilder<HospitalController>(
                                        builder: (clx) {
                                      return CustomDropDown(
                                        width: 195.w,
                                        value: dController.initialIndex,
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
                                              dController.initialIndex!);
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
                                      style: size.width > 400
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
                                            style: size.width > 400
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
                            Row(
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
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                        GeneralServices.instance.selectDate(
                                          context: context,
                                          date: startSchedule1Date,
                                          onDateSelected: (DateTime picked) {
                                            setState(() {
                                              startSchedule1Date = picked;
                                              // Update end date to be 30 days after the selected start date
                                              endScheduleDate = picked.add(
                                                  const Duration(days: 30));
                                            });
                                          },
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: size.width > 400
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date:
                                                              startSchedule1Date,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              startSchedule1Date =
                                                                  picked;
                                                              endScheduleDate =
                                                                  picked.add(
                                                                      const Duration(
                                                                          days:
                                                                              30));
                                                            });
                                                            // FocusScope.of(
                                                            //         context)
                                                            //     .requestFocus(
                                                            //         FocusNode());
                                                          },
                                                        )
                                                      : GeneralServices.instance
                                                          .selectDate(
                                                          context: context,
                                                          date:
                                                              startSchedule1Date,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) {
                                                            setState(() {
                                                              startSchedule1Date =
                                                                  picked;
                                                              endScheduleDate =
                                                                  picked.add(
                                                                      const Duration(
                                                                          days:
                                                                              30));
                                                            });
                                                          },
                                                        );
                                                },
                                                icon: Icon(
                                                  IconlyLight.calendar,
                                                  color: kMainColor,
                                                  size: size.width > 400
                                                      ? 12.sp
                                                      : 19.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyy")
                                                .format(startSchedule1Date),
                                            style: size.width > 400
                                                ? blackTabMainText
                                                : black14B600,
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
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () async {
                                        GeneralServices.instance.selectDate(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "End Date",
                                                style: size.width > 400
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: endScheduleDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              endScheduleDate =
                                                                  picked;
                                                            });
                                                          },
                                                        )
                                                      : GeneralServices.instance
                                                          .selectDate(
                                                          context: context,
                                                          date: endScheduleDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) {
                                                            setState(() {
                                                              endScheduleDate =
                                                                  picked;
                                                            });
                                                          },
                                                        );
                                                },
                                                icon: Icon(
                                                  IconlyLight.calendar,
                                                  color: kMainColor,
                                                  size: size.width > 400
                                                      ? 12.sp
                                                      : 19.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyy')
                                                .format(endScheduleDate),
                                            // Display the selected and formatted date
                                            style: size.width > 400
                                                ? blackTabMainText
                                                : black14B600,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 10),
                            //! select starting and ending time
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
                                          style: size.width > 400
                                              ? greyTab10B600
                                              : grey13B600,
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Icon(
                                          IconlyLight.timeCircle,
                                          color: kMainColor,
                                          size:
                                              size.width > 400 ? 12.sp : 18.sp,
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
                                            border:
                                                Border.all(color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(
                                          child: Text(
                                            selectedSchedule1StartingTime
                                                .format(context),
                                            style: size.width > 400
                                                ? blackTabMainText
                                                : black14B600,
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
                                          style: size.width > 400
                                              ? greyTab10B600
                                              : grey13B600,
                                        ),
                                        const HorizontalSpacingWidget(width: 5),
                                        Icon(
                                          IconlyLight.timeCircle,
                                          color: kMainColor,
                                          size:
                                              size.width > 400 ? 12.sp : 18.sp,
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
                                            border:
                                                Border.all(color: kMainColor),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(
                                          child: Text(
                                            selectedSchedule1EndingTime
                                                .format(context),
                                            style: size.width > 400
                                                ? blackTabMainText
                                                : black14B600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                                        style: size.width > 400
                                            ? greyTab10B600
                                            : grey13B600,
                                      ),
                                      const VerticalSpacingWidget(height: 5),
                                      SizedBox(
                                        height: 40.h,
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: size.width > 400
                                                  ? 10.sp
                                                  : 14.sp),
                                          // autofocus: true,
                                          cursorColor: kMainColor,
                                          controller: timeDuration1Controller,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          focusNode:
                                              timeDurationFocusController,
                                          decoration: InputDecoration(
                                            hintStyle: size.width > 400
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
                                              borderSide:
                                                  BorderSide(color: kMainColor),
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
                                  size.width > 400 ? greyTab10B600 : grey13B600,
                            ),
                            const VerticalSpacingWidget(height: 5),
                            //! sunday monday tuesday
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 0.0,
                                    childAspectRatio: 5,
                                  ),
                                  itemCount: _days1.length,
                                  itemBuilder: (context, index) {
                                    // log("$_selectedDays1");
                                    // log("$checkboxData");
                                    log("$selectedDays");
                                    final day = _days1[index];
                                    final isChecked =
                                        checkboxData[day] ?? false;
                                    return GestureDetector(
                                      onTap: () => _handleCheckboxChange(
                                          day, !isChecked),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10.w,
                                            child: Transform.scale(
                                              scale: size.width > 400
                                                  ? 1.5
                                                  : 0.9, // Adjust the scale factor as per your requirement
                                              child: Checkbox(
                                                activeColor: kMainColor,
                                                value: isChecked,
                                                onChanged: (value) =>
                                                    _handleCheckboxChange(
                                                        day, value ?? false),
                                              ),
                                            ),
                                          ),
                                          const HorizontalSpacingWidget(
                                              width: 10),
                                          SizedBox(
                                            width: 68.w,
                                            child: Text(
                                              day,
                                              style: size.width > 400
                                                  ? blackTabMainText
                                                  : black12B500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Container(color: kScaffoldColor,height: 2,width: mWidth*.99,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: CommonButtonWidget(
            title: "Generate token",
            onTapFunction: () {
              BlocProvider.of<GenerateTokenFinalBloc>(context)
                  .add(FetchGenerateTokenFinal(
                clinicId: dController.initialIndex!,
                selecteddays: selectedDays,
                startDate:
                    '${startSchedule1Date.year}-${startSchedule1Date.month}-${startSchedule1Date.day}',
                endDate:
                    '${endScheduleDate.year}-${endScheduleDate.month}-${endScheduleDate.day}',
                startTime: formatTimeOfDay(selectedSchedule1StartingTime),
                endTime: formatTimeOfDay(selectedSchedule1EndingTime),
                timeDuration: timeDuration1Controller.text,
                scheduleType: selectedValue.toString(),
              ));
            }),
      ),
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

  // Create a database with separate tables for starting and ending times
  Future<void> createDatabase() async {
    // Open database
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

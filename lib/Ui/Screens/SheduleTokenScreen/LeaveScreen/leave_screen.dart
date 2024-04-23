// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_leaves_model.dart';
import 'package:mediezy_doctor/Model/GetReservedTokensModel/GetReservedTokensModel.dart';
import 'package:mediezy_doctor/Model/leave_check_model/leave_check_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/GetAllLeaves/get_all_leaves_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/LeaveUpdate/leave_update_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/leave_check/leave_check_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import '../../../../Model/GenerateToken/clinic_get_model.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => LeaveScreenState();
}

class LeaveScreenState extends State<LeaveScreen> {
  late TabController tabSecondController;
  DateTime leaveStartDate = DateTime.now();
  DateTime leaveEndDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  late ClinicGetModel clinicGetModel;
  late GetAllLeavesModel getAllLeavesModel;
  late LeaveCheckModel leaveCheckModel;
  bool isClickLeave = false;

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  //* for leave section
  late ValueNotifier<String> dropValueLeaveNotifier;
  String clinicLeaveId = "";
  late String selectedLeaveClinicId;
  List<HospitalDetails> clinicValuesLeave = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
      listener: (context, state) {
        BlocProvider.of<GetAllLeavesBloc>(context)
            .add(FetchAllLeaves(hospitalId: selectedLeaveClinicId));
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Leave",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: kTextColor),
          ),
        ),
        body: BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
          listener: (context, state) {
            if (state is LeaveUpdateLoaded) {
              GeneralServices.instance
                  .showSuccessMessage(context, "Leave Update Successfull");
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pop(context);
              });
            }
            if (state is LeaveUpdateError) {
              GeneralServices.instance
                  .showErrorMessage(context, "Something Went Wrong");
              // Future.delayed(const Duration(seconds: 5), () {
              //   Navigator.pop(context);
              // });
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  VerticalSpacingWidget(height: 10.h),
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

                              if (clinicValuesLeave.isEmpty) {
                                clinicValuesLeave
                                    .addAll(clinicGetModel.hospitalDetails!);
                                dropValueLeaveNotifier = ValueNotifier(
                                    clinicValuesLeave.first.clinicName!);
                                clinicLeaveId =
                                    clinicValuesLeave.first.clinicId.toString();
                                selectedLeaveClinicId =
                                    clinicValuesLeave.first.clinicId.toString();
                              }

                              BlocProvider.of<GetAllLeavesBloc>(context).add(
                                  FetchAllLeaves(
                                      hospitalId: selectedLeaveClinicId));
                              BlocProvider.of<LeaveCheckBloc>(context).add(
                                  FetchLeaveCheck(
                                      clinicId: selectedLeaveClinicId,
                                      fromDate: DateFormat('yyyy-MM-dd')
                                          .format(leaveStartDate),
                                      toDate: DateFormat('yyyy-MM-dd')
                                          .format(leaveEndDate)));
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
                                      valueListenable: dropValueLeaveNotifier,
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
                                            dropValueLeaveNotifier.value =
                                                value;
                                            clinicLeaveId = value;
                                            selectedLeaveClinicId =
                                                clinicValuesLeave
                                                    .where((element) => element
                                                        .clinicName!
                                                        .contains(value))
                                                    .toList()
                                                    .first
                                                    .clinicId
                                                    .toString();
                                            BlocProvider.of<GetAllLeavesBloc>(
                                                    context)
                                                .add(FetchAllLeaves(
                                                    hospitalId:
                                                        selectedLeaveClinicId));
                                            BlocProvider.of<LeaveCheckBloc>(
                                                    context)
                                                .add(FetchLeaveCheck(
                                                    clinicId:
                                                        selectedLeaveClinicId,
                                                    fromDate: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(leaveStartDate),
                                                    toDate: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(leaveEndDate)));
                                          },
                                          items: clinicValuesLeave
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
                                    selectDate(
                                      context: context,
                                      date: leaveStartDate,
                                      onDateSelected: (DateTime picked) {
                                        setState(() {
                                          leaveStartDate = picked;
                                          leaveEndDate = picked;
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
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
                                              ? selectIosDate(
                                                  context: context,
                                                  date: leaveStartDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      leaveStartDate = picked;
                                                      leaveEndDate = picked;
                                                    });
                                                    BlocProvider.of<
                                                                LeaveCheckBloc>(
                                                            context)
                                                        .add(FetchLeaveCheck(
                                                            clinicId:
                                                                selectedLeaveClinicId,
                                                            fromDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveStartDate),
                                                            toDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveEndDate)));
                                                  },
                                                )
                                              : selectDate(
                                                  context: context,
                                                  date: leaveStartDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      leaveStartDate = picked;
                                                      leaveEndDate = picked;
                                                    });
                                                    BlocProvider.of<
                                                                LeaveCheckBloc>(
                                                            context)
                                                        .add(FetchLeaveCheck(
                                                            clinicId:
                                                                selectedLeaveClinicId,
                                                            fromDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveStartDate),
                                                            toDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveEndDate)));
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
                                  DateFormat("dd-MM-yyy")
                                      .format(leaveStartDate),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    selectDate(
                                      context: context,
                                      date: leaveEndDate,
                                      onDateSelected: (DateTime picked) {
                                        setState(() {
                                          leaveEndDate = picked;
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
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
                                              ? selectIosDate(
                                                  context: context,
                                                  date: leaveEndDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      leaveEndDate = picked;
                                                    });
                                                    BlocProvider.of<
                                                                LeaveCheckBloc>(
                                                            context)
                                                        .add(FetchLeaveCheck(
                                                            clinicId:
                                                                selectedLeaveClinicId,
                                                            fromDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveStartDate),
                                                            toDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveEndDate)));
                                                  },
                                                )
                                              : selectDate(
                                                  context: context,
                                                  date: leaveEndDate,
                                                  onDateSelected:
                                                      (DateTime picked) {
                                                    setState(() {
                                                      leaveEndDate = picked;
                                                    });
                                                    BlocProvider.of<
                                                                LeaveCheckBloc>(
                                                            context)
                                                        .add(FetchLeaveCheck(
                                                            clinicId:
                                                                selectedLeaveClinicId,
                                                            fromDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveStartDate),
                                                            toDate: DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    leaveEndDate)));
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
                                  DateFormat("dd-MM-yyy").format(leaveEndDate),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const VerticalSpacingWidget(height: 5),

                        // VerticalSpacingWidget(height: 10.h),
                        BlocBuilder<LeaveCheckBloc, LeaveCheckState>(
                          builder: (context, state) {
                            if (state is LeaveCheckLoaded) {
                              leaveCheckModel =
                                  BlocProvider.of<LeaveCheckBloc>(context)
                                      .leaveCheckModel;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    isClickLeave = true;
                                  });
                                  leaveCheckModel.bookedtokencount != 0
                                      ? GeneralServices().appCloseDialogue(
                                          context,
                                          "You have bookings on this date.Are you sure you want to take leave?",
                                          () {
                                          BlocProvider.of<LeaveUpdateBloc>(
                                                  context)
                                              .add(FetchLeaveUpdate(
                                            clinicId: selectedLeaveClinicId,
                                            fromDate:
                                                "${leaveStartDate.year}-${leaveStartDate.month}-${leaveStartDate.day}",
                                            toDate:
                                                "${leaveEndDate.year}-${leaveEndDate.month}-${leaveEndDate.day}",
                                          ));
                                          Navigator.pop(context);
                                        })
                                      : BlocProvider.of<LeaveUpdateBloc>(
                                              context)
                                          .add(FetchLeaveUpdate(
                                          clinicId: selectedLeaveClinicId,
                                          fromDate:
                                              "${leaveStartDate.year}-${leaveStartDate.month}-${leaveStartDate.day}",
                                          toDate:
                                              "${leaveEndDate.year}-${leaveEndDate.month}-${leaveEndDate.day}",
                                        ));
                                },
                                child: Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        isClickLeave ? Colors.grey : kMainColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Confirm as a Leave",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),

                        VerticalSpacingWidget(height: 10.h),
                        // getAllLeavesModel.leavesData==null?Container():
                        BlocBuilder<GetAllLeavesBloc, GetAllLeavesState>(
                          builder: (context, state) {
                            if (state is GetAllLeavesLoaded) {
                              getAllLeavesModel =
                                  BlocProvider.of<GetAllLeavesBloc>(context)
                                      .getAllLeavesModel;
                              if (getAllLeavesModel.leavesData == null) {
                                return Container();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your upcoming leaves",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        color: kSubTextColor),
                                  ),
                                  VerticalSpacingWidget(height: 5.h),
                                  SizedBox(
                                    height: 500.h,
                                    child: ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 40.h,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
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
                                                Text(
                                                  getAllLeavesModel
                                                      .leavesData![index].date!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kTextColor),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  LeaveUpdateBloc>(
                                                              context)
                                                          .add(
                                                        LeaveDelete(
                                                          clinicId:
                                                              selectedLeaveClinicId,
                                                          date:
                                                              getAllLeavesModel
                                                                  .leavesData![
                                                                      index]
                                                                  .date
                                                                  .toString(),
                                                        ),
                                                      );
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
                                        itemCount: getAllLeavesModel
                                            .leavesData!.length),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                        const VerticalSpacingWidget(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //! select date
  Future<void> selectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: ((context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
            ),
          ),
          child: child!,
        );
      }),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  Future<void> selectIosDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          // height: 200.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: date,
            minimumDate: today,
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            onDateTimeChanged: (DateTime newDateTime) {
              onDateSelected(newDateTime);
              // Do something when the date is changed (optional)
            },
          ),
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }
}

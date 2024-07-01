// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/CustomSchedule/get_all_leaves_model.dart';
import 'package:mediezy_doctor/Model/leave_check_model/leave_check_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/GetAllLeaves/get_all_leaves_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/LeaveUpdate/leave_update_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/leave_check/leave_check_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
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
  bool loading = true;
  List<LeavesData> leavesData = [];

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  //* for leave section
  // late ValueNotifier<String> dropValueLeaveNotifier;
  // String clinicLeaveId = "";
  // late String dController.initialIndex.value;
  // List<HospitalDetails> clinicValuesLeave = [];

  final HospitalController dController = Get.put(HospitalController());

  @override
  void initState() {
    BlocProvider.of<GetAllLeavesBloc>(context).add(FetchAllLeaves(
      hospitalId: dController.initialIndex.value,
    ));

    BlocProvider.of<LeaveCheckBloc>(context).add(FetchLeaveCheck(
        clinicId: dController.initialIndex.value,
        fromDate: DateFormat('yyyy-MM-dd').format(leaveStartDate),
        toDate: DateFormat('yyyy-MM-dd').format(leaveEndDate)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
      listener: (context, state) {
        BlocProvider.of<GetAllLeavesBloc>(context).add(FetchAllLeaves(
          hospitalId: dController.initialIndex.value,
        ));
      },
      child: Scaffold(
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Leave",
          ),
        ),
        body: BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
          listener: (context, state) {
            if (state is LeaveUpdateLoaded) {
              GeneralServices.instance
                  .showSuccessMessage(context, "Leave Update Successfully");
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pop(context);
              });
            }
            if (state is LeaveUpdateError) {
              GeneralServices.instance
                  .showErrorMessage(context, state.errorMessage);
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
                          style: size.width > 450 ? greyTab10B600 : grey13B600,
                        ),
                        const VerticalSpacingWidget(height: 5),
                        GetBuilder<HospitalController>(builder: (clx) {
                          return CustomDropDown(
                            width: double.infinity,
                            value: dController.initialIndex.value,
                            items: dController.hospitalDetails!.map((e) {
                              return DropdownMenuItem(
                                value: e.clinicId.toString(),
                                child: Text(e.clinicName!),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              log(newValue!);
                              dController.dropdownValueChanging(
                                  newValue, dController.initialIndex.value);
                              BlocProvider.of<GetAllLeavesBloc>(context)
                                  .add(FetchAllLeaves(
                                hospitalId: dController.initialIndex.value,
                              ));
                              BlocProvider.of<LeaveCheckBloc>(context).add(
                                  FetchLeaveCheck(
                                      clinicId: dController.initialIndex.value,
                                      fromDate: DateFormat('yyyy-MM-dd')
                                          .format(leaveStartDate),
                                      toDate: DateFormat('yyyy-MM-dd')
                                          .format(leaveEndDate)));
                            },
                          );
                        }),
                        BlocBuilder<GetAllLeavesBloc, GetAllLeavesState>(
                          builder: (context, state) {
                            if (state is GetAllLeavesLoaded) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Platform.isIOS
                                            ? selectIosDate(
                                                //deleted pending
                                                state: state,
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
                                                          clinicId: dController
                                                              .initialIndex
                                                              .value,
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
                                                minDate: leaveStartDate,
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
                                                      .add(
                                                    FetchLeaveCheck(
                                                      clinicId: dController
                                                          .initialIndex.value,
                                                      fromDate: DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(
                                                              leaveStartDate),
                                                      toDate: DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(leaveEndDate),
                                                    ),
                                                  );
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
                                                style: size.width > 450
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Platform.isIOS
                                                      ? selectIosDate(
                                                          state: state,
                                                          context: context,
                                                          date: leaveStartDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) {
                                                            setState(() {
                                                              leaveStartDate =
                                                                  picked;
                                                              leaveEndDate =
                                                                  picked;
                                                            });
                                                            BlocProvider.of<LeaveCheckBloc>(context).add(FetchLeaveCheck(
                                                                clinicId:
                                                                    dController
                                                                        .initialIndex
                                                                        .value,
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
                                                     minDate: leaveStartDate,
                                                          //  state: state,
                                                          context: context,
                                                          date: leaveStartDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) {
                                                            setState(() {
                                                              leaveStartDate =
                                                                  picked;
                                                              leaveEndDate =
                                                                  picked;
                                                            });
                                                            BlocProvider.of<LeaveCheckBloc>(context).add(FetchLeaveCheck(
                                                                clinicId:
                                                                    dController
                                                                        .initialIndex
                                                                        .value,
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
                                          Text(
                                            DateFormat("dd-MM-yyy")
                                                .format(leaveStartDate),
                                            style: size.width > 450
                                                ? blackTabMainText
                                                : black14B600,
                                          ),
                                        ],
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Platform.isIOS
                                          ? selectIosDate(
                                              state: state,
                                              context: context,
                                              date: leaveEndDate,
                                              minDate: leaveStartDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  leaveEndDate = picked;
                                                });
                                                BlocProvider.of<
                                                        LeaveCheckBloc>(context)
                                                    .add(FetchLeaveCheck(
                                                        clinicId: dController
                                                            .initialIndex.value,
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
                                              // state: state,
                                              context: context,
                                              date: leaveEndDate,
                                              minDate:
                                                  leaveStartDate, // Add this line
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  leaveEndDate = picked;
                                                });
                                                BlocProvider.of<
                                                        LeaveCheckBloc>(context)
                                                    .add(FetchLeaveCheck(
                                                        clinicId: dController
                                                            .initialIndex.value,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "End Date",
                                              style: size.width > 450
                                                  ? greyTab10B600
                                                  : grey13B600,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Platform.isIOS
                                                    ? selectIosDate(
                                                        state: state,
                                                        context: context,
                                                        date: leaveEndDate,
                                                        minDate: leaveStartDate,
                                                        onDateSelected:
                                                            (DateTime picked) {
                                                          setState(() {
                                                            leaveEndDate =
                                                                picked;
                                                          });
                                                          BlocProvider.of<
                                                                      LeaveCheckBloc>(
                                                                  context)
                                                              .add(
                                                            FetchLeaveCheck(
                                                              clinicId: dController
                                                                  .initialIndex
                                                                  .value,
                                                              fromDate: DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(
                                                                      leaveStartDate),
                                                              toDate: DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(
                                                                      leaveEndDate),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : selectDate(
                                                        //       state: state,
                                                        context: context,
                                                        date: leaveEndDate,
                                                        minDate:
                                                            leaveStartDate, // Add this line
                                                        onDateSelected:
                                                            (DateTime picked) {
                                                          setState(() {
                                                            leaveEndDate =
                                                                picked;
                                                          });
                                                          BlocProvider.of<LeaveCheckBloc>(context).add(FetchLeaveCheck(
                                                              clinicId: dController
                                                                  .initialIndex
                                                                  .value,
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
                                        Text(
                                          DateFormat("dd-MM-yyy")
                                              .format(leaveEndDate),
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black14B600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: size.width > 450
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              IconButton(
                                                onPressed: null,
                                                icon: Icon(
                                                  IconlyLight.calendar,
                                                  color: kMainColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            DateFormat("dd-MM-yyy")
                                                .format(leaveStartDate),
                                            style: size.width > 450
                                                ? blackTabMainText
                                                : black14B600,
                                          ),
                                        ],
                                      )),
                                  GestureDetector(
                                    onTap: null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "End Date",
                                              style: size.width > 450
                                                  ? greyTab10B600
                                                  : grey13B600,
                                            ),
                                            IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                IconlyLight.calendar,
                                                color: kMainColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          DateFormat("dd-MM-yyy")
                                              .format(leaveEndDate),
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : black14B600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const VerticalSpacingWidget(height: 5),
                        // VerticalSpacingWidget(height: 10.h),
                        BlocBuilder<LeaveCheckBloc, LeaveCheckState>(
                          builder: (context, state) {
                            if (state is LeaveCheckLoaded) {
                              leaveCheckModel =
                                  BlocProvider.of<LeaveCheckBloc>(context)
                                      .leaveCheckModel;
                              // BlocBuilder<GetAllLeavesBloc, GetAllLeavesState>(
                              //     builder: (context, states) {
                              // if (state is GetAllLeavesLoaded) {
                              // getAllLeavesModel =
                              //     BlocProvider.of<GetAllLeavesBloc>(context)
                              //         .getAllLeavesModel;
                              return Column(
                                children: [
                                  BlocBuilder<GetAllLeavesBloc,
                                      GetAllLeavesState>(
                                    builder: (context, states) {
                                      if (states is GetAllLeavesLoaded) {
                                        return InkWell(
                                          onTap: () {
                                            LeavesData? matchingLeave =
                                                findMatchingLeave(
                                                    leaveStartDate);
                                            if (leaveCheckModel
                                                    .bookedtokencount !=
                                                0) {}
                                            if (matchingLeave == null) {
                                              if (leaveCheckModel
                                                      .bookedtokencount !=
                                                  0) {
                                                GeneralServices()
                                                    .appCloseDialogue(
                                                  context,
                                                  "You have bookings on this date.Are you sure you want to take leave?",
                                                  () {
                                                    BlocProvider.of<
                                                                LeaveUpdateBloc>(
                                                            context)
                                                        .add(
                                                      FetchLeaveUpdate(
                                                        clinicId: dController
                                                            .initialIndex.value,
                                                        fromDate: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                leaveStartDate),
                                                        toDate: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                leaveEndDate),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                BlocProvider.of<
                                                            LeaveUpdateBloc>(
                                                        context)
                                                    .add(
                                                  FetchLeaveUpdate(
                                                    clinicId: dController
                                                        .initialIndex.value,
                                                    fromDate: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(leaveStartDate),
                                                    toDate: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(leaveEndDate),
                                                  ),
                                                );
                                              }
                                              // Only allow adding new leave if it's not already a leave date
                                            }
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: isLeaveDate(
                                                leaveStartDate,
                                              )
                                                  ? Colors.grey
                                                  : kMainColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                isLeaveDate(leaveStartDate)
                                                    ? "Leave Date"
                                                    : "Confirm as a Leave",
                                                style: TextStyle(
                                                  fontSize: size.width > 450
                                                      ? 12.sp
                                                      : 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        // InkWell(
                                        //   onTap: () {
                                        //     LeavesData? matchingLeave;
                                        //     try {
                                        //       matchingLeave = states
                                        //           .getAllLeavesModel.leavesData!
                                        //           .firstWhere((e) =>
                                        //               e.date.toString() ==
                                        //               DateFormat("dd-MM-yyy")
                                        //                   .format(
                                        //                       leaveStartDate));
                                        //     } catch (e) {
                                        //       matchingLeave = null;
                                        //     }
                                        //     if (matchingLeave != null) {
                                        //       setState(() {
                                        //         isClickLeave =
                                        //             matchingLeave!.status!;
                                        //       });
                                        //       BlocProvider.of<LeaveUpdateBloc>(
                                        //               context)
                                        //           .add(FetchLeaveUpdate(
                                        //         clinicId: dController
                                        //             .initialIndex.value,
                                        //         fromDate:
                                        //             DateFormat('yyyy-MM-dd')
                                        //                 .format(leaveStartDate),
                                        //         toDate: DateFormat('yyyy-MM-dd')
                                        //             .format(leaveEndDate),
                                        //       ));

                                        //       log("===================$isClickLeave");
                                        //     } else {
                                        //       BlocProvider.of<LeaveUpdateBloc>(
                                        //               context)
                                        //           .add(FetchLeaveUpdate(
                                        //         clinicId: dController
                                        //             .initialIndex.value,
                                        //         fromDate:
                                        //             DateFormat('yyyy-MM-dd')
                                        //                 .format(leaveStartDate),
                                        //         toDate: DateFormat('yyyy-MM-dd')
                                        //             .format(leaveEndDate),
                                        //       ));
                                        //     }

                                        // log("===================$isClickLeave");
                                        // leaveCheckModel.bookedtokencount !=
                                        //         0
                                        //     ? GeneralServices()
                                        //         .appCloseDialogue(context,
                                        //             "You have bookings on this date.Are you sure you want to take leave?",
                                        //             () {
                                        // BlocProvider.of<
                                        //             LeaveUpdateBloc>(
                                        //         context)
                                        //     .add(FetchLeaveUpdate(
                                        //   clinicId: dController
                                        //       .initialIndex.value,
                                        //   fromDate: DateFormat(
                                        //           'yyyy-MM-dd')
                                        //       .format(
                                        //           leaveStartDate),
                                        //   toDate: DateFormat(
                                        //           'yyyy-MM-dd')
                                        //       .format(leaveEndDate),
                                        // ));
                                        //         Navigator.pop(context);
                                        //       })
                                        //     : BlocProvider.of<
                                        //                 LeaveUpdateBloc>(
                                        //             context)
                                        //         .add(FetchLeaveUpdate(
                                        //         clinicId: dController
                                        //             .initialIndex.value,
                                        //         fromDate: DateFormat(
                                        //                 'yyyy-MM-dd')
                                        //             .format(leaveStartDate),
                                        //         // "${leaveStartDate.year}-${leaveStartDate.month}-${leaveStartDate.day}",
                                        //         toDate: DateFormat(
                                        //                 'yyyy-MM-dd')
                                        //             .format(leaveEndDate),
                                        //         // "${leaveEndDate.year}-${leaveEndDate.month}-${leaveEndDate.day}",
                                        //       ));
                                        //   },
                                        //   child: Container(
                                        //     height: 50.h,
                                        //     width: double.infinity,
                                        //     decoration: BoxDecoration(
                                        //       color: isClickLeave
                                        //           ? Colors.grey
                                        //           : kMainColor,
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //     ),
                                        //     child: Center(
                                        //       child: Text(
                                        //         "Confirm as a Leave",
                                        //         style: size.width > 450
                                        //             ? TextStyle(
                                        //                 fontSize: 12.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.w600,
                                        //                 color: Colors.white)
                                        //             : TextStyle(
                                        //                 fontSize: 18.sp,
                                        //                 fontWeight:
                                        //                     FontWeight.w600,
                                        //                 color: Colors.white),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // );
                                      } else {
                                        return Container(
                                          height: 50.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: isLeaveDate(
                                              leaveStartDate,
                                            )
                                                ? Colors.grey
                                                : kMainColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isLeaveDate(leaveStartDate)
                                                  ? "Leave Date"
                                                  : "Confirm as a Leave",
                                              style: TextStyle(
                                                fontSize: size.width > 450
                                                    ? 12.sp
                                                    : 18.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  // ElevatedButton(onPressed: () {
                                  //     log("=================== fsdkfjdsfkjdskfdksfdfksjl   ::::   ${leaveCheckModel.message}");
                                  // }, child: Text("data")),
                                ],
                              );
                              // }
                              //   return Container();
                              // });
                              //   return Container();
                            }
                            return Container();
                          },
                        ),
                        VerticalSpacingWidget(height: 10.h),
                        BlocBuilder<GetAllLeavesBloc, GetAllLeavesState>(
                          builder: (context, state) {
                            if (state is GetAllLeavesLoaded) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  leavesData =
                                      state.getAllLeavesModel.leavesData ?? [];
                                });
                              });
                              // getAllLeavesModel =
                              //     BlocProvider.of<GetAllLeavesBloc>(context)
                              //         .getAllLeavesModel;
                              if (state.getAllLeavesModel.leavesData == null) {
                                return Container();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your upcoming leaves",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  VerticalSpacingWidget(height: 5.h),
                                  SizedBox(
                                    height: 500.h,
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Container(
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
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(
                                                    DateTime.parse(state
                                                        .getAllLeavesModel
                                                        .leavesData![index]
                                                        .date!),
                                                  ),
                                                  style: size.width > 450
                                                      ? blackTabMainText
                                                      : black14B600,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                LeaveUpdateBloc>(
                                                            context)
                                                        .add(
                                                      LeaveDelete(
                                                        clinicId: dController
                                                            .initialIndex.value,
                                                        date: state
                                                            .getAllLeavesModel
                                                            .leavesData![index]
                                                            .date
                                                            .toString(),
                                                      ),
                                                    );
                                                    setState(() {
                                                      isClickLeave = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: kMainColor,
                                                    size: size.width > 450
                                                        ? 14.sp
                                                        : 20.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10.h),
                                      itemCount: state.getAllLeavesModel
                                              .leavesData?.length ??
                                          0,
                                    ),
                                  ),
                                ],
                              );
                              // return Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Your upcoming leaves",
                              //       style: size.width > 450
                              //           ? greyTab10B600
                              //           : grey13B600,
                              //     ),
                              //     VerticalSpacingWidget(height: 5.h),
                              //     SizedBox(
                              //       height: 500.h,
                              //       child: ListView.separated(
                              //           physics:
                              //               const NeverScrollableScrollPhysics(),
                              //           padding: EdgeInsets.zero,
                              //           itemBuilder: (context, index) {
                              //             return Card(
                              //               child: Container(
                              //                 height: 40.h,
                              //                 width: double.infinity,
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         horizontal: 5),
                              //                 decoration: BoxDecoration(
                              //                   color: kScaffoldColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(10),
                              //                 ),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceBetween,
                              //                   children: [
                              //                     Text(
                              //                       DateFormat('dd-MM-yyyy')
                              //                           .format(DateTime.parse(
                              //                               state
                              //                                   .getAllLeavesModel
                              //                                   .leavesData![
                              //                                       index]
                              //                                   .date!)),
                              //                       style: size.width > 450
                              //                           ? blackTabMainText
                              //                           : black14B600,
                              //                     ),
                              //                     IconButton(
                              //                       onPressed: () {
                              //                         BlocProvider.of<
                              //                                     LeaveUpdateBloc>(
                              //                                 context)
                              //                             .add(
                              //                           LeaveDelete(
                              //                             clinicId: dController
                              //                                 .initialIndex
                              //                                 .value,
                              //                             date: state
                              //                                 .getAllLeavesModel
                              //                                 .leavesData![
                              //                                     index]
                              //                                 .date
                              //                                 .toString(),
                              //                           ),
                              //                         );

                              //                         isClickLeave = false;
                              //                       },
                              //                       icon: Icon(
                              //                         Icons.delete,
                              //                         color: kMainColor,
                              //                         size: size.width > 450
                              //                             ? 14.sp
                              //                             : 20.sp,
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             );
                              //           },
                              //           separatorBuilder: (context, index) {
                              //             return const VerticalSpacingWidget(
                              //                 height: 10);
                              //           },
                              //           itemCount: state.getAllLeavesModel
                              //               .leavesData!.length),
                              //     ),
                              //   ],
                              // );
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

  //data on selected datails
  bool isLeaveDate(DateTime date) {
    return leavesData.any((leave) =>
        DateFormat("dd-MM-yyyy").format(DateTime.parse(leave.date!)) ==
        DateFormat("dd-MM-yyyy").format(date));
  }

  LeavesData? findMatchingLeave(DateTime date) {
    try {
      return leavesData.firstWhere(
        (leave) =>
            DateFormat("dd-MM-yyyy").format(DateTime.parse(leave.date!)) ==
            DateFormat("dd-MM-yyyy").format(date),
      );
    } catch (e) {
      return null;
    }
  }

  //! select date
  Future<void> selectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
    DateTime? minDate,
    //  required GetAllLeavesState state
  }) async {
   final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: date,
    firstDate: minDate ?? DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 30)),
    // selectableDayPredicate: (DateTime date) {
    //   return !_isLeaveDate(date);
    // },
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: kMainColor,
            //onSurface: _isLeaveDate(date) ? Colors.red : Colors.blue,
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    onDateSelected(picked);
  }
}

  Future<void> selectIosDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
    required GetAllLeavesState state,
    DateTime? minDate,
  }) async {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: date,
          minimumDate: minDate ?? today,
          maximumDate: DateTime.now().add(const Duration(days: 30)),
          onDateTimeChanged: (DateTime newDateTime) {
            _onDateSelected(newDateTime);
          },
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  //ios leave//
  void _onDateSelected(DateTime picked) {
    setState(() {
      leaveStartDate = picked;
      leaveEndDate = picked;
    });
    BlocProvider.of<LeaveCheckBloc>(context).add(FetchLeaveCheck(
      clinicId: dController.initialIndex.value,
      fromDate: DateFormat('yyyy-MM-dd').format(leaveStartDate),
      toDate: DateFormat('yyyy-MM-dd').format(leaveEndDate),
    ));
  }

  //leave date //
//   bool _isLeaveDate(DateTime date) {
//   return leavesData.any((leave) =>
//       DateFormat("dd-MM-yyyy").format(DateTime.parse(leave.date!)) ==
//       DateFormat("dd-MM-yyyy").format(date));
// }
}

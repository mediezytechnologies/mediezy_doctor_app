import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ReserveToken/reserve_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/RemoveTokens/token_card_remove_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/Reservation/un_reserve_screen.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import '../../../../Model/GenerateToken/clinic_get_model.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>
    with TickerProviderStateMixin {
  late TabController tabFirstController;

  late ClinicGetModel clinicGetModel;

  final HospitalController dController = Get.put(HospitalController());

  late GetTokenModel getTokenModel;

  DateTime selectedDate = DateTime.now();

  DateTime endDate = DateTime.now();

  DateTime selectedunreserveDate = DateTime.now();
  DateTime unreserveendDate = DateTime.now();

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  //* for manage section
  // late ValueNotifier<String> dropValueManageNotifier;
  // String clinicManageId = "";
  // late String selectedManageClinicId;
  // List<HospitalDetails> clinicValuesManage = [];

  // late ValueNotifier<String> dropValueUnreserveNotifier;
  // String clinicUnreserveId = "";
  // late String selectedUnReserveClinicId;
  // List<HospitalDetails> clinicValueUnReserve = [];

  List<String> selectedTokenNumbers = [];
  int visible = 0;

  void resetSelectedTokens() {
    setState(() {
      selectedTokenNumbers.clear();
    });
  }

  bool isClickedManage = false;

  @override
  void initState() {
    super.initState();
    tabFirstController = TabController(length: 2, vsync: this);
    BlocProvider.of<GetTokenBloc>(context).add(
      FetchTokens(date: formatDate(), clinicId: dController.initialIndex!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color eveningContainerColor;
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Reserve token",
        ),
      ),
      bottomNavigationBar: visible == 0
          ? InkWell(
              onTap: () {
                BlocProvider.of<ReserveTokenBloc>(context).add(AddReserveToken(
                    tokenNumber: selectedTokenNumbers.toString(),
                    fromDate: DateFormat('yyy-MM-dd').format(selectedDate),
                    toDate: DateFormat('yyy-MM-dd').format(endDate),
                    clinicId: dController.initialIndex!));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isClickedManage ? Colors.grey : kMainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text("Reserve Token",
                        style: size.width > 400
                            ? TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)
                            : TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Column(
        children: [
          // VerticalSpacingWidget(height: 10.h),
          Container(
            height: size.width > 400 ? 60.h : 50.h,
            color: kCardColor,
            child: TabBar(
              onTap: (value) {
                setState(() {
                  visible = value;
                });
                if (tabFirstController.index == 0) {
                  BlocProvider.of<GetTokenBloc>(context).add(
                    FetchTokens(
                        date: formatDate(),
                        clinicId: dController.initialIndex!),
                  );
                  resetSelectedTokens();
                }
                BlocProvider.of<ReserveTokenBloc>(context).add(
                    FetchReservedTokens(
                        fromDate: DateFormat('yyy-MM-dd')
                            .format(selectedunreserveDate),
                        toDate:
                            DateFormat('yyy-MM-dd').format(unreserveendDate),
                        clinicId: dController.initialIndex!));
              },
              controller: tabFirstController,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
              dividerColor: kCardColor,
              unselectedLabelColor: kTextColor,
              unselectedLabelStyle: TextStyle(
                fontSize: size.width > 400 ? 10.sp : 13.sp,
              ),
              labelStyle: TextStyle(
                fontSize: size.width > 400 ? 11.sp : 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: kMainColor),
              tabs: [
                //! reserve
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Reserve",
                      ),
                    ),
                  ),
                ),
                //! unreserve
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Un reserve"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabFirstController,
              children: [
                //! resreve
                BlocListener<ReserveTokenBloc, ReserveTokenState>(
                  listener: (context, state) {
                    if (state is ReserveTokenLoaded) {
                      GeneralServices.instance.showSuccessMessage(
                          context, "Reserve Token Successfull");
                      BlocProvider.of<GetTokenBloc>(context).add(
                        FetchTokens(
                            date: formatDate(),
                            clinicId: dController.initialIndex!),
                      );
                    }
                    if (state is ReserveTokenError) {
                      GeneralServices.instance
                          .showErrorMessage(context, state.errorMessage);
                      Future.delayed(const Duration(seconds: 3), () {
                        // Navigator.pop(context);
                      });
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          // VerticalSpacingWidget(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Clinic",
                                  style: size.width > 400
                                      ? greyTab10B600
                                      : grey13B600,
                                ),
                                const VerticalSpacingWidget(height: 5),
                                GetBuilder<HospitalController>(builder: (clx) {
                                  return CustomDropDown(
                                    width: double.infinity,
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
                                      BlocProvider.of<GetTokenBloc>(context)
                                          .add(
                                        FetchTokens(
                                            date: formatDate(),
                                            clinicId:
                                                dController.initialIndex!),
                                      );
                                      resetSelectedTokens();
                                    },
                                  );
                                }),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Platform.isIOS
                                                ? GeneralServices.instance
                                                    .selectIosDate(
                                                    context: context,
                                                    date: selectedDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        selectedDate = picked;
                                                        endDate =
                                                            picked; // Update endDate as well
                                                      });
                                                    },
                                                  )
                                                : GeneralServices.instance
                                                    .selectDate(
                                                    context: context,
                                                    date: selectedDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        selectedDate = picked;
                                                        endDate = picked;
                                                      });
                                                    },
                                                  );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Start Date",
                                                style: size.width > 400
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              const HorizontalSpacingWidget(
                                                  width: 3),
                                              IconButton(
                                                onPressed: () {
                                                  Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: selectedDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              selectedDate =
                                                                  picked;
                                                              endDate =
                                                                  picked; // Update endDate as well
                                                            });
                                                            BlocProvider.of<
                                                                GetTokenBloc>(
                                                              context,
                                                            ).add(
                                                              FetchTokens(
                                                                date:
                                                                    formatDate(),
                                                                clinicId:
                                                                    dController
                                                                        .initialIndex!,
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : GeneralServices.instance
                                                          .selectDate(
                                                          context: context,
                                                          date: selectedDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              selectedDate =
                                                                  picked;
                                                              endDate =
                                                                  picked; // Update endDate as well
                                                            });
                                                            BlocProvider.of<
                                                                GetTokenBloc>(
                                                              context,
                                                            ).add(
                                                              FetchTokens(
                                                                date:
                                                                    formatDate(),
                                                                clinicId:
                                                                    dController
                                                                        .initialIndex!,
                                                              ),
                                                            );
                                                          },
                                                        );
                                                },
                                                icon: Icon(
                                                  IconlyLight.calendar,
                                                  color: kMainColor,
                                                  size: size.width > 400
                                                      ? 12.sp
                                                      : 20.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyy')
                                              .format(selectedDate),
                                          style: size.width > 400
                                              ? blackTabMainText
                                              : black14B600,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Platform.isIOS
                                                ? GeneralServices.instance
                                                    .selectIosDate(
                                                    context: context,
                                                    date: endDate,
                                                    onDateSelected: (DateTime
                                                        picked) async {
                                                      setState(() {
                                                        endDate =
                                                            picked; // Update endDate as well
                                                      });
                                                    },
                                                  )
                                                : GeneralServices.instance
                                                    .selectDate(
                                                    context: context,
                                                    date: endDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        endDate = picked;
                                                        // print(endDate);
                                                      });
                                                    },
                                                  );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "End Date",
                                                style: size.width > 400
                                                    ? greyTab10B600
                                                    : grey13B600,
                                              ),
                                              const HorizontalSpacingWidget(
                                                  width: 3),
                                              IconButton(
                                                onPressed: () {
                                                  Platform.isIOS
                                                      ? GeneralServices.instance
                                                          .selectIosDate(
                                                          context: context,
                                                          date: endDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) async {
                                                            setState(() {
                                                              endDate =
                                                                  picked; // Update endDate as well
                                                            });
                                                          },
                                                        )
                                                      : GeneralServices.instance
                                                          .selectDate(
                                                          context: context,
                                                          date: endDate,
                                                          onDateSelected:
                                                              (DateTime
                                                                  picked) {
                                                            setState(() {
                                                              endDate = picked;
                                                              // print(endDate);
                                                            });
                                                          },
                                                        );
                                                },
                                                icon: Icon(
                                                  IconlyLight.calendar,
                                                  color: kMainColor,
                                                  size: size.width > 400
                                                      ? 12.sp
                                                      : 20.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyy')
                                              .format(endDate),
                                          style: size.width > 400
                                              ? blackTabMainText
                                              : black14B600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocBuilder<GetTokenBloc, GetTokenState>(
                                  builder: (context, state) {
                                    if (state is GetTokenLoading) {
                                      return GeneralServices.instance
                                          .buildLoadingWidget(context);
                                    }
                                    if (state is GetTokenError) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const VerticalSpacingWidget(
                                              height: 100),
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
                                        return const EmptyCutomeWidget(
                                            text:
                                                "No Token available\non this date");
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule1
                                                  ?.isNotEmpty ==
                                              true)
                                            Text(
                                              "Schedule 1",
                                              style: size.width > 400
                                                  ? blackTabMainText
                                                  : blackMainText,
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule1
                                                  ?.isNotEmpty ==
                                              true)
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: getTokenModel
                                                  .schedule!.schedule1!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount:
                                                    size.width > 400 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 400 ? 100 : 70,
                                              ),
                                              itemBuilder: (context, index) {
                                                Color morningContainerColor =
                                                    kCardColor; // Default color
                                                if (getTokenModel
                                                            .schedule!
                                                            .schedule1![index]
                                                            .isTimeout ==
                                                        1 ||
                                                    getTokenModel
                                                            .schedule!
                                                            .schedule1![index]
                                                            .isBooked ==
                                                        1) {
                                                  morningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isReserved ==
                                                    1) {
                                                  morningContainerColor = Colors
                                                      .greenAccent
                                                      .shade100; // Change color to green
                                                } else if (selectedTokenNumbers
                                                    .contains(getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .tokenNumber!
                                                        .toString())) {
                                                  morningContainerColor =
                                                      Colors.grey.shade500;
                                                }

                                                return InkWell(
                                                  onTap: getTokenModel
                                                                  .schedule!
                                                                  .schedule1![
                                                                      index]
                                                                  .isTimeout ==
                                                              1 ||
                                                          getTokenModel
                                                                  .schedule!
                                                                  .schedule1![
                                                                      index]
                                                                  .isBooked ==
                                                              1
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            if (selectedTokenNumbers
                                                                .contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule1![
                                                                        index]
                                                                    .tokenNumber!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule1![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule1![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            }
                                                          });
                                                        },
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        morningContainerColor,
                                                    textColor: kTextColor,
                                                    tokenNumber: getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .tokenNumber
                                                        .toString(),
                                                    time: getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .formattedStartTime
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule2
                                                  ?.isNotEmpty ==
                                              true)
                                            Text(
                                              "Schedule 2",
                                              style: size.width > 400
                                                  ? blackTabMainText
                                                  : blackMainText,
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule2
                                                  ?.isNotEmpty ==
                                              true)
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: getTokenModel
                                                  .schedule!.schedule2!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount:
                                                    size.width > 400 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 400 ? 100 : 70,
                                              ),
                                              itemBuilder: (context, index) {
                                                if (getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isTimeout ==
                                                    1) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isBooked ==
                                                    1) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (selectedTokenNumbers
                                                    .contains(getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .tokenNumber!
                                                        .toString())) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade500;
                                                } else if (getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isReserved ==
                                                    1) {
                                                  eveningContainerColor = Colors
                                                      .greenAccent.shade100;
                                                } else {
                                                  eveningContainerColor =
                                                      kCardColor;
                                                }
                                                return InkWell(
                                                  onTap: getTokenModel
                                                                  .schedule!
                                                                  .schedule2![
                                                                      index]
                                                                  .isBooked ==
                                                              1 ||
                                                          getTokenModel
                                                                  .schedule!
                                                                  .schedule2![
                                                                      index]
                                                                  .isBooked ==
                                                              1
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            if (selectedTokenNumbers
                                                                .contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule2![
                                                                        index]
                                                                    .tokenNumber!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule2![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule2![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            }
                                                          });
                                                        },
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        eveningContainerColor,
                                                    textColor: kTextColor,
                                                    tokenNumber: getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .tokenNumber
                                                        .toString(),
                                                    time: getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .formattedStartTime
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule3
                                                  ?.isNotEmpty ==
                                              true)
                                            Text(
                                              "Schedule 3",
                                              style: size.width > 400
                                                  ? blackTabMainText
                                                  : blackMainText,
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule3
                                                  ?.isNotEmpty ==
                                              true)
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: getTokenModel
                                                  .schedule!.schedule3!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount:
                                                    size.width > 400 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 400 ? 100 : 70,
                                              ),
                                              itemBuilder: (context, index) {
                                                Color eveningContainerColor =
                                                    kCardColor; // Default color
                                                if (getTokenModel
                                                            .schedule!
                                                            .schedule3![index]
                                                            .isTimeout ==
                                                        1 ||
                                                    getTokenModel
                                                            .schedule!
                                                            .schedule3![index]
                                                            .isBooked ==
                                                        1) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (selectedTokenNumbers
                                                    .contains(getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .tokenNumber!
                                                        .toString())) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade500;
                                                } else if (getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .isReserved ==
                                                    1) {
                                                  eveningContainerColor = Colors
                                                      .greenAccent.shade100;
                                                }

                                                return InkWell(
                                                  onTap: getTokenModel
                                                                  .schedule!
                                                                  .schedule3![
                                                                      index]
                                                                  .isBooked ==
                                                              1 ||
                                                          getTokenModel
                                                                  .schedule!
                                                                  .schedule3![
                                                                      index]
                                                                  .isTimeout ==
                                                              1
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            if (selectedTokenNumbers
                                                                .contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule3![
                                                                        index]
                                                                    .tokenNumber!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule3![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule3![
                                                                          index]
                                                                      .tokenNumber!
                                                                      .toString());
                                                            }
                                                          });
                                                        },
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        eveningContainerColor,
                                                    textColor: kTextColor,
                                                    tokenNumber: getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .tokenNumber
                                                        .toString(),
                                                    time: getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .formattedStartTime
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
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
                const UnReserveTokenScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

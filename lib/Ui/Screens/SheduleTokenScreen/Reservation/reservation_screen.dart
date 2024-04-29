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
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ReserveToken/reserve_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shimmer/shimmer.dart';

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
    Color eveningContainerColor;
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reserve token",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
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
                    child: Text(
                      "Reserve Token",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Column(
        children: [
          // VerticalSpacingWidget(height: 10.h),
          Container(
            height: 50.h,
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
                        "Reserve",
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
                //! late
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
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
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
                                // BlocBuilder<GetClinicBloc, GetClinicState>(
                                //   builder: (context, state) {
                                //     if (state is GetClinicLoaded) {
                                //       clinicGetModel =
                                //           BlocProvider.of<GetClinicBloc>(
                                //                   context)
                                //               .clinicGetModel;
                                //
                                //       if (clinicValuesManage.isEmpty) {
                                //         clinicValuesManage.addAll(
                                //             clinicGetModel.hospitalDetails!);
                                //         dropValueManageNotifier =
                                //             ValueNotifier(clinicValuesManage
                                //                 .first.clinicName!);
                                //         clinicManageId = clinicValuesManage
                                //             .first.clinicId
                                //             .toString();
                                //         selectedManageClinicId =
                                //             clinicValuesManage.first.clinicId
                                //                 .toString();
                                //       }
                                //
                                //       BlocProvider.of<GetTokenBloc>(context)
                                //           .add(
                                //         FetchTokens(
                                //             date: formatDate(),
                                //             clinicId: selectedManageClinicId),
                                //       );
                                //       return Container(
                                //         height: 40.h,
                                //         width: double.infinity,
                                //         decoration: BoxDecoration(
                                //             color: kCardColor,
                                //             borderRadius:
                                //                 BorderRadius.circular(5),
                                //             border: Border.all(
                                //                 color:
                                //                     const Color(0xFF9C9C9C))),
                                //         child: Padding(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: 8.w),
                                //           child: Center(
                                //             child: ValueListenableBuilder(
                                //               valueListenable:
                                //                   dropValueManageNotifier,
                                //               builder: (BuildContext context,
                                //                   String dropValue, _) {
                                //                 return DropdownButtonFormField(
                                //                   iconEnabledColor:
                                //                       kMainColor,
                                //                   decoration:
                                //                       const InputDecoration
                                //                           .collapsed(
                                //                           hintText: ''),
                                //                   value: dropValue,
                                //                   style: TextStyle(
                                //                       fontSize: 14.sp,
                                //                       fontWeight:
                                //                           FontWeight.w500,
                                //                       color: kTextColor),
                                //                   icon: const Icon(Icons
                                //                       .keyboard_arrow_down),
                                //                   onChanged: (String? value) {
                                //                     dropValue = value!;
                                //                     dropValueManageNotifier
                                //                         .value = value;
                                //                     clinicManageId = value;
                                //                     selectedManageClinicId =
                                //                         clinicValuesManage
                                //                             .where((element) =>
                                //                                 element
                                //                                     .clinicName!
                                //                                     .contains(
                                //                                         value))
                                //                             .toList()
                                //                             .first
                                //                             .clinicId
                                //                             .toString();
                                //                     BlocProvider.of<
                                //                                 GetTokenBloc>(
                                //                             context)
                                //                         .add(FetchTokens(
                                //                             date:
                                //                                 formatDate(),
                                //                             clinicId:
                                //                                 selectedManageClinicId));
                                //                     resetSelectedTokens();
                                //                   },
                                //                   items: clinicValuesManage
                                //                       .map<
                                //                               DropdownMenuItem<
                                //                                   String>>(
                                //                           (value) {
                                //                     return DropdownMenuItem<
                                //                         String>(
                                //                       value:
                                //                           value.clinicName!,
                                //                       child: Text(
                                //                           value.clinicName!),
                                //                     );
                                //                   }).toList(),
                                //                 );
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     }
                                //     return Container();
                                //   },
                                // ),
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
                                                        endDate =
                                                            picked; // Update endDate as well
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyy')
                                              .format(selectedDate),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kTextColor),
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
                                                        print(endDate);
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
                                                :         GeneralServices.instance
                                                      .selectDate(
                                                    context: context,
                                                    date: endDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        endDate = picked;
                                                        print(endDate);
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
                                          DateFormat('dd-MM-yyy')
                                              .format(endDate),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocBuilder<GetTokenBloc, GetTokenState>(
                                  builder: (context, state) {
                                    if (state is GetTokenLoading) {
                                      return _buildLoadingWidget();
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
                                            const Text(
                                              "Schedule 1",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount: 5,
                                                mainAxisExtent: 70,
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
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          morningContainerColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: kMainColor,
                                                          width: 1),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule1![index]
                                                              .tokenNumber
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule1![index]
                                                              .formattedStartTime
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule2
                                                  ?.isNotEmpty ==
                                              true)
                                            const Text(
                                              "Schedule 2",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount: 5,
                                                mainAxisExtent: 70,
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
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          eveningContainerColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: kMainColor,
                                                          width: 1.w),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule2![index]
                                                              .tokenNumber
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kTextColor),
                                                        ),
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule2![index]
                                                              .formattedStartTime
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  kTextColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          // GridView.builder(
                                          //   physics: const NeverScrollableScrollPhysics(),
                                          //   padding: EdgeInsets.zero,
                                          //   shrinkWrap: true,
                                          //   itemCount: getTokenModel.schedule!.schedule2!.length,
                                          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          //     crossAxisSpacing: 5,
                                          //     mainAxisSpacing: 5,
                                          //     crossAxisCount: 5,
                                          //     mainAxisExtent: 70,
                                          //   ),
                                          //   itemBuilder: (context, index) {
                                          //     return SelectionTokenWidget(
                                          //       isBooked:
                                          //       getTokenModel.schedule!.schedule2![index].isBooked!,
                                          //       tokenNumber: getTokenModel.schedule!.schedule2![index].tokenNumber!,
                                          //       time: getTokenModel.schedule!.schedule2![index].formattedStartTime.toString(),
                                          //       isTimeout: getTokenModel.schedule!.schedule2![index].isTimeout!,
                                          //       isReserved:
                                          //       getTokenModel.schedule!.schedule2![index].isReserved!,
                                          //       // onTokenSelectionChanged: updateSelectedTokens,
                                          //       // onTokenSelectionChanged: updateSelectedTokens,
                                          //     );
                                          //   },
                                          // ),
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          if (getTokenModel.schedule?.schedule3
                                                  ?.isNotEmpty ==
                                              true)
                                            const Text(
                                              "Schedule 3",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                crossAxisCount: 5,
                                                mainAxisExtent: 70,
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
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          eveningContainerColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: kMainColor,
                                                          width: 1),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule3![index]
                                                              .tokenNumber
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          getTokenModel
                                                              .schedule!
                                                              .schedule3![index]
                                                              .formattedStartTime
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: kTextColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
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
                BlocListener<ReserveTokenBloc, ReserveTokenState>(
                  listener: (context, state) {
                    if (state is UnReserveTokenLoaded) {
                      BlocProvider.of<ReserveTokenBloc>(context).add(
                          FetchReservedTokens(
                              fromDate: DateFormat('yyy-MM-dd')
                                  .format(selectedunreserveDate),
                              toDate: DateFormat('yyy-MM-dd')
                                  .format(unreserveendDate),
                              clinicId: dController.initialIndex!));
                    }
                    if (state is UnReserveTokenError) {
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
                                      BlocProvider.of<ReserveTokenBloc>(context)
                                          .add(FetchReservedTokens(
                                              fromDate: DateFormat('yyy-MM-dd')
                                                  .format(
                                                      selectedunreserveDate),
                                              toDate: DateFormat('yyy-MM-dd')
                                                  .format(unreserveendDate),
                                              clinicId:
                                                  dController.initialIndex!));
                                    },
                                  );
                                }),
                                // BlocBuilder<GetClinicBloc, GetClinicState>(
                                //   builder: (context, state) {
                                //     if (state is GetClinicLoaded) {
                                //       clinicGetModel =
                                //           BlocProvider.of<GetClinicBloc>(
                                //                   context)
                                //               .clinicGetModel;
                                //
                                //       if (clinicValueUnReserve.isEmpty) {
                                //         clinicValueUnReserve.addAll(
                                //             clinicGetModel.hospitalDetails!);
                                //         dropValueUnreserveNotifier =
                                //             ValueNotifier(clinicValueUnReserve
                                //                 .first.clinicName!);
                                //         clinicUnreserveId =
                                //             clinicValueUnReserve
                                //                 .first.clinicId
                                //                 .toString();
                                //         selectedUnReserveClinicId =
                                //             clinicValueUnReserve
                                //                 .first.clinicId
                                //                 .toString();
                                //       }
                                //
                                //       BlocProvider.of<ReserveTokenBloc>(
                                //               context)
                                //           .add(FetchReservedTokens(
                                //               fromDate: DateFormat(
                                //                       'yyy-MM-dd')
                                //                   .format(
                                //                       selectedunreserveDate),
                                //               toDate: DateFormat('yyy-MM-dd')
                                //                   .format(unreserveendDate),
                                //               clinicId:
                                //                   selectedUnReserveClinicId));
                                //       return Container(
                                //         height: 40.h,
                                //         width: double.infinity,
                                //         decoration: BoxDecoration(
                                //             color: kCardColor,
                                //             borderRadius:
                                //                 BorderRadius.circular(5),
                                //             border: Border.all(
                                //                 color:
                                //                     const Color(0xFF9C9C9C))),
                                //         child: Padding(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: 8.w),
                                //           child: Center(
                                //             child: ValueListenableBuilder(
                                //               valueListenable:
                                //                   dropValueUnreserveNotifier,
                                //               builder: (BuildContext context,
                                //                   String dropValue, _) {
                                //                 return DropdownButtonFormField(
                                //                   iconEnabledColor:
                                //                       kMainColor,
                                //                   decoration:
                                //                       const InputDecoration
                                //                           .collapsed(
                                //                           hintText: ''),
                                //                   value: dropValue,
                                //                   style: TextStyle(
                                //                       fontSize: 14.sp,
                                //                       fontWeight:
                                //                           FontWeight.w500,
                                //                       color: kTextColor),
                                //                   icon: const Icon(Icons
                                //                       .keyboard_arrow_down),
                                //                   onChanged: (String? value) {
                                //                     dropValue = value!;
                                //                     dropValueUnreserveNotifier
                                //                         .value = value;
                                //                     clinicUnreserveId = value;
                                //                     selectedUnReserveClinicId =
                                //                         clinicValueUnReserve
                                //                             .where((element) =>
                                //                                 element
                                //                                     .clinicName!
                                //                                     .contains(
                                //                                         value))
                                //                             .toList()
                                //                             .first
                                //                             .clinicId
                                //                             .toString();
                                //                     BlocProvider.of<
                                //                                 ReserveTokenBloc>(
                                //                             context)
                                //                         .add(FetchReservedTokens(
                                //                             fromDate:
                                //                                 DateFormat(
                                //                                         'yyy-MM-dd')
                                //                                     .format(
                                //                                         selectedunreserveDate),
                                //                             toDate: DateFormat(
                                //                                     'yyy-MM-dd')
                                //                                 .format(
                                //                                     unreserveendDate),
                                //                             clinicId:
                                //                                 selectedUnReserveClinicId));
                                //                     // resetSelectedTokens();
                                //                   },
                                //                   items: clinicValueUnReserve
                                //                       .map<
                                //                               DropdownMenuItem<
                                //                                   String>>(
                                //                           (value) {
                                //                     return DropdownMenuItem<
                                //                         String>(
                                //                       value:
                                //                           value.clinicName!,
                                //                       child: Text(
                                //                           value.clinicName!),
                                //                     );
                                //                   }).toList(),
                                //                 );
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     }
                                //     return Container();
                                //   },
                                // ),
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
                                              date: selectedunreserveDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  selectedunreserveDate =
                                                      picked;
                                                  unreserveendDate =
                                                      picked; // Update unreserveendDate as well
                                                });
                                              },
                                                  )
                                                :            GeneralServices.instance.selectDate(
                                              context: context,
                                              date: selectedunreserveDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  selectedunreserveDate =
                                                      picked;
                                                  unreserveendDate =
                                                      picked; // Update unreserveendDate as well
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
                                                ? GeneralServices.instance
                                                    .selectIosDate(
                                                context: context,
                                                    date: selectedunreserveDate,
                                                    onDateSelected: (DateTime
                                                        picked) async {
                                                      setState(() {
                                                        selectedunreserveDate =
                                                            picked;
                                                        unreserveendDate =
                                                            picked; // Update unreserveendDate as well
                                                      });
                                                      BlocProvider.of<
                                                                  ReserveTokenBloc>(
                                                              context)
                                                          .add(FetchReservedTokens(
                                                              fromDate:
                                                                  DateFormat(
                                                                          'yyy-MM-dd')
                                                                      .format(
                                                                          selectedunreserveDate),
                                                              toDate: DateFormat(
                                                                      'yyy-MM-dd')
                                                                  .format(
                                                                      unreserveendDate),
                                                              clinicId: dController
                                                                  .initialIndex!));
                                                    },
                                                  )
                                                :       GeneralServices.instance
                                                      .selectDate(
                                                    context: context,
                                                    date: selectedunreserveDate,
                                                    onDateSelected: (DateTime
                                                        picked) async {
                                                      setState(() {
                                                        selectedunreserveDate =
                                                            picked;
                                                        unreserveendDate =
                                                            picked; // Update unreserveendDate as well
                                                      });
                                                      BlocProvider.of<
                                                                  ReserveTokenBloc>(
                                                              context)
                                                          .add(FetchReservedTokens(
                                                              fromDate:
                                                                  DateFormat(
                                                                          'yyy-MM-dd')
                                                                      .format(
                                                                          selectedunreserveDate),
                                                              toDate: DateFormat(
                                                                      'yyy-MM-dd')
                                                                  .format(
                                                                      unreserveendDate),
                                                              clinicId: dController
                                                                  .initialIndex!));
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
                                          DateFormat('dd-MM-yyy')
                                              .format(selectedunreserveDate),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kTextColor),
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
                                              date: unreserveendDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  unreserveendDate = picked;
                                                  print(unreserveendDate);
                                                });
                                              },
                                                  )
                                                :    GeneralServices.instance.selectDate(
                                              context: context,
                                              date: unreserveendDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  unreserveendDate = picked;
                                                  print(unreserveendDate);
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
                                                ? GeneralServices.instance
                                                    .selectIosDate(
                                                 context: context,
                                                    date: unreserveendDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        unreserveendDate =
                                                            picked;
                                                        print(unreserveendDate);
                                                      });
                                                    },
                                                  )
                                                :         GeneralServices.instance
                                                      .selectDate(
                                                    context: context,
                                                    date: unreserveendDate,
                                                    onDateSelected:
                                                        (DateTime picked) {
                                                      setState(() {
                                                        unreserveendDate =
                                                            picked;
                                                        print(unreserveendDate);
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
                                          DateFormat('dd-MM-yyy')
                                              .format(unreserveendDate),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocBuilder<ReserveTokenBloc,
                                    ReserveTokenState>(
                                  builder: (context, state) {
                                    if (state is ReservedTokensLoading) {
                                      return _buildLoadingWidget();
                                    }
                                    if (state is ReservedTokensError) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const VerticalSpacingWidget(
                                              height: 100),
                                          Center(
                                            child: SizedBox(
                                              height: 300.h,
                                              width: 300.w,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/something went wrong-01.png"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    if (state is ReservedTokensLoaded) {
                                      final getReservedTokensModel =
                                          state.getReservedTokensModel;
                                      if (getReservedTokensModel
                                          .getTokenDetails!.isEmpty) {
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
                                                height: 150.h,
                                                image: const AssetImage(
                                                    "assets/images/no_data.jpg"),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: getReservedTokensModel
                                                .getTokenDetails!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 1,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 5,
                                              mainAxisExtent: 70,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: kMainColor,
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          getReservedTokensModel
                                                              .getTokenDetails![
                                                                  index]
                                                              .tokenNumber!
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          getReservedTokensModel
                                                              .getTokenDetails![
                                                                  index]
                                                              .tokenStartTime!
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 45.w,
                                                    child: InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<ReserveTokenBloc>(context).add(UnReserveToken(
                                                            tokenNumber:
                                                                getReservedTokensModel
                                                                    .getTokenDetails![
                                                                        index]
                                                                    .tokenNumber
                                                                    .toString(),
                                                            fromDate:
                                                                DateFormat(
                                                                        'yyy-MM-dd')
                                                                    .format(
                                                                        selectedunreserveDate),
                                                            toDate: DateFormat(
                                                                    'yyy-MM-dd')
                                                                .format(
                                                                    unreserveendDate),
                                                            clinicId: dController
                                                                .initialIndex!));
                                                      },
                                                      child: const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        radius: 10,
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 400.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          itemCount: 30,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
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
      ),
    );
  }
}

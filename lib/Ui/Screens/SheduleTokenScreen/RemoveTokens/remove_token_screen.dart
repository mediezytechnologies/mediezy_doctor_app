// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetToken/get_token_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/get_delete_tokens_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/restore_dates_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/DeleteTokens/delete_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/DeletedTokens/deleted_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/restore_tokens_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Model/GenerateToken/clinic_get_model.dart';

class RemoveTokenScreen extends StatefulWidget {
  const RemoveTokenScreen({super.key});

  @override
  State<RemoveTokenScreen> createState() => _RemoveTokenScreenState();
}

class _RemoveTokenScreenState extends State<RemoveTokenScreen>
    with TickerProviderStateMixin {
  late TabController tabFirstController;

  late ClinicGetModel clinicGetModel;
  late RestoreDatesModel restoreDatesModel;
  late GetDeleteTokensModel getDeleteTokensModel;

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

  final HospitalController dController = Get.put(HospitalController());

  //* for manage section
  // late ValueNotifier<String> dropValueManageNotifier;
  // String clinicManageId = "";
  // late String selectedManageClinicId;
  // List<HospitalDetails> clinicValuesManage = [];

  // late ValueNotifier<String> dropValueRestoreNotifier;
  // String clinicRestoreId = "";
  // late String selectedRestoreClinicId;
  // List<HospitalDetails> clinicValuesRestore = [];

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
        FetchTokens(date: formatDate(), clinicId: dController.initialIndex!));
  }

  @override
  Widget build(BuildContext context) {
    Color eveningContainerColor;
    Color morningContainerColor;
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Remove tokens",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
      bottomNavigationBar: visible == 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: InkWell(
                onTap: () {
                  isClickedManage = true;
                  BlocProvider.of<DeleteTokensBloc>(context).add(
                      FetchDeleteTokens(
                          tokenId: selectedTokenNumbers.toString()));
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isClickedManage ? Colors.grey : kMainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Remove Token",
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
                  BlocProvider.of<GetTokenBloc>(context).add(FetchTokens(
                      date: formatDate(), clinicId: dController.initialIndex!));
                  resetSelectedTokens();
                }
                BlocProvider.of<DeletedTokensBloc>(context)
                    .add(FetchDeletedTokens(
                  clinicId: dController.initialIndex!,
                ));
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
                        "Remove",
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
                      child: Text("Restore"),
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
                BlocListener<DeleteTokensBloc, DeleteTokensState>(
                  listener: (context, state) {
                    if (state is DeleteTokensLoaded) {
                      GeneralServices.instance.showSuccessMessage(
                          context, "Remove Token Successfull");
                      BlocProvider.of<GetTokenBloc>(context).add(
                        FetchTokens(
                            date: formatDate(),
                            clinicId: dController.initialIndex!),
                      );
                    }
                    if (state is DeleteTokensError) {
                      GeneralServices.instance
                          .showErrorMessage(context, state.errorMessage);
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
                                          .add(FetchTokens(
                                              date: formatDate(),
                                              clinicId:
                                                  dController.initialIndex!));
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
                                //         dropValueManageNotifier = ValueNotifier(
                                //             clinicValuesManage
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
                                //                   iconEnabledColor: kMainColor,
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
                                //                             date: formatDate(),
                                //                             clinicId:
                                //                                 selectedManageClinicId));
                                //                     resetSelectedTokens();
                                //                   },
                                //                   items: clinicValuesManage.map<
                                //                       DropdownMenuItem<
                                //                           String>>((value) {
                                //                     return DropdownMenuItem<
                                //                         String>(
                                //                       value: value.clinicName!,
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
                                EasyDateTimeLine(
                                  initialDate: selectedDate,
                                  disabledDates: _getDisabledDates(),
                                  onDateChange: (date) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(date);
                                    selectedDate = date; //
                                    BlocProvider.of<GetTokenBloc>(context)
                                        .add(FetchTokens(
                                      date: formattedDate,
                                      clinicId: dController.initialIndex!,
                                    ));
                                    resetSelectedTokens();
                                  },
                                  activeColor: kMainColor,
                                  dayProps: EasyDayProps(
                                      height: 80.h,
                                      width: 65.w,
                                      activeDayNumStyle: TextStyle(
                                          color: kCardColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                      activeDayStrStyle: TextStyle(
                                          color: kCardColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                      activeMothStrStyle: TextStyle(
                                          color: kCardColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                      todayHighlightStyle:
                                          TodayHighlightStyle.withBackground,
                                      todayHighlightColor:
                                          const Color(0xffE1ECC8),
                                      borderColor: kMainColor),
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
                                                if (getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isTimeout ==
                                                    1) {
                                                  morningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isBooked ==
                                                    1) {
                                                  morningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (selectedTokenNumbers
                                                    .contains(getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .tokenId!
                                                        .toString())) {
                                                  morningContainerColor =
                                                      Colors.grey.shade500;
                                                } else {
                                                  morningContainerColor =
                                                      kCardColor;
                                                }
                                                return InkWell(
                                                  onTap: getTokenModel
                                                                  .schedule!
                                                                  .schedule1![
                                                                      index]
                                                                  .isBooked ==
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
                                                                    .tokenId!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule1![
                                                                          index]
                                                                      .tokenId!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule1![
                                                                          index]
                                                                      .tokenId!
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
                                                              .schedule1![index]
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
                                                              .schedule1![index]
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
                                                        .tokenId!
                                                        .toString())) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade500;
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
                                                                    .tokenId!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule2![
                                                                          index]
                                                                      .tokenId!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule2![
                                                                          index]
                                                                      .tokenId!
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
                                                if (getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .isTimeout ==
                                                    1) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade200;
                                                } else if (getTokenModel
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
                                                        .tokenId!
                                                        .toString())) {
                                                  eveningContainerColor =
                                                      Colors.grey.shade500;
                                                } else {
                                                  eveningContainerColor =
                                                      kCardColor;
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
                                                                  .isBooked ==
                                                              1
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            if (selectedTokenNumbers
                                                                .contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule3![
                                                                        index]
                                                                    .tokenId!
                                                                    .toString())) {
                                                              selectedTokenNumbers
                                                                  .remove(getTokenModel
                                                                      .schedule!
                                                                      .schedule3![
                                                                          index]
                                                                      .tokenId!
                                                                      .toString());
                                                            } else {
                                                              selectedTokenNumbers
                                                                  .add(getTokenModel
                                                                      .schedule!
                                                                      .schedule3![
                                                                          index]
                                                                      .tokenId!
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
                                                              .schedule3![index]
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
                                                              .schedule3![index]
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
                                          const VerticalSpacingWidget(
                                              height: 10),
                                          // InkWell(
                                          //   onTap: () {
                                          //     isClickedManage = true;
                                          //     BlocProvider.of<DeleteTokensBloc>(context)
                                          //         .add(FetchDeleteTokens(
                                          //             tokenId: selectedTokenNumbers
                                          //                 .toString()));
                                          //   },
                                          //   child: Container(
                                          //     height: 50.h,
                                          //     width: double.infinity,
                                          //     decoration: BoxDecoration(
                                          //       color: isClickedManage
                                          //           ? Colors.grey
                                          //           : kMainColor,
                                          //       borderRadius: BorderRadius.circular(8),
                                          //     ),
                                          //     child: Center(
                                          //       child: Text(
                                          //         "Remove Token",
                                          //         style: TextStyle(
                                          //             fontSize: 18.sp,
                                          //             fontWeight: FontWeight.w600,
                                          //             color: Colors.white),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
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
                BlocListener<RestoreTokensBloc, RestoreTokensState>(
                  listener: (context, state) {
                    if (state is AddRestoreTokensLoaded) {
                      BlocProvider.of<DeletedTokensBloc>(context)
                          .add(FetchDeletedTokens(
                        clinicId: dController.initialIndex!,
                      ));
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Clinic",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: kSubTextColor),
                          ),
                          const VerticalSpacingWidget(height: 2),
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
                                BlocProvider.of<DeletedTokensBloc>(context)
                                    .add(FetchDeletedTokens(
                                  clinicId: dController.initialIndex!,
                                ));
                              },
                            );
                          }),
                          // BlocBuilder<GetClinicBloc, GetClinicState>(
                          //   builder: (context, state) {
                          //     if (state is GetClinicLoaded) {
                          //       clinicGetModel =
                          //           BlocProvider.of<GetClinicBloc>(context)
                          //               .clinicGetModel;
                          //
                          //       if (clinicValuesRestore.isEmpty) {
                          //         clinicValuesRestore
                          //             .addAll(clinicGetModel.hospitalDetails!);
                          //         dropValueRestoreNotifier = ValueNotifier(
                          //             clinicValuesRestore.first.clinicName!);
                          //         clinicRestoreId = clinicValuesRestore
                          //             .first.clinicId
                          //             .toString();
                          //         selectedRestoreClinicId = clinicValuesRestore
                          //             .first.clinicId
                          //             .toString();
                          //       }
                          //       // BlocProvider.of<RestoreTokensBloc>(context)
                          //       //     .add(FetchRestoreDates(clinicId: selectedRestoreClinicId));
                          //       BlocProvider.of<DeletedTokensBloc>(context)
                          //           .add(FetchDeletedTokens(
                          //         clinicId: selectedRestoreClinicId,
                          //       ));
                          //       return Container(
                          //         height: 40.h,
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //             color: kCardColor,
                          //             borderRadius: BorderRadius.circular(5),
                          //             border: Border.all(
                          //                 color: const Color(0xFF9C9C9C))),
                          //         child: Padding(
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 8.w),
                          //           child: Center(
                          //             child: ValueListenableBuilder(
                          //               valueListenable: dropValueRestoreNotifier,
                          //               builder: (BuildContext context,
                          //                   String dropValue, _) {
                          //                 return DropdownButtonFormField(
                          //                   iconEnabledColor: kMainColor,
                          //                   decoration:
                          //                       const InputDecoration.collapsed(
                          //                           hintText: ''),
                          //                   value: dropValue,
                          //                   style: TextStyle(
                          //                       fontSize: 14.sp,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: kTextColor),
                          //                   icon: const Icon(
                          //                       Icons.keyboard_arrow_down),
                          //                   onChanged: (String? value) {
                          //                     dropValue = value!;
                          //                     dropValueRestoreNotifier.value =
                          //                         value;
                          //                     clinicRestoreId = value;
                          //                     selectedRestoreClinicId =
                          //                         clinicValuesRestore
                          //                             .where((element) => element
                          //                                 .clinicName!
                          //                                 .contains(value))
                          //                             .toList()
                          //                             .first
                          //                             .clinicId
                          //                             .toString();
                          //                     BlocProvider.of<DeletedTokensBloc>(
                          //                             context)
                          //                         .add(FetchDeletedTokens(
                          //                       clinicId: selectedRestoreClinicId,
                          //                     ));
                          //                   },
                          //                   items: clinicValuesRestore
                          //                       .map<DropdownMenuItem<String>>(
                          //                           (value) {
                          //                     return DropdownMenuItem<String>(
                          //                       value: value.clinicName!,
                          //                       child: Text(value.clinicName!),
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
                          const VerticalSpacingWidget(height: 10),
                          BlocBuilder<DeletedTokensBloc, DeletedTokensState>(
                            builder: (context, state) {
                              if (state is DeletedTokensLoading) {
                                // return _buildLoadingWidget();
                              }
                              if (state is DeletedTokensError) {
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
                              if (state is DeletedTokensLoaded) {
                                getDeleteTokensModel =
                                    BlocProvider.of<DeletedTokensBloc>(context)
                                        .getDeleteTokensModel;
                    
                                if (getDeleteTokensModel.data!.isEmpty) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const VerticalSpacingWidget(height: 100),
                                      Center(
                                        child: Image(
                                          height: 200.h,
                                          image: const AssetImage(
                                              "assets/images/no_data.jpg"),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount:
                                          getDeleteTokensModel.data!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        crossAxisCount: 4,
                                        mainAxisExtent: 80,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: kCardColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: kMainColor,
                                                    width: 1.w),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index].tokenNumber
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kTextColor),
                                                  ),
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index].time
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kTextColor),
                                                  ),
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index].formatdate
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: 55.w,
                                              child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              RestoreTokensBloc>(
                                                          context)
                                                      .add(AddRestoreTokens(
                                                          tokenId:
                                                              getDeleteTokensModel
                                                                  .data![index]
                                                                  .tokenId
                                                                  .toString()));
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.black,
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
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                          const VerticalSpacingWidget(height: 10),
                          // CommonButtonWidget(
                          //     title: "Restore Token",
                          //     onTapFunction: () {
                          //       BlocProvider.of<RestoreTokensBloc>(context)
                          //           .add(AddRestoreTokens(tokenId: selectedTokenNumbers));
                          //     }),
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

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}

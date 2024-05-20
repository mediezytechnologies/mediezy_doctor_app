// ignore_for_file: deprecated_member_use

import 'dart:developer';
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
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_demo.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/RemoveTokens/token_card_remove_widget.dart';
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
    final size = MediaQuery.of(context).size;
    Color eveningContainerColor;
    Color morningContainerColor;
    return Scaffold(
      backgroundColor: kCardColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Remove tokens",
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
                      style: size.width > 450
                          ? TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)
                          : TextStyle(
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
                fontSize: size.width > 450 ? 10.sp : 13.sp,
              ),
              labelStyle: size.width > 450
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )
                  : TextStyle(
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
                //! remove
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
                          const VerticalSpacingWidget(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Clinic",
                                  style: size.width > 450
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
                                          .add(FetchTokens(
                                              date: formatDate(),
                                              clinicId:
                                                  dController.initialIndex!));
                                      resetSelectedTokens();
                                    },
                                  );
                                }),
                                const VerticalSpacingWidget(height: 10),
                                DatePickerDemoClass(
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
                                        DateFormat('yyyy-MM-dd').format(date);
                                    selectedDate = date;
                                    BlocProvider.of<GetTokenBloc>(context).add(
                                      FetchTokens(
                                          date: formattedDate,
                                          clinicId: dController.initialIndex!),
                                    );
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
                                        return EmptyCutomeWidget(
                                            text: getTokenModel.message
                                                .toString());
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
                                              style: size.width > 450
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
                                                    size.width > 450 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 450 ? 110 : 70,
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
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        morningContainerColor,
                                                    textColor: getTokenModel
                                                                .schedule!
                                                                .schedule1![
                                                                    index]
                                                                .isTimeout ==
                                                            1
                                                        ? Colors.grey
                                                        : getTokenModel
                                                                    .schedule!
                                                                    .schedule1![
                                                                        index]
                                                                    .isBooked ==
                                                                1
                                                            ? Colors.grey
                                                            : selectedTokenNumbers.contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule1![
                                                                        index]
                                                                    .tokenId
                                                                    .toString())
                                                                ? Colors.white
                                                                : kTextColor,
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
                                                    isTimedOut: getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isTimeout!,
                                                    isReserved: getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isReserved!,
                                                    isBooked: getTokenModel
                                                        .schedule!
                                                        .schedule1![index]
                                                        .isBooked!,
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
                                              style: size.width > 450
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
                                                    size.width > 450 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 450 ? 110 : 70,
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
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        eveningContainerColor,
                                                    textColor: getTokenModel
                                                                .schedule!
                                                                .schedule2![
                                                                    index]
                                                                .isTimeout ==
                                                            1
                                                        ? Colors.grey
                                                        : getTokenModel
                                                                    .schedule!
                                                                    .schedule2![
                                                                        index]
                                                                    .isBooked ==
                                                                1
                                                            ? Colors.grey
                                                            : selectedTokenNumbers.contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule2![
                                                                        index]
                                                                    .tokenId
                                                                    .toString())
                                                                ? Colors.white
                                                                : kTextColor,
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
                                                    isTimedOut: getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isTimeout!,
                                                    isReserved: getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isReserved!,
                                                    isBooked: getTokenModel
                                                        .schedule!
                                                        .schedule2![index]
                                                        .isBooked!,
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
                                              style: size.width > 450
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
                                                    size.width > 450 ? 8 : 5,
                                                mainAxisExtent:
                                                    size.width > 450 ? 110 : 70,
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
                                                  child: TokenCardRemoveWidget(
                                                    color:
                                                        eveningContainerColor,
                                                    textColor: getTokenModel
                                                                .schedule!
                                                                .schedule3![
                                                                    index]
                                                                .isTimeout ==
                                                            1
                                                        ? Colors.grey
                                                        : getTokenModel
                                                                    .schedule!
                                                                    .schedule3![
                                                                        index]
                                                                    .isBooked ==
                                                                1
                                                            ? Colors.grey
                                                            : selectedTokenNumbers.contains(getTokenModel
                                                                    .schedule!
                                                                    .schedule3![
                                                                        index]
                                                                    .tokenId
                                                                    .toString())
                                                                ? Colors.white
                                                                : kTextColor,
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
                                                    isTimedOut: getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .isTimeout!,
                                                    isReserved: getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .isReserved!,
                                                    isBooked: getTokenModel
                                                        .schedule!
                                                        .schedule3![index]
                                                        .isBooked!,
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
                            style:
                                size.width > 450 ? greyTab10B600 : grey13B600,
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
                          const VerticalSpacingWidget(height: 10),
                          BlocBuilder<DeletedTokensBloc, DeletedTokensState>(
                            builder: (context, state) {
                              if (state is DeletedTokensLoading) {
                                return GeneralServices.instance
                                    .buildLoadingWidget(context);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 1,
                                        mainAxisSpacing: 10,
                                        crossAxisCount:
                                            size.width > 450 ? 6 : 4,
                                        mainAxisExtent:
                                            size.width > 450 ? 120 : 80,
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index]
                                                        .tokenNumber
                                                        .toString(),
                                                    style: size.width > 450
                                                        ? TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor)
                                                        : TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor),
                                                  ),
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index].time
                                                        .toString(),
                                                    style: size.width > 450
                                                        ? TextStyle(
                                                            fontSize: 7.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor)
                                                        : TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor),
                                                  ),
                                                  Text(
                                                    getDeleteTokensModel
                                                        .data![index].formatdate
                                                        .toString(),
                                                    style: size.width > 450
                                                        ? TextStyle(
                                                            fontSize: 7.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor)
                                                        : TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kTextColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: size.width > 450
                                                  ? 38.w
                                                  : 55.w,
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
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  radius: size.width > 450
                                                      ? 7.r
                                                      : 8.r,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.close,
                                                      size: size.width > 450
                                                          ? 7.sp
                                                          : 9.sp,
                                                      color: Colors.white,
                                                    ),
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

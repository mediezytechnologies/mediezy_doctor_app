// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/LiveToken/get_current_token_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/GetCurrentToken/get_current_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/names_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/TokenScreen/Widgets/token_show_card_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/demo.dart/dropdown/dropdown_bloc.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shimmer/shimmer.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  bool isCheck = false;
  final PageController controller = PageController();
  int currentIndex = 0;
  late ClinicGetModel clinicGetModel;
  late GetCurrentTokenModel getCurrentTokenModel;

  final HospitalController dController = Get.put(HospitalController());

  // late ValueNotifier<String> dropValueClinicNotifier;
  // String clinicId = "";
  // late String selectedClinicId;
  // List<HospitalDetails> clinicValues = [];

  DateTime selectedDate = DateTime.now();

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  String dropdownValue = 'All';

  late int? selectedValue;
  var items = {
    'All': 0,
    'Schedule 1': 1,
    'Schedule 2': 2,
    'Schedule 3': 3,
  };

  @override
  void initState() {
    selectedValue = items['All'];
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetCurrentTokenBloc>(context).add(FetchGetCurrentToken(
      clinicId: dController.initialIndex!,
      scheduleType: selectedValue.toString(),
    ));
    super.initState();
  }

  int clickedIndex = 0;

  bool isFirstCheckIn = true;

  int? length;
  int? currentTokenLength = 1;

  @override
  Widget build(BuildContext context) {
    // int? selectedValue = items['Schedule 1'];
    return RefreshIndicator(
      onRefresh: () async {
        // Add your refresh logic here, such as fetching new data
        // For example, you can add:
        BlocProvider.of<GetCurrentTokenBloc>(context).add(FetchGetCurrentToken(
          clinicId: dController.initialIndex!,
          scheduleType: selectedValue.toString(),
        ));
      },
      child: BlocListener<AddCheckinOrCheckoutBloc, AddCheckinOrCheckoutState>(
        listener: (context, state) {
          if (state is AddCheckinOrCheckoutLoaded) {
            BlocProvider.of<GetCurrentTokenBloc>(context)
                .add(FetchGetCurrentToken(
              clinicId: dController.initialIndex!,
              scheduleType: selectedValue.toString(),
            ));
          }
        },
        child: WillPopScope(
          onWillPop: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const BottomNavigationControlWidget()));
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Token"),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                  fontSize: 12.sp,
                                  color: kSubTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const VerticalSpacingWidget(height: 2),
                            GetBuilder<HospitalController>(builder: (clx) {
                              return CustomDropDown(
                                width: 190.w,
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
                                  BlocProvider.of<GetCurrentTokenBloc>(context)
                                      .add(FetchGetCurrentToken(
                                    clinicId: dController.initialIndex!,
                                    scheduleType: selectedValue.toString(),
                                  ));
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
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kSubTextColor),
                            ),
                            const VerticalSpacingWidget(height: 2),
                            BlocBuilder<DropdownBloc, DropdownState>(
                              builder: (context, state) {
                                return CustomDropDown(
                                  width: 140.w,
                                  value: state.changValue,
                                  items: items.entries
                                      .map<DropdownMenuItem<String>>(
                                          (MapEntry<String, int?> entry) {
                                    // Specify the return type
                                    return DropdownMenuItem<String>(
                                      value: entry.key,
                                      child: Text(entry.key),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    BlocProvider.of<DropdownBloc>(context).add(
                                        DropdownSelectEvent(
                                            dropdownSelectnvLalu: newValue!));
                                    // dropdownValue = newValue!;
                                    selectedValue = items[newValue];
                                    BlocProvider.of<GetCurrentTokenBloc>(
                                            context)
                                        .add(FetchGetCurrentToken(
                                      clinicId: dController.initialIndex!,
                                      scheduleType: selectedValue.toString(),
                                    ));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                    //! token
                    BlocBuilder<GetCurrentTokenBloc, GetCurrentTokenState>(
                      builder: (context, state) {
                        if (state is GetCurrentTokenLoading) {
                          // return _buildLoadingWidget();
                        }
                        if (state is GetCurrentTokenError) {
                          return const Center(
                            child: Text("Something Went Wrong"),
                          );
                        }
                        if (state is GetCurrentTokenLoaded) {
                          getCurrentTokenModel =
                              BlocProvider.of<GetCurrentTokenBloc>(context)
                                  .getCurrentTokenModel;
                          if (getCurrentTokenModel.tokens == null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 100.h),
                                    height: 250.h,
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/images/no_tokens.png"),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Expanded(
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getCurrentTokenModel.tokens!.length,
                              controller: controller,
                              onPageChanged: (index) {
                                currentTokenLength = index + 1;
                                clickedIndex = index;
                                currentIndex =
                                    index % getCurrentTokenModel.tokens!.length;
                              },
                              itemBuilder: (context, index) {
                                length = getCurrentTokenModel.tokens!.length;

                                if (clickedIndex != 0) {
                                  index = clickedIndex;
                                }
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller
                                                  .jumpToPage(currentIndex - 1);
                                            },
                                            icon: Icon(Icons.arrow_back_ios,
                                                color: kMainColor, size: 25.sp),
                                          ),
                                          TokenShowCardWidget(
                                            tokenNumber: getCurrentTokenModel
                                                .tokens![index].tokenNumber
                                                .toString(),
                                            tokenTime: getCurrentTokenModel
                                                .tokens![index].tokenTime
                                                .toString(),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller
                                                  .jumpToPage(currentIndex + 1);
                                            },
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: kMainColor, size: 25.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        // height: 390.h,
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FadedScaleAnimation(
                                                    scaleDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    fadeDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    child: PatientImageWidget(
                                                        patientImage: getCurrentTokenModel
                                                                    .tokens![
                                                                        index]
                                                                    .userImage ==
                                                                null
                                                            ? ""
                                                            : getCurrentTokenModel
                                                                .tokens![index]
                                                                .userImage
                                                                .toString(),
                                                        radius: 45.r)),
                                                // const HorizontalSpacingWidget(
                                                //     width: 40),
                                                //! name
                                                SizedBox(
                                                  width: 140.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        getCurrentTokenModel
                                                            .tokens![index]
                                                            .patientName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      VerticalSpacingWidget(
                                                          height: 5.h),
                                                      Row(
                                                        children: [
                                                          getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .mediezyPatientId ==
                                                                  null
                                                              ? Container()
                                                              : getCurrentTokenModel
                                                                          .tokens![
                                                                              index]
                                                                          .mediezyPatientId ==
                                                                      null
                                                                  ? Container()
                                                                  : Text(
                                                                      getCurrentTokenModel
                                                                          .tokens![
                                                                              index]
                                                                          .mediezyPatientId!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                        ],
                                                      ),
                                                      const VerticalSpacingWidget(
                                                          height: 10),
                                                      Text(
                                                        getCurrentTokenModel
                                                            .tokens![index]
                                                            .displayAge
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13.sp,
                                                            color:
                                                                kSubTextColor),
                                                      ),
                                                      const HorizontalSpacingWidget(
                                                          width: 60),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30.h,
                                                  // width: 100.w,
                                                  decoration: BoxDecoration(
                                                    color: kMainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 5.w),
                                                          child: Text(
                                                            "Pending",
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: kCardColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 25.h,
                                                          width: 28.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kCardColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              // "12",
                                                              "${length! - currentTokenLength!}",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color:
                                                                    kTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 10),
                                            //! appoinment dat
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Mobile No",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      color: kSubTextColor),
                                                ),
                                                Text(
                                                  "Schedule ${getCurrentTokenModel.tokens![index].scheduleType}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      color: kSubTextColor),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  getCurrentTokenModel
                                                      .tokens![index].mobileNo
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.sp,
                                                      color: kTextColor),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    String mobileNumber =
                                                        getCurrentTokenModel
                                                            .tokens![index]
                                                            .mobileNo
                                                            .toString();

                                                    // Call the phone number using the flutter_phone_direct_caller plugin
                                                    FlutterPhoneDirectCaller
                                                        .callNumber(
                                                            mobileNumber);
                                                  },
                                                  icon: Icon(
                                                    Icons.call,
                                                    size: 16.sp,
                                                    color: kMainColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            //! appointment for
                                            Text(
                                              'Appointment for',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: kSubTextColor),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 3),
                                            getCurrentTokenModel.tokens![index].mainSymptoms!.isEmpty
                                                ? Container()
                                                : Text(
                                              getCurrentTokenModel.tokens![index].mainSymptoms!
                                                  .first.mainsymptoms
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: kTextColor),
                                            ),
                                            // const VerticalSpacingWidget(height: 5),
                                            getCurrentTokenModel.tokens![index].otherSymptoms!.isEmpty
                                                ? Container()
                                                : Wrap(
                                              children: [
                                                Text(
                                                  getCurrentTokenModel.tokens![index].otherSymptoms!
                                                      .map((symptom) => "${symptom.symtoms}")
                                                      .join(', '),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                    color: kTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Intensity',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                          color: kSubTextColor),
                                                    ),
                                                    const VerticalSpacingWidget(
                                                        height: 3),
                                                    Text(
                                                      getCurrentTokenModel
                                                          .tokens![index]
                                                          .whenitstart
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                          color: kTextColor),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'When it Start',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                          color: kSubTextColor),
                                                    ),
                                                    const VerticalSpacingWidget(
                                                        height: 3),
                                                    Text(
                                                      getCurrentTokenModel
                                                          .tokens![index]
                                                          .whenitcomes
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                          color: kTextColor),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 20),
                                            getCurrentTokenModel.tokens![index]
                                                        .isCompleted ==
                                                    1
                                                ? ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: getCurrentTokenModel
                                                        .tokens![
                                                    index]
                                                        .medicine!.length,
                                                    separatorBuilder: (BuildContext
                                                                context,
                                                            int index) =>
                                                        const VerticalSpacingWidget(
                                                            height: 3),
                                                    itemBuilder:
                                                        (context, indexx) {
                                                      return Column(
                                                        children: [
                                                          const VerticalSpacingWidget(height: 5),
                                                          getCurrentTokenModel
                                                                  .tokens![
                                                                      index]
                                                                  .medicine!
                                                                  .isEmpty
                                                              ? Container()
                                                              : NamesWidget(
                                                                  firstText:
                                                                      "Medicine name : ",
                                                                  secondText: getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .medicine![indexx]
                                                                      .medicineName
                                                                      .toString()),
                                                          getCurrentTokenModel
                                                                  .tokens![
                                                                      index]
                                                                  .medicine!
                                                                  .isEmpty
                                                              ? Container()
                                                              : NamesWidget(
                                                                  firstText:
                                                                      "Dosage : ",
                                                                  secondText: getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .medicine![indexx]
                                                                      .dosage
                                                                      .toString()),
                                                          getCurrentTokenModel
                                                                  .tokens![
                                                                      index]
                                                                  .medicine!
                                                                  .isEmpty
                                                              ? Container()
                                                              : NamesWidget(
                                                                  firstText:
                                                                      "No of Days : ",
                                                                  secondText: getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .medicine![indexx]
                                                                      .noOfDays
                                                                      .toString()),
                                                          getCurrentTokenModel
                                                                  .tokens![
                                                                      index]
                                                                  .medicine!
                                                                  .isEmpty
                                                              ? Container()
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                      "Medicine time : ",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize: 12.sp,
                                                                          color: kSubTextColor),
                                                                    ),
                                                                    Text(
                                                                      getCurrentTokenModel.tokens![index].medicine![indexx].morning ==
                                                                              1
                                                                          ? "Morning,"
                                                                          : "",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize: 12.sp,
                                                                          color: kTextColor),
                                                                    ),
                                                                    Text(
                                                                      getCurrentTokenModel.tokens![index].medicine![indexx].noon ==
                                                                              1
                                                                          ? "Noon,"
                                                                          : "",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize: 12.sp,
                                                                          color: kTextColor),
                                                                    ),
                                                                    Text(
                                                                      getCurrentTokenModel.tokens![index].medicine![indexx].night ==
                                                                              1
                                                                          ? "Night"
                                                                          : "",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize: 12.sp,
                                                                          color: kTextColor),
                                                                    )
                                                                  ],
                                                                ),
                                                          getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .patientData!
                                                                      .labName ==
                                                                  null
                                                              ? Container()
                                                              : NamesWidget(
                                                                  firstText:
                                                                      "Lab name : ",
                                                                  secondText: getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .patientData!
                                                                      .labName
                                                                      .toString()),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                : Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      AddCheckinOrCheckoutBloc>(
                                                                  context)
                                                              .add(
                                                            AddCheckinOrCheckout(
                                                              clinicId: dController
                                                                  .initialIndex!,
                                                              isCompleted: 0,
                                                              isCheckin: 0,
                                                              tokenNumber:
                                                                  getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .tokenNumber
                                                                      .toString(),
                                                              isReached: "1",
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 40.h,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: getCurrentTokenModel
                                                                        .tokens![
                                                                            index]
                                                                        .isReached ==
                                                                    1
                                                                ? kCardColor
                                                                : kMainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            border: Border.all(
                                                                width: .5,
                                                                color:
                                                                    kMainColor),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image(
                                                                image: const AssetImage(
                                                                    "assets/icons/reached.png"),
                                                                color: getCurrentTokenModel
                                                                            .tokens![index]
                                                                            .isReached ==
                                                                        1
                                                                    ? kMainColor
                                                                    : kCardColor,
                                                                height: 30.h,
                                                                width: 30.w,
                                                              ),
                                                              const HorizontalSpacingWidget(
                                                                  width: 5),
                                                              Text(
                                                                "Reached",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: getCurrentTokenModel
                                                                              .tokens![index]
                                                                              .isReached ==
                                                                          1
                                                                      ? kMainColor
                                                                      : kCardColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const VerticalSpacingWidget(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          //! check in
                                                          InkWell(
                                                            onTap: () {
                                                              if (getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .isCheckIn !=
                                                                  1) {
                                                                if (isFirstCheckIn &&
                                                                    index ==
                                                                        0) {
                                                                  // Show alert dialog only for the first token's check-in
                                                                  GeneralServices
                                                                      .instance
                                                                      .appCloseDialogue(
                                                                          context,
                                                                          "Are you sure you want to start the consultation",
                                                                          () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    // Execute the BlocProvider logic for the first token only when the user presses OK
                                                                    BlocProvider.of<AddCheckinOrCheckoutBloc>(
                                                                            context)
                                                                        .add(
                                                                      AddCheckinOrCheckout(
                                                                        clinicId:
                                                                            dController.initialIndex!,
                                                                        isCompleted:
                                                                            0,
                                                                        isCheckin:
                                                                            1,
                                                                        tokenNumber: getCurrentTokenModel
                                                                            .tokens![index]
                                                                            .tokenNumber
                                                                            .toString(),
                                                                        isReached:
                                                                            '',
                                                                      ),
                                                                    );
                                                                    isFirstCheckIn =
                                                                        false; // Update is
                                                                  });
                                                                } else {
                                                                  // For tokens other than the first one, directly execute the BlocProvider logic
                                                                  clickedIndex =
                                                                      index;
                                                                  BlocProvider.of<
                                                                              AddCheckinOrCheckoutBloc>(
                                                                          context)
                                                                      .add(
                                                                    AddCheckinOrCheckout(
                                                                      clinicId:
                                                                          dController
                                                                              .initialIndex!,
                                                                      isCompleted:
                                                                          0,
                                                                      isCheckin:
                                                                          1,
                                                                      tokenNumber: getCurrentTokenModel
                                                                          .tokens![
                                                                              index]
                                                                          .tokenNumber
                                                                          .toString(),
                                                                      isReached:
                                                                          '',
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 165.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: getCurrentTokenModel
                                                                            .tokens![index]
                                                                            .isCheckIn ==
                                                                        1
                                                                    ? kCardColor
                                                                    : kMainColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Image(
                                                                    image: const AssetImage(
                                                                        "assets/icons/check_in.png"),
                                                                    color: getCurrentTokenModel.tokens![index].isCheckIn ==
                                                                            1
                                                                        ? kMainColor
                                                                        : kCardColor,
                                                                  ),
                                                                  Text(
                                                                    "Check In",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: getCurrentTokenModel.tokens![index].isCheckIn ==
                                                                              1
                                                                          ? kMainColor
                                                                          : kCardColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          //! check out
                                                          InkWell(
                                                            onTap: () {
                                                              if (getCurrentTokenModel
                                                                      .tokens![
                                                                          index]
                                                                      .isCompleted !=
                                                                  1) {
                                                                clickedIndex =
                                                                    index;
                                                                BlocProvider.of<
                                                                            AddCheckinOrCheckoutBloc>(
                                                                        context)
                                                                    .add(
                                                                  AddCheckinOrCheckout(
                                                                    clinicId:
                                                                        dController
                                                                            .initialIndex!,
                                                                    isCompleted:
                                                                        1,
                                                                    isCheckin:
                                                                        1,
                                                                    tokenNumber: getCurrentTokenModel
                                                                        .tokens![
                                                                            index]
                                                                        .tokenNumber
                                                                        .toString(),
                                                                    isReached:
                                                                        '',
                                                                  ),
                                                                );
                                                              }
                                                              controller.jumpToPage(
                                                                  currentIndex +
                                                                      1);
                                                            },
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 165.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: getCurrentTokenModel
                                                                            .tokens![index]
                                                                            .isCompleted ==
                                                                        1
                                                                    ? kCardColor
                                                                    : kMainColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Image(
                                                                    image: const AssetImage(
                                                                        "assets/icons/check_out.png"),
                                                                    color: getCurrentTokenModel.tokens![index].isCompleted ==
                                                                            1
                                                                        ? kMainColor
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                  Text(
                                                                    "Check Out",
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: getCurrentTokenModel.tokens![index].isCompleted ==
                                                                                1
                                                                            ? kMainColor
                                                                            : Colors.white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                          // ,
                          // Positioned(
                          // top: 40.h,
                          // left: 50.w,
                          // child: IconButton(
                          // onPressed: () {
                          // controller.jumpToPage(currentIndex - 1);
                          // },
                          // icon: Icon(Icons.arrow_back_ios,
                          // color: kMainColor, size: 30.sp),
                          // ),
                          // ),
                          // Positioned(
                          // top: 40.h,
                          // left: 270.w,
                          // child: IconButton(
                          // onPressed: () {
                          // controller.jumpToPage(currentIndex + 1);
                          // },
                          // icon: Icon(Icons.arrow_forward_ios,
                          // color: kMainColor, size: 30.sp),
                          // ),
                          // ),
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 600.h,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              SizedBox(
                  height: 520.h,
                  width: 700.w,
                  child: Column(
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: kMainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 390.h,
                        // width: 1000.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 45,
                                      backgroundImage: AssetImage(
                                          "assets/icons/profile pic.png")),
                                ),
                                const HorizontalSpacingWidget(width: 40),
                                //! name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 10.h,
                                      width: 100.w,
                                      color: Colors.white,
                                    ),
                                    const VerticalSpacingWidget(height: 10),
                                    Container(
                                      height: 10.h,
                                      width: 100.w,
                                      color: Colors.white,
                                    ),
                                    const VerticalSpacingWidget(height: 10),
                                    Container(
                                      height: 10.h,
                                      width: 100.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 10),
                            //! appoinment date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 120.w,
                                  color: Colors.white,
                                ),
                                Container(
                                  height: 30.h,
                                  width: 120.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 10),
                            Container(
                              height: 30.h,
                              width: 120.w,
                              color: Colors.white,
                            ),
                            //! appointment for
                            const VerticalSpacingWidget(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 120.w,
                                  color: Colors.white,
                                ),
                                Container(
                                  height: 30.h,
                                  width: 120.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const VerticalSpacingWidget(height: 30),
                            //! reschedule
                            Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kCardColor,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(width: .5, color: kMainColor),
                              ),
                            ),
                            const VerticalSpacingWidget(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //! check in
                                Container(
                                  height: 40.h,
                                  width: 165.w,
                                  decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                //! check out
                                Container(
                                  height: 40.h,
                                  width: 165.w,
                                  decoration: BoxDecoration(
                                    color: kCardColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}

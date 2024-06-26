// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:mediezy_doctor/Ui/CommonWidgets/select_clinic_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
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
  late PageController pageController;
  int currentIndex = 0;
  late ClinicGetModel clinicGetModel;
  late GetCurrentTokenModel getCurrentTokenModel;

  final HospitalController dController = Get.put(HospitalController());

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

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
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
    final size = MediaQuery.of(context).size;
    // int? selectedValue = items['Schedule 1'];
    //int bookingLength = length! - currentTokenLength!;

    return RefreshIndicator(
      onRefresh: () async {
        // Add your refresh logic here, such as fetching new data
        // For example, you can add:
        BlocProvider.of<GetCurrentTokenBloc>(context).add(
          FetchGetCurrentToken(
            clinicId: dController.initialIndex!,
            scheduleType: selectedValue.toString(),
          ),
        );
      },
      child: BlocListener<AddCheckinOrCheckoutBloc, AddCheckinOrCheckoutState>(
        listener: (context, state) {
          if (state is AddCheckinOrCheckoutLoaded) {
            BlocProvider.of<GetCurrentTokenBloc>(context).add(
              FetchGetCurrentToken(
                clinicId: dController.initialIndex!,
                scheduleType: selectedValue.toString(),
              ),
            );
          }
        },
        child: WillPopScope(
          onWillPop: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const BottomNavigationControlWidget(),
              ),
            );
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Token"),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                final connectivityResult = snapshot.data;
                if (connectivityResult == ConnectivityResult.none) {
                  return Scaffold(
                    backgroundColor: kCardColor,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 180.h,
                            width: 300.w,
                            child: Image.asset(
                              "assets/images/no connection.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        Text(
                          "Please check your internet connection",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SelectClinicWidget(
                                onChanged: (newValue) {
                                  log(newValue!);
                                  dController.dropdownValueChanging(
                                      newValue, dController.initialIndex!);
                                  BlocProvider.of<GetCurrentTokenBloc>(context)
                                      .add(
                                    FetchGetCurrentToken(
                                      clinicId: dController.initialIndex!,
                                      scheduleType: selectedValue.toString(),
                                    ),
                                  );
                                },
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
                                  const VerticalSpacingWidget(height: 3),
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
                                          BlocProvider.of<DropdownBloc>(context)
                                              .add(DropdownSelectEvent(
                                                  dropdownSelectnvLalu:
                                                      newValue!));
                                          // dropdownValue = newValue!;
                                          selectedValue = items[newValue];
                                          BlocProvider.of<GetCurrentTokenBloc>(
                                                  context)
                                              .add(FetchGetCurrentToken(
                                            clinicId: dController.initialIndex!,
                                            scheduleType:
                                                selectedValue.toString(),
                                          ));
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 15),
                          //! token
                          BlocBuilder<GetCurrentTokenBloc,
                              GetCurrentTokenState>(
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
                                    BlocProvider.of<GetCurrentTokenBloc>(
                                            context)
                                        .getCurrentTokenModel;
                                if (getCurrentTokenModel.tokens == null) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        getCurrentTokenModel.tokens!.length,
                                    controller: pageController,
                                    onPageChanged: (index) {
                                      currentTokenLength = index + 1;
                                      clickedIndex = index;
                                      currentIndex = index %
                                          getCurrentTokenModel.tokens!.length;
                                      // bookingLength
                                    },
                                    itemBuilder: (context, index) {
                                      length =
                                          getCurrentTokenModel.tokens!.length;
                                      int bookingPending =
                                          length! - 1 - currentIndex;

                                      log("token length: $currentTokenLength");

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
                                                    log("pressed");
                                                    if (currentIndex > 0) {
                                                      log("pressed no zero");
                                                      currentIndex--;
                                                      pageController
                                                          .animateToPage(
                                                        currentIndex,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                      BlocProvider.of<
                                                                  GetCurrentTokenBloc>(
                                                              context)
                                                          .add(
                                                        FetchGetCurrentToken(
                                                          clinicId: dController
                                                              .initialIndex!,
                                                          scheduleType:
                                                              selectedValue
                                                                  .toString(),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: kMainColor,
                                                      size: size.width > 450
                                                          ? 22.sp
                                                          : 30.sp),
                                                ),
                                                TokenShowCardWidget(
                                                  tokenNumber:
                                                      getCurrentTokenModel
                                                          .tokens![currentIndex]
                                                          .tokenNumber
                                                          .toString(),
                                                  tokenTime:
                                                      getCurrentTokenModel
                                                          .tokens![currentIndex]
                                                          .tokenTime
                                                          .toString(),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    if (currentIndex <
                                                        getCurrentTokenModel
                                                                .tokens!
                                                                .length -
                                                            1) {
                                                      currentIndex++;
                                                      pageController
                                                          .animateToPage(
                                                        currentIndex,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                      BlocProvider.of<
                                                                  GetCurrentTokenBloc>(
                                                              context)
                                                          .add(
                                                        FetchGetCurrentToken(
                                                          clinicId: dController
                                                              .initialIndex!,
                                                          scheduleType:
                                                              selectedValue
                                                                  .toString(),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  // onPressed: () {
                                                  //   controller
                                                  //       .jumpToPage(currentIndex + 1);
                                                  // },
                                                  icon: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: kMainColor,
                                                      size: size.width > 450
                                                          ? 22.sp
                                                          : 30.sp),
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
                                                                  milliseconds:
                                                                      400),
                                                          fadeDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      400),
                                                          child: PatientImageWidget(
                                                              patientImage: getCurrentTokenModel
                                                                          .tokens![
                                                                              currentIndex]
                                                                          .userImage ==
                                                                      null
                                                                  ? ""
                                                                  : getCurrentTokenModel
                                                                      .tokens![
                                                                          currentIndex]
                                                                      .userImage
                                                                      .toString(),
                                                              radius: 35.r)),
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
                                                                  .tokens![
                                                                      currentIndex]
                                                                  .patientName
                                                                  .toString(),
                                                              style: size.width >
                                                                      450
                                                                  ? blackTab10B600
                                                                  : blackTab15B600,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            const VerticalSpacingWidget(
                                                                height: 5),
                                                            Row(
                                                              children: [
                                                                getCurrentTokenModel
                                                                            .tokens![
                                                                                currentIndex]
                                                                            .mediezyPatientId ==
                                                                        null
                                                                    ? Container()
                                                                    : getCurrentTokenModel.tokens![currentIndex].mediezyPatientId ==
                                                                            null
                                                                        ? Container()
                                                                        : Text(
                                                                            getCurrentTokenModel.tokens![currentIndex].mediezyPatientId!,
                                                                            style: size.width > 400
                                                                                ? blackTab10B600
                                                                                : black11Bbold,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                              ],
                                                            ),
                                                            const VerticalSpacingWidget(
                                                                height: 10),
                                                            Text(
                                                              getCurrentTokenModel
                                                                  .tokens![
                                                                      currentIndex]
                                                                  .displayAge
                                                                  .toString(),
                                                              style: size.width >
                                                                      450
                                                                  ? greyTab10B400
                                                                  : grey12B400,
                                                            ),
                                                            const HorizontalSpacingWidget(
                                                                width: 60),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30.h,
                                                        // width: 100.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kMainColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 5
                                                                            .w),
                                                                child: Text(
                                                                  "Pending",
                                                                  style: size.width >
                                                                          450
                                                                      ? TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          color:
                                                                              kCardColor,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )
                                                                      : TextStyle(
                                                                          fontSize:
                                                                              15.sp,
                                                                          color:
                                                                              kCardColor,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                ),
                                                              ),

                                                              //==========================================================
                                                              Container(
                                                                height: 25.h,
                                                                width:
                                                                    size.width >
                                                                            450
                                                                        ? 20.w
                                                                        : 28.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      kCardColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.r),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    // "12",
                                                                    "$bookingPending",
                                                                    style: size.width >
                                                                            400
                                                                        ? blackTab12B600
                                                                        : black15B600,
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
                                                        style: size.width > 450
                                                            ? greyTabMain
                                                            : greyMain,
                                                      ),
                                                      Text(
                                                        "Schedule ${getCurrentTokenModel.tokens![currentIndex].scheduleType}",
                                                        style: size.width > 450
                                                            ? greyTabMain
                                                            : greyMain,
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
                                                            .tokens![
                                                                currentIndex]
                                                            .mobileNo
                                                            .toString(),
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          String mobileNumber =
                                                              getCurrentTokenModel
                                                                  .tokens![
                                                                      currentIndex]
                                                                  .mobileNo
                                                                  .toString();

                                                          // Call the phone number using the flutter_phone_direct_caller plugin
                                                          FlutterPhoneDirectCaller
                                                              .callNumber(
                                                                  mobileNumber);
                                                        },
                                                        icon: Icon(
                                                          Icons.call,
                                                          size: size.width > 450
                                                              ? 15.sp
                                                              : 25.sp,
                                                          color: kMainColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //! appointment for
                                                  Text(
                                                    'Appointment for',
                                                    style: size.width > 450
                                                        ? greyTabMain
                                                        : greyMain,
                                                  ),
                                                  const VerticalSpacingWidget(
                                                      height: 3),
                                                  getCurrentTokenModel
                                                          .tokens![currentIndex]
                                                          .mainSymptoms!
                                                          .isEmpty
                                                      ? Container()
                                                      : Text(
                                                          getCurrentTokenModel
                                                              .tokens![
                                                                  currentIndex]
                                                              .mainSymptoms!
                                                              .first
                                                              .mainsymptoms
                                                              .toString(),
                                                          style: size.width >
                                                                  450
                                                              ? blackTabMainText
                                                              : blackMainText,
                                                        ),
                                                  // const VerticalSpacingWidget(height: 5),
                                                  getCurrentTokenModel
                                                          .tokens![currentIndex]
                                                          .otherSymptoms!
                                                          .isEmpty
                                                      ? Container()
                                                      : Wrap(
                                                          children: [
                                                            Text(
                                                              getCurrentTokenModel
                                                                  .tokens![
                                                                      currentIndex]
                                                                  .otherSymptoms!
                                                                  .map((symptom) =>
                                                                      "${symptom.symtoms}")
                                                                  .join(', '),
                                                              style: size.width >
                                                                      450
                                                                  ? blackTabMainText
                                                                  : blackMainText,
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Intensity',
                                                            style: size.width >
                                                                    450
                                                                ? greyTabMain
                                                                : greyMain,
                                                          ),
                                                          const VerticalSpacingWidget(
                                                              height: 3),
                                                          Text(
                                                            getCurrentTokenModel
                                                                .tokens![
                                                                    currentIndex]
                                                                .whenitstart
                                                                .toString(),
                                                            style: size.width >
                                                                    450
                                                                ? blackTabMainText
                                                                : blackMainText,
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'When it Start',
                                                            style: size.width >
                                                                    450
                                                                ? greyTabMain
                                                                : greyMain,
                                                          ),
                                                          const VerticalSpacingWidget(
                                                              height: 3),
                                                          Text(
                                                            getCurrentTokenModel
                                                                .tokens![
                                                                    currentIndex]
                                                                .whenitcomes
                                                                .toString(),
                                                            style: size.width >
                                                                    450
                                                                ? blackTabMainText
                                                                : blackMainText,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  getCurrentTokenModel
                                                              .tokens![
                                                                  currentIndex]
                                                              .isCompleted ==
                                                          1
                                                      ? const VerticalSpacingWidget(
                                                          height: 0)
                                                      : const VerticalSpacingWidget(
                                                          height: 50),
                                                  getCurrentTokenModel
                                                              .tokens![
                                                                  currentIndex]
                                                              .isCompleted ==
                                                          1
                                                      ? ListView.separated(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemCount:
                                                              getCurrentTokenModel
                                                                  .tokens![
                                                                      currentIndex]
                                                                  .medicine!
                                                                  .length,
                                                          separatorBuilder: (BuildContext
                                                                      context,
                                                                  int index) =>
                                                              const VerticalSpacingWidget(
                                                                  height: 3),
                                                          itemBuilder: (context,
                                                              indexx) {
                                                            return Column(
                                                              children: [
                                                                const VerticalSpacingWidget(
                                                                    height: 5),
                                                                getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine!
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : NamesWidget(
                                                                        firstText:
                                                                            "Medicine name : ",
                                                                        secondText: getCurrentTokenModel
                                                                            .tokens![currentIndex]
                                                                            .medicine![indexx]
                                                                            .medicineName
                                                                            .toString()),
                                                                getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine!
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : NamesWidget(
                                                                        firstText:
                                                                            "Dosage : ",
                                                                        secondText: getCurrentTokenModel
                                                                            .tokens![currentIndex]
                                                                            .medicine![indexx]
                                                                            .dosage
                                                                            .toString()),
                                                                getCurrentTokenModel
                                                                            .tokens![
                                                                                currentIndex]
                                                                            .medicine![
                                                                                indexx]
                                                                            .interval ==
                                                                        null
                                                                    ? Container()
                                                                    : NamesWidget(
                                                                        firstText:
                                                                            "Interval : ",
                                                                        secondText:
                                                                            "${getCurrentTokenModel.tokens![currentIndex].medicine![indexx].interval.toString()} ${getCurrentTokenModel.tokens![currentIndex].medicine![indexx].timeSection.toString()}"),
                                                                getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine!
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : NamesWidget(
                                                                        firstText:
                                                                            "No of Days : ",
                                                                        secondText: getCurrentTokenModel
                                                                            .tokens![currentIndex]
                                                                            .medicine![indexx]
                                                                            .noOfDays
                                                                            .toString()),
                                                                getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine!
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : Row(
                                                                        children: [
                                                                          Text(
                                                                            "Medicine time : ",
                                                                            style: size.width > 400
                                                                                ? greyTabMain
                                                                                : greyMain,
                                                                          ),
                                                                          Text(
                                                                            getCurrentTokenModel.tokens![currentIndex].medicine![indexx].morning == 1
                                                                                ? "Morning,"
                                                                                : "",
                                                                            style: size.width > 400
                                                                                ? blackTabMainText
                                                                                : blackMainText,
                                                                          ),
                                                                          Text(
                                                                            getCurrentTokenModel.tokens![currentIndex].medicine![indexx].noon == 1
                                                                                ? "Noon,"
                                                                                : "",
                                                                            style: size.width > 400
                                                                                ? blackTabMainText
                                                                                : blackMainText,
                                                                          ),
                                                                          Text(
                                                                            getCurrentTokenModel.tokens![currentIndex].medicine![indexx].night == 1
                                                                                ? "Night"
                                                                                : "",
                                                                            style: size.width > 400
                                                                                ? blackTabMainText
                                                                                : blackMainText,
                                                                          )
                                                                        ],
                                                                      ),
                                                                getCurrentTokenModel
                                                                            .tokens![
                                                                                currentIndex]
                                                                            .patientData!
                                                                            .labName ==
                                                                        null
                                                                    ? Container()
                                                                    : NamesWidget(
                                                                        firstText:
                                                                            "Lab name : ",
                                                                        secondText: getCurrentTokenModel
                                                                            .tokens![currentIndex]
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
                                                                    clinicId:
                                                                        dController
                                                                            .initialIndex!,
                                                                    isCompleted:
                                                                        0,
                                                                    isCheckin:
                                                                        0,
                                                                    tokenNumber: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .tokenNumber
                                                                        .toString(),
                                                                    isReached:
                                                                        "1",
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 40.h,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: getCurrentTokenModel
                                                                              .tokens![currentIndex]
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
                                                                      color: getCurrentTokenModel.tokens![currentIndex].isReached ==
                                                                              1
                                                                          ? kMainColor
                                                                          : kCardColor,
                                                                      height: size.width >
                                                                              400
                                                                          ? 30.h
                                                                          : 40.h,
                                                                      width: size.width >
                                                                              400
                                                                          ? 30.w
                                                                          : 40.w,
                                                                    ),
                                                                    const HorizontalSpacingWidget(
                                                                        width:
                                                                            5),
                                                                    Text(
                                                                      "Reached",
                                                                      style: size.width >
                                                                              400
                                                                          ? TextStyle(
                                                                              fontSize: 13.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: getCurrentTokenModel.tokens![currentIndex].isReached == 1 ? kMainColor : kCardColor,
                                                                            )
                                                                          : TextStyle(
                                                                              fontSize: 16.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: getCurrentTokenModel.tokens![currentIndex].isReached == 1 ? kMainColor : kCardColor,
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
                                                                            .tokens![currentIndex]
                                                                            .isCheckIn !=
                                                                        1) {
                                                                      if (isFirstCheckIn &&
                                                                          index ==
                                                                              0) {
                                                                        // Show alert dialog only for the first token's check-in
                                                                        GeneralServices.instance.appCloseDialogue(
                                                                            context,
                                                                            "Are you sure you want to start the consultation",
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          // Execute the BlocProvider logic for the first token only when the user presses OK
                                                                          BlocProvider.of<AddCheckinOrCheckoutBloc>(context)
                                                                              .add(
                                                                            AddCheckinOrCheckout(
                                                                              clinicId: dController.initialIndex!,
                                                                              isCompleted: 0,
                                                                              isCheckin: 1,
                                                                              tokenNumber: getCurrentTokenModel.tokens![currentIndex].tokenNumber.toString(),
                                                                              isReached: '',
                                                                            ),
                                                                          );
                                                                          isFirstCheckIn =
                                                                              false; // Update is
                                                                        });
                                                                      } else {
                                                                        // For tokens other than the first one, directly execute the BlocProvider logic
                                                                        clickedIndex =
                                                                            index;
                                                                        BlocProvider.of<AddCheckinOrCheckoutBloc>(context)
                                                                            .add(
                                                                          AddCheckinOrCheckout(
                                                                            clinicId:
                                                                                dController.initialIndex!,
                                                                            isCompleted:
                                                                                0,
                                                                            isCheckin:
                                                                                1,
                                                                            tokenNumber:
                                                                                getCurrentTokenModel.tokens![currentIndex].tokenNumber.toString(),
                                                                            isReached:
                                                                                '',
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        165.w,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: getCurrentTokenModel.tokens![currentIndex].isCheckIn ==
                                                                              1
                                                                          ? kCardColor
                                                                          : kMainColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Image(
                                                                          image:
                                                                              const AssetImage("assets/icons/check_in.png"),
                                                                          color: getCurrentTokenModel.tokens![currentIndex].isCheckIn == 1
                                                                              ? kMainColor
                                                                              : kCardColor,
                                                                        ),
                                                                        Text(
                                                                          "Check In",
                                                                          style: size.width > 400
                                                                              ? TextStyle(
                                                                                  fontSize: 13.sp,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: getCurrentTokenModel.tokens![currentIndex].isCheckIn == 1 ? kMainColor : kCardColor,
                                                                                )
                                                                              : TextStyle(
                                                                                  fontSize: 16.sp,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: getCurrentTokenModel.tokens![currentIndex].isCheckIn == 1 ? kMainColor : kCardColor,
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
                                                                            .tokens![currentIndex]
                                                                            .isCompleted !=
                                                                        1) {
                                                                      clickedIndex =
                                                                          index;
                                                                      BlocProvider.of<AddCheckinOrCheckoutBloc>(
                                                                              context)
                                                                          .add(
                                                                        AddCheckinOrCheckout(
                                                                          clinicId:
                                                                              dController.initialIndex!,
                                                                          isCompleted:
                                                                              1,
                                                                          isCheckin:
                                                                              0,
                                                                          tokenNumber: getCurrentTokenModel
                                                                              .tokens![currentIndex]
                                                                              .tokenNumber
                                                                              .toString(),
                                                                          isReached:
                                                                              '',
                                                                        ),
                                                                      );
                                                                    }
                                                                    if (currentIndex <
                                                                        getCurrentTokenModel.tokens!.length -
                                                                            1) {
                                                                      currentIndex++;
                                                                      pageController
                                                                          .animateToPage(
                                                                        currentIndex,
                                                                        duration:
                                                                            const Duration(milliseconds: 500),
                                                                        curve: Curves
                                                                            .easeInOut,
                                                                      );
                                                                      BlocProvider.of<GetCurrentTokenBloc>(
                                                                              context)
                                                                          .add(
                                                                        FetchGetCurrentToken(
                                                                          clinicId:
                                                                              dController.initialIndex!,
                                                                          scheduleType:
                                                                              selectedValue.toString(),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        165.w,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: getCurrentTokenModel.tokens![currentIndex].isCompleted ==
                                                                              1
                                                                          ? kCardColor
                                                                          : kMainColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Image(
                                                                          image:
                                                                              const AssetImage("assets/icons/check_out.png"),
                                                                          color: getCurrentTokenModel.tokens![currentIndex].isCompleted == 1
                                                                              ? kMainColor
                                                                              : Colors.white,
                                                                        ),
                                                                        Text(
                                                                          "Check Out",
                                                                          style: size.width > 400
                                                                              ? TextStyle(
                                                                                  fontSize: 13.sp,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: getCurrentTokenModel.tokens![currentIndex].isCompleted == 1 ? kMainColor : kCardColor,
                                                                                )
                                                                              : TextStyle(
                                                                                  fontSize: 16.sp,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: getCurrentTokenModel.tokens![currentIndex].isCompleted == 1 ? kMainColor : kCardColor,
                                                                                ),
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
                  );
                }
              },
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

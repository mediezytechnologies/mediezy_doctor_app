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
import 'package:mediezy_doctor/Ui/CommonWidgets/get_medicines_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/select_clinic_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/TokenScreen/Widgets/token_show_card_widget.dart';
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
    // selectedValue = items['All'];
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetCurrentTokenBloc>(context).add(FetchGetCurrentToken(
      clinicId: dController.initialIndex!,
      scheduleType: dController.scheduleIndex.value,
    ));
    super.initState();
  }

  AddCheckinOrCheckoutBloc? _addCheckinOrCheckoutBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtain the bloc reference
    _addCheckinOrCheckoutBloc =
        BlocProvider.of<AddCheckinOrCheckoutBloc>(context);
  }

  int clickedIndex = 0;

  bool isFirstCheckIn = true;

  int? length;
  int? currentTokenLength = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<GetCurrentTokenBloc>(context).add(
          FetchGetCurrentToken(
            clinicId: dController.initialIndex!,
            scheduleType: dController.scheduleIndex.value,
          ),
        );
      },
      child: BlocListener<AddCheckinOrCheckoutBloc, AddCheckinOrCheckoutState>(
        listener: (context, state) {
          if (state is AddCheckinOrCheckoutError) {
            GeneralServices.instance.showToastMessage(state.errorMessage);
          }
          if (state is AddCheckinOrCheckoutLoaded) {
            BlocProvider.of<GetCurrentTokenBloc>(context).add(
              FetchGetCurrentToken(
                clinicId: dController.initialIndex!,
                scheduleType: dController.scheduleIndex.value,
              ),
            );
          }
        },
        child: WillPopScope(
          onWillPop: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BottomNavigationControlWidget(
                  selectedIndex: 0,
                ),
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
                                      scheduleType:
                                          dController.scheduleIndex.value,
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
                                  Obx(
                                    () {
                                      return CustomDropDown(
                                        width: size.width * 0.38,
                                        value: dController.scheduleIndex.value,
                                        items: dController.scheduleData
                                            .map((entry) {
                                          return DropdownMenuItem(
                                            value: entry.scheduleId.toString(),
                                            child: Text(entry.scheduleName),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          log(newValue!);
                                          dController.dropdownValueChanging(
                                              newValue, '0');
                                          BlocProvider.of<GetCurrentTokenBloc>(
                                                  context)
                                              .add(FetchGetCurrentToken(
                                            clinicId: dController.initialIndex!,
                                            scheduleType:
                                                dController.scheduleIndex.value,
                                          ));
                                          log("val : ${dController.scheduleIndex}");
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
                                return _buildLoadingWidget();
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
                                // return _buildLoadingWidget();

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
                                                              dController
                                                                  .scheduleIndex
                                                                  .value,
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
                                                              dController
                                                                  .scheduleIndex
                                                                  .value,
                                                        ),
                                                      );
                                                    }
                                                  },
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
                                                  const VerticalSpacingWidget(
                                                      height: 3),
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
                                                      ? Column(
                                                          children: [
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .reviewAfter ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Review after : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .reviewAfter
                                                                        .toString()),
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .labName ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Lab name : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .labName
                                                                        .toString()),
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .labtest ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Lab test : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .labtest
                                                                        .toString()),
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .scanName ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Scanning Centre : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .scanName
                                                                        .toString()),
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .scanTest ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Scan test : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .scanTest
                                                                        .toString()),
                                                            getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .medicalShopName ==
                                                                    null
                                                                ? Container()
                                                                : ShortNamesWidget(
                                                                    typeId: 1,
                                                                    firstText:
                                                                        "Medical store : ",
                                                                    secondText: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .patientData!
                                                                        .medicalShopName
                                                                        .toString()),
                                                            ListView.builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount: getCurrentTokenModel
                                                                    .tokens![
                                                                        currentIndex]
                                                                    .medicine!
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        indexx) {
                                                                  return GetMedicinesWidget(
                                                                    medicineName: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .medicineName
                                                                        .toString(),
                                                                    dosage: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .dosage
                                                                        .toString(),
                                                                    noOfDays: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .noOfDays
                                                                        .toString(),
                                                                    timeSection: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .timeSection
                                                                        .toString(),
                                                                    evening: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .evening,
                                                                    interval: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .interval,
                                                                    morning: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .morning,
                                                                    night: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .night,
                                                                    noon: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .noon,
                                                                    type: getCurrentTokenModel
                                                                        .tokens![
                                                                            currentIndex]
                                                                        .medicine![
                                                                            indexx]
                                                                        .type,
                                                                  );
                                                                }),
                                                          ],
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
                                                                  onTap:
                                                                      () async {
                                                                    if (getCurrentTokenModel
                                                                            .tokens![currentIndex]
                                                                            .isCheckIn !=
                                                                        1) {
                                                                      if (isFirstCheckIn &&
                                                                          currentIndex ==
                                                                              0) {
                                                                        GeneralServices
                                                                            .instance
                                                                            .appCloseDialogue(
                                                                          context,
                                                                          "Are you sure you want to start the consultation",
                                                                          () {
                                                                            Navigator.of(context).pop();
                                                                            setState(() {
                                                                              getCurrentTokenModel.tokens![currentIndex].isCheckIn = 1;
                                                                            });

                                                                            _addCheckinOrCheckoutBloc!.add(
                                                                              AddCheckinOrCheckout(
                                                                                clinicId: dController.initialIndex!,
                                                                                isCompleted: 0,
                                                                                isCheckin: 1,
                                                                                tokenNumber: getCurrentTokenModel.tokens![currentIndex].tokenNumber.toString(),
                                                                                isReached: '',
                                                                              ),
                                                                            );

                                                                            Future.delayed(const Duration(seconds: 8),
                                                                                () {
                                                                              if (mounted) {
                                                                                _addCheckinOrCheckoutBloc!.add(
                                                                                  EstimateUpdateCheckin(
                                                                                    tokenId: getCurrentTokenModel.tokens![currentIndex].newTokenId.toString(),
                                                                                  ),
                                                                                );
                                                                              }
                                                                            });
                                                                            isFirstCheckIn =
                                                                                false;
                                                                          },
                                                                        );
                                                                      } else {
                                                                        clickedIndex =
                                                                            index;
                                                                        _addCheckinOrCheckoutBloc!
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
                                                                        Future.delayed(
                                                                            const Duration(seconds: 8),
                                                                            () {
                                                                          if (mounted) {
                                                                            _addCheckinOrCheckoutBloc!.add(
                                                                              EstimateUpdateCheckin(
                                                                                tokenId: getCurrentTokenModel.tokens![currentIndex].newTokenId.toString(),
                                                                              ),
                                                                            );
                                                                          }
                                                                        });
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
                                                                      Future.delayed(
                                                                          const Duration(
                                                                              seconds: 8),
                                                                          () {
                                                                        if (mounted) {
                                                                          _addCheckinOrCheckoutBloc!
                                                                              .add(
                                                                            EstimateUpdateCheckout(
                                                                              tokenId: getCurrentTokenModel.tokens![currentIndex].newTokenId.toString(),
                                                                            ),
                                                                          );
                                                                        }
                                                                      });
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
                                                                          scheduleType: dController
                                                                              .scheduleIndex
                                                                              .value,
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
      height: 500.h,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
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
                              border: Border.all(width: .5, color: kMainColor),
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
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

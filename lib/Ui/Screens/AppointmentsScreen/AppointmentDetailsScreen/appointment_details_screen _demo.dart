// import 'dart:async';
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddAllAppointmentDetails/add_all_appointment_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/image_view_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/lab_search_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/medicine_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/patient_details_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/scan_search_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/vitals_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import '../../../../Repositary/getx/apointment_detail_getx.dart';
import '../../../../Repositary/getx/get_appointment_getx.dart';
import '../../../CommonWidgets/custom_dropdown_widget.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({
    Key? key,
    required this.tokenId,
    required this.position,
    required this.date,
    this.length,
    required this.firstIndex,
    this.itemCount,
    required this.patientName,
  }) : super(key: key);

  final String tokenId;
  final int position;
  final int? itemCount;
  final String date;
  final String patientName;
  final int? length;
  final int firstIndex;

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController afterDaysController = TextEditingController();
  final TextEditingController labTestController = TextEditingController();
  final TextEditingController scanTestController = TextEditingController();
  List<TextEditingController> textFormControllers = [];

  DateTime currentDate = DateTime.now();

  String formatDate() {
    String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedSelectedDate;
  }

//! lab test select items

  List<Map<String, String>> selectedLabs = [];

  void handleLabSelection(String selectedLab, String selectedLabId) {
    setState(() {
      selectedLabs.add({'name': selectedLab, 'id': selectedLabId});
    });
  }

  List<String?> getSelectedLabTestIds() {
    return selectedLabs.map((lab) => lab['id']).toList();
  }

//! scan test select items

  List<Map<String, String>> selectedScanTests = [];

  void handleScanTestSelection(
      String selectedScanTest, String selectedScanTestId) {
    setState(() {
      selectedScanTests
          .add({'name': selectedScanTest, 'id': selectedScanTestId});
    });
  }

  List<String?> getSelectedScanTestIds() {
    return selectedScanTests.map((scan) => scan['id']).toList();
  }

  final getAllAppointmentController = Get.put(GetAllAppointmentController());
  int currentPosition = 0;
  late PageController pageController;
  final ScrollController _scrollController = ScrollController();

  final ImagePicker imagePicker = ImagePicker();
  String? imagePath;

  bool isFirstCheckIn = true;
  bool isCheckoutTapped = false;
  bool isBackActionDisabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final HospitalController controller = Get.put(HospitalController());
  int? currentTokenLength = 1;
  int clickedIndex = 0;

  late int listLength;

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  late StreamSubscription<ConnectivityResult> subscription;

  DateTime? lastpressed;

  @override
  void initState() {
    bokingAppointmentLabController.getMedicalStoreController();
    bokingAppointmentLabController.getLablController();
    listLength = widget.length!;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
    setState(() {
      currentPosition = widget.position;
    });

    pageController = PageController(initialPage: currentPosition);
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetAllFavouriteMedicalStoreBloc>(context)
        .add(FetchAllFavouriteMedicalStore());
    BlocProvider.of<GetAllFavouriteLabBloc>(context)
        .add(FetchAllFavouriteLab());
    //currentPosition = widget.position;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

//cnages...................
  final FoodDropdownController foodDropdownController =
      Get.put(FoodDropdownController());
  final bokingAppointmentLabController =
      Get.put(BookingAppointmentLabController());

  // List<File> imageFiles = [];

  // Future<void> pickImage(ImageSource source) async {
  //   final pickedFile = await imagePicker.pickImage(
  //     source: source,
  //     imageQuality: 30,
  //   );

  //   if (pickedFile == null) return;

  //   setState(() {
  //     imageFiles.add(File(pickedFile.path));
  //     log("${pickedFile.path}======= image");
  //   });
  // }

  // List<String> getImagePaths() {
  //   return imageFiles.map((file) => file.path).toList();
  // }

  @override
  Widget build(BuildContext context) {
    log("current position then : $currentPosition");
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (!isCheckoutTapped) {
          return true;
        }

        if (isBackActionDisabled) {
          // If we're within the 3-second window after tapping checkout, prevent back action
          return false;
        }

        // Your existing double-tap to exit logic
        final now = DateTime.now();
        const maxDuration = Duration(seconds: 1);
        final isWarning =
            lastpressed == null || now.difference(lastpressed!) > maxDuration;
        if (isWarning) {
          lastpressed = DateTime.now();
          final snackBar = SnackBar(
            width: 200.w,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: const Text('Double Tap to back Screen'),
            duration: maxDuration,
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        appBar: AppBar(
          automaticallyImplyLeading:
              isCheckoutTapped && isBackActionDisabled ? false : true,
          title: const Text("Appointment Details"),
          centerTitle: true,
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
              return MultiBlocListener(
                listeners: [
                  BlocListener<AddPrescriptionBloc, AddPrescriptionState>(
                    listener: (context, state) {
                      if (state is AddPrescriptionLoaded) {
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                      }
                    },
                  ),
                  BlocListener<AddVitalsBloc, AddVitalsState>(
                    listener: (context, state) {
                      if (state is AddVitalsLoaded) {
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                      }
                      if (state is EditVitalsLoaded) {
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                      }
                      if (state is DeleteVitalsLoaded) {
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                      }
                    },
                  ),
                  BlocListener<AddCheckinOrCheckoutBloc,
                      AddCheckinOrCheckoutState>(
                    listener: (context, state) {
                      if (state is AddCheckinOrCheckoutError) {
                        GeneralServices.instance
                            .showToastMessage(state.errorMessage);
                      }
                      if (state is AddCheckinOrCheckoutLoaded) {
                        getAllAppointmentController
                            .getAllAppointmentGetxController(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex.value,
                          scheduleType: controller.scheduleIndex.value,
                        );
                      }
                    },
                  ),
                ],
                child: FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child:
                      GetBuilder<GetAllAppointmentController>(builder: (ctr) {
                    if (ctr.loding.value) {
                      Center(
                        child: CupertinoActivityIndicator(
                          color: kCardColor,
                          radius: 20.r,
                        ),
                      );
                    }
                    return PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listLength,
                      controller: pageController,
                      onPageChanged: (index) {
                        currentTokenLength = index + 1;
                        clickedIndex = index;
                        currentPosition = index;
                        currentPosition = index % widget.itemCount!;
                        log("current pos : $currentPosition");
                      },
                      itemBuilder: (context, index) {
                        log("current pos : $currentPosition");
                        currentPosition = index;
                        listLength = ctr.bookingData.length;

                        int bookingPending = listLength - 1 - currentPosition;

                        return SingleChildScrollView(
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: kCardColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      currentPosition == 0
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20.h),
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                size: size.width > 450
                                                    ? 16.sp
                                                    : 25.sp,
                                                color: kSubTextColor,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                log("pressed");
                                                if (currentPosition > 0) {
                                                  log("pressed no zero");
                                                  currentPosition--;
                                                  pageController.animateToPage(
                                                    currentPosition,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  getAllAppointmentController
                                                      .getAllAppointmentGetxController(
                                                    date:
                                                        controller.formatDate(),
                                                    clinicId: controller
                                                        .initialIndex.value,
                                                    scheduleType: controller
                                                        .scheduleIndex.value,
                                                  );
                                                  setState(() {
                                                    listLength =
                                                        ctr.bookingData.length;
                                                    bookingPending =
                                                        listLength -
                                                            1 -
                                                            currentPosition;
                                                  });
                                                  foodDropdownController
                                                      .resetToInitialValue();
                                                  bokingAppointmentLabController
                                                      .resetToPreviousValue();
                                                }
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                size: size.width > 450
                                                    ? 16.sp
                                                    : 25.sp,
                                                color: kMainColor,
                                              )),
                                      FadedScaleAnimation(
                                        scaleDuration:
                                            const Duration(milliseconds: 400),
                                        fadeDuration:
                                            const Duration(milliseconds: 400),
                                        child: PatientImageWidget(
                                            patientImage:
                                                ctr.bookingData[currentPosition]
                                                            .userImage ==
                                                        null
                                                    ? ""
                                                    : ctr
                                                        .bookingData[
                                                            currentPosition]
                                                        .userImage
                                                        .toString(),
                                            radius: 40.r),
                                      ),
                                      SizedBox(
                                        width: size.width > 450
                                            ? size.width * .64
                                            : size.width * .42,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ctr.bookingData[currentPosition]
                                                  .patientName
                                                  .toString(),
                                              style: size.width > 450
                                                  ? blackTabMainText
                                                  : blackMainText,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Token Number : ",
                                                  style: size.width > 450
                                                      ? greyTabMain
                                                      : grey10B400,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  ctr
                                                      .bookingData[
                                                          currentPosition]
                                                      .tokenNumber
                                                      .toString(),
                                                  style: size.width > 450
                                                      ? blackTabMainText
                                                      : blackMainText,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            ctr.bookingData[currentPosition]
                                                        .mediezyPatientId ==
                                                    null
                                                ? Container()
                                                : Row(
                                                    children: [
                                                      Text(
                                                        "Patient Id : ",
                                                        style: size.width > 450
                                                            ? greyTabMain
                                                            : grey10B400,
                                                      ),
                                                      Text(
                                                        ctr
                                                            .bookingData[
                                                                currentPosition]
                                                            .mediezyPatientId
                                                            .toString(),
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                            ctr.bookingData[currentPosition]
                                                        .age ==
                                                    null
                                                ? Container()
                                                : Row(
                                                    children: [
                                                      Text(
                                                        "Age : ",
                                                        style: size.width > 450
                                                            ? greyTabMain
                                                            : grey10B400,
                                                      ),
                                                      Text(
                                                        ctr
                                                            .bookingData[
                                                                currentPosition]
                                                            .patient!
                                                            .age
                                                            .toString(),
                                                        style: size.width > 450
                                                            ? blackTabMainText
                                                            : blackMainText,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                      currentPosition == listLength - 1
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20.h),
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: size.width > 450
                                                    ? 16.sp
                                                    : 25.sp,
                                                color: kSubTextColor,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                if (currentPosition <
                                                    listLength - 1) {
                                                  currentPosition++;
                                                  pageController.animateToPage(
                                                    currentPosition,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  getAllAppointmentController
                                                      .getAllAppointmentGetxController(
                                                    date:
                                                        controller.formatDate(),
                                                    clinicId: controller
                                                        .initialIndex.value,
                                                    scheduleType: controller
                                                        .scheduleIndex.value,
                                                  );
                                                  setState(() {
                                                    bookingPending =
                                                        listLength -
                                                            1 -
                                                            currentPosition;
                                                  });
                                                  foodDropdownController
                                                      .resetToInitialValue();
                                                  bokingAppointmentLabController
                                                      .resetToPreviousValue();
                                                }
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: kMainColor,
                                                size: size.width > 450
                                                    ? 16.sp
                                                    : 25.sp,
                                              )),
                                    ],
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                pendingContainer(size, bookingPending),
                                const VerticalSpacingWidget(height: 5),
                                PatientDetailsWidget(
                                  allergiesDetails:
                                      ctr.bookingData[index].allergiesDetails,
                                  mainSymptoms:
                                      ctr.bookingData[index].mainSymptoms,
                                  medicineDetails:
                                      ctr.bookingData[index].medicineDetails,
                                  otherSymptoms:
                                      ctr.bookingData[index].otherSymptoms,
                                  surgeryName:
                                      ctr.bookingData[index].surgeryName,
                                  treatmentTaken:
                                      ctr.bookingData[index].treatmentTaken,
                                  whenitcomes: ctr
                                      .bookingData[index].whenitcomes
                                      .toString(),
                                  whenitstart: ctr
                                      .bookingData[index].whenitstart
                                      .toString(),
                                  patientId: ctr.bookingData[index].patientId!,
                                  treatmentTakenDetails: ctr
                                      .bookingData[index].treatmentTakenDetails,
                                  surgeryDetails: ctr
                                      .bookingData[index].surgeryDetails
                                      .toString(),
                                  bookedPersonId: ctr
                                      .bookingData[index].bookedPersonId
                                      .toString(),
                                  offlineStatus: ctr
                                      .bookingData[index].onlineStatus
                                      .toString(),
                                ),
                                ctr.bookingData[index].date == formatDate()
                                    ? checkinButton(index, context, size)
                                    : Container(),
                                const VerticalSpacingWidget(height: 10),
                                VitalsWidget(
                                  tokenId:
                                      ctr.bookingData[index].tokenId.toString(),
                                  vitals: ctr.bookingData[index].vitals,
                                  bookingData: ctr.bookingData,
                                ),
                                // },
                                // child: Text("data")),
                                //MedicineWidget
                                const VerticalSpacingWidget(height: 5),
                                Obx(() {
                                  return bokingAppointmentLabController
                                          .favoritemedicalshop.isEmpty
                                      ? const Text(
                                          "No Favourite Medical Stores.\n Please add Medical Stores")
                                      : CustomDropDown(
                                          width: double.infinity,
                                          value: bokingAppointmentLabController
                                              .initialMedicalStoreIndex.value,
                                          items: bokingAppointmentLabController
                                              .tempScanList
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: Text(e.laboratory!),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            log(newValue!);
                                            bokingAppointmentLabController
                                                .dropdownValueMedicalChanging(
                                                    newValue,
                                                    bokingAppointmentLabController
                                                        .initialMedicalStoreIndex
                                                        .value);
                                          },
                                        );
                                }),
                                const VerticalSpacingWidget(height: 5),
                                Obx(() {
                                  if (getAllAppointmentController
                                      .loding.value) {
                                    return const CircularProgressIndicator();
                                  }
                                  return MedicineWidget(
                                    tokenId: getAllAppointmentController
                                        .bookingData[index].tokenId
                                        .toString(),
                                    medicine: getAllAppointmentController
                                        .bookingData[index].medicine,
                                    medicalStoreId:
                                        bokingAppointmentLabController
                                            .initialMedicalStoreIndex
                                            .toString(),

                                    //dropValueMedicalStore,
                                    bookedPersonId: getAllAppointmentController
                                        .bookingData[index].bookedPersonId
                                        .toString(),
                                    bookingData:
                                        getAllAppointmentController.bookingData,
                                  );
                                }),
                                //! upload attachments
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Upload attachments',
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await placePicImage();
                                            setState(() {});
                                            // showPickerOptions();
                                            // log(imageFiles.toString());
                                          },
                                          icon: Icon(
                                            Icons.upload_file_outlined,
                                            color: kMainColor,
                                            size: size.width > 450
                                                ? 15.sp
                                                : 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                if (imagePath != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kCardColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 5.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ImageViewWidgetDemo(
                                                  image: imagePath!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "View your uploaded image",
                                                style: size.width > 450
                                                    ? TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.blue,
                                                      )
                                                    : TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.blue,
                                                      ),
                                              ),
                                              const HorizontalSpacingWidget(
                                                  width: 10),
                                              Icon(
                                                Icons.image,
                                                color: Colors.blue,
                                                size: size.width > 450
                                                    ? 20.sp
                                                    : 28.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              imagePath = null;
                                            });
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear_circled,
                                            color: Colors.black,
                                            size: size.width > 450
                                                ? 20.sp
                                                : 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                // if (imageFiles.isNotEmpty)
                                //   ListView.builder(
                                //     shrinkWrap: true,
                                //     physics:
                                //         const NeverScrollableScrollPhysics(),
                                //     itemCount: imageFiles.length,
                                //     itemBuilder: (context, index) {
                                //       final file = imageFiles[index];
                                //       return Container(
                                //         decoration: BoxDecoration(
                                //           color: kCardColor,
                                //           borderRadius:
                                //               BorderRadius.circular(10),
                                //         ),
                                //         margin:
                                //             EdgeInsets.symmetric(vertical: 5.h),
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             InkWell(
                                //               onTap: () {
                                //                 Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                     builder: (ctx) =>
                                //                         ImageViewWidgetDemo(
                                //                       image: file.path,
                                //                     ),
                                //                   ),
                                //                 );
                                //               },
                                //               child: Row(
                                //                 children: [
                                //                   Text(
                                //                     "View your uploaded image",
                                //                     style: size.width > 450
                                //                         ? TextStyle(
                                //                             fontSize: 11.sp,
                                //                             fontWeight:
                                //                                 FontWeight.w600,
                                //                             color: Colors.blue,
                                //                           )
                                //                         : TextStyle(
                                //                             fontSize: 14.sp,
                                //                             fontWeight:
                                //                                 FontWeight.w600,
                                //                             color: Colors.blue,
                                //                           ),
                                //                   ),
                                //                   const HorizontalSpacingWidget(
                                //                       width: 10),
                                //                   Icon(
                                //                     Icons.image,
                                //                     color: Colors.blue,
                                //                     size: size.width > 450
                                //                         ? 20.sp
                                //                         : 28.sp,
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //             IconButton(
                                //               onPressed: () {
                                //                 setState(() {
                                //                   imageFiles.removeAt(index);
                                //                 });
                                //               },
                                //               icon: Icon(
                                //                 CupertinoIcons.clear_circled,
                                //                 color: Colors.black,
                                //                 size: size.width > 450
                                //                     ? 20.sp
                                //                     : 20.sp,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       );
                                //     },
                                //   ),

                                const VerticalSpacingWidget(height: 5),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LabSearchWidget(
                                          onLabSelected: handleLabSelection,
                                          typeId: 0,
                                          labTypeId: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            size.width > 450 ? 9.sp : 14.sp),
                                    cursorColor: Colors.blue,
                                    controller: labTestController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width > 450 ? 10 : 13,
                                          fontWeight: FontWeight.w600),
                                      hintText: "Tap to select lab tests",
                                      filled: true,
                                      enabled: false,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8.0,
                                  children: selectedLabs.map((lab) {
                                    return Chip(
                                      backgroundColor: kCardColor,
                                      label: Text(lab['name']!),
                                      onDeleted: () {
                                        setState(() {
                                          selectedLabs.remove(lab);
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),

                                const VerticalSpacingWidget(height: 5),
                                Text(
                                  "Select Lab",
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),

                                Obx(() {
                                  return bokingAppointmentLabController
                                          .favoriteLabs.isEmpty
                                      ? const Text(
                                          "No Favourite Labs.\n Please add Labs")
                                      : CustomDropDown(
                                          width: double.infinity,
                                          value: bokingAppointmentLabController
                                              .initialSelectLabIndex.value,
                                          items: bokingAppointmentLabController
                                              .tempLabList
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: Text(e.laboratory!),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            log(newValue!);
                                            bokingAppointmentLabController
                                                .dropdownValueChanging(
                                                    newValue,
                                                    bokingAppointmentLabController
                                                        .initialSelectLabIndex
                                                        .value);
                                          },
                                        );
                                }),
                                const VerticalSpacingWidget(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScanSearchWidget(
                                          onLabSelected:
                                              handleScanTestSelection,
                                          typeId: 0,
                                          labTypeId: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            size.width > 450 ? 9.sp : 14.sp),
                                    cursorColor: Colors.blue,
                                    controller: labTestController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width > 450 ? 10 : 13,
                                          fontWeight: FontWeight.w600),
                                      hintText: "Tap to select scan tests",
                                      filled: true,
                                      enabled: false,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                Wrap(
                                  spacing: 8.0,
                                  children: selectedScanTests.map((scan) {
                                    return Chip(
                                      backgroundColor: kCardColor,
                                      label: Text(scan['name']!),
                                      onDeleted: () {
                                        setState(() {
                                          selectedScanTests.remove(scan);
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  "Select scanning centre",
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),

                                Obx(() {
                                  return bokingAppointmentLabController
                                          .favoriteLabs.isEmpty
                                      ? const Text(
                                          "No Favourite scanning centre.\n Please add scanning centre")
                                      : CustomDropDown(
                                          width: double.infinity,
                                          value: bokingAppointmentLabController
                                              .initialScaningCenerIndex.value,
                                          items: bokingAppointmentLabController
                                              .tempScanCenterList
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: Text(e.laboratory!),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            log(newValue!);
                                            bokingAppointmentLabController
                                                .dropdownValuelabScanChanging(
                                                    newValue,
                                                    bokingAppointmentLabController
                                                        .initialScaningCenerIndex
                                                        .value);
                                          },
                                        );
                                }),
                                const VerticalSpacingWidget(height: 10),
                                //! add note
                                Text(
                                  "Review After",
                                  style: size.width > 450
                                      ? blackTabMainText
                                      : blackMainText,
                                ),
                                //! dosage
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 45.h,
                                      width: 120.w,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontSize: size.width > 450
                                                ? 9.sp
                                                : 14.sp),
                                        cursorColor: kMainColor,
                                        controller: afterDaysController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintStyle: size.width > 450
                                              ? greyTab10B600
                                              : grey13B600,
                                          hintText: "Days",
                                          filled: true,
                                          fillColor: kCardColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalSpacingWidget(height: 10),
                                Text(
                                  'Add Note',
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                                const VerticalSpacingWidget(height: 5),
                                TextFormField(
                                  style: TextStyle(
                                      fontSize:
                                          size.width > 450 ? 9.sp : 14.sp),
                                  cursorColor: kMainColor,
                                  controller: noteController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintStyle: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                    hintText: "Add your notes",
                                    filled: true,
                                    fillColor: kCardColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const VerticalSpacingWidget(height: 10),
                                ctr.bookingData[index].date == formatDate()
                                    ? InkWell(
                                        onTap: () async {
                                          if (bokingAppointmentLabController
                                                      .initialSelectLabIndex
                                                      .value !=
                                                  '0' &&
                                              selectedLabs.isEmpty) {
                                            GeneralServices.instance
                                                .showErrorMessage(context,
                                                    "Please select lab tests ");
                                          } else if (bokingAppointmentLabController
                                                      .initialScaningCenerIndex
                                                      .value !=
                                                  '0' &&
                                              selectedScanTests.isEmpty) {
                                            GeneralServices.instance
                                                .showErrorMessage(context,
                                                    "Please Select scanning centre ");
                                          } 
                                          
                                          
                                          else {
                                            if (getAllAppointmentController
                                                    .bookingData[index]
                                                    .isCheckedin ==
                                                1) {
                                              if (bokingAppointmentLabController
                                                      .initialScaningCenerIndex
                                                      .value ==
                                                  '0') {}

                                              FocusScope.of(context).unfocus();
                                              //check condition//.......
                                              setState(() {
                                                isCheckoutTapped = true;
                                                isBackActionDisabled = true;
                                              });

                                              if (currentPosition ==
                                                      listLength - 1 ||
                                                  currentPosition <
                                                      listLength - 1 ||
                                                  (currentPosition ==
                                                          listLength - 1 &&
                                                      currentPosition == 0)) {
                                                // isConditionMet = true;
                                                // isWaitingForCheckout =
                                                //     true;
                                              }

                                              BlocProvider.of<
                                                          AddAllAppointmentDetailsBloc>(
                                                      context)
                                                  .add(
                                                AddAllAppointmentDetails(
                                                  labTestId:
                                                      getSelectedLabTestIds(),
                                                  scanTestId:
                                                      getSelectedScanTestIds(),
                                                  tokenId: ctr
                                                      .bookingData[index]
                                                      .tokenId
                                                      .toString(),
                                                  labId:
                                                      bokingAppointmentLabController
                                                          .initialSelectLabIndex
                                                          .value
                                                          .toString(),
                                                  medicalshopId:
                                                      bokingAppointmentLabController
                                                          .initialMedicalStoreIndex
                                                          .toString(),
                                                  attachment: imagePath,
                                                  reviewAfter:
                                                      afterDaysController.text,
                                                  notes: noteController.text,
                                                  scanId:
                                                      bokingAppointmentLabController
                                                          .initialScaningCenerIndex
                                                          .toString(),
                                                ),
                                              );

                                              // Wait for 3 seconds
                                              await Future.delayed(
                                                      const Duration(
                                                          seconds: 3))
                                                  .then((value) {
                                                setState(() {
                                                  isBackActionDisabled = false;
                                                });
                                                if (ctr.bookingData[index]
                                                        .isCheckedout !=
                                                    1) {
                                                  if (currentPosition ==
                                                          listLength - 1 &&
                                                      currentPosition == 0) {
                                                    log("1111111111111111111111111111111111111");
                                                    handleCheckout(
                                                      context,
                                                      index,
                                                    );
                                                    estimateUpdateCheckout(
                                                      context,
                                                      index,
                                                    );
                                                    navigateToHome(context);
                                                    log("last section currentPosition: $currentPosition");
                                                  } else if (currentPosition ==
                                                      listLength - 1) {
                                                    currentPosition--;
                                                    log("Last section: $currentPosition");

                                                    pageController
                                                        .animateToPage(
                                                      currentPosition,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                    );
                                                    log("2222222222222222222222222222222222222222222");

                                                    handleCheckout(
                                                      context,
                                                      index,
                                                    );
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 8), () {
                                                      estimateUpdateCheckout(
                                                        context,
                                                        index,
                                                      );
                                                      navigateToHome(context);
                                                    });
                                                    refreshData(context);
                                                  } else if (currentPosition <
                                                      listLength - 1) {
                                                    log("33333333333333333333333333333333");
                                                    currentPosition + 1;
                                                    pageController
                                                        .animateToPage(
                                                      currentPosition,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                    );
                                                    handleCheckout(
                                                      context,
                                                      currentPosition,
                                                    );
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 8), () {
                                                      estimateUpdateCheckout(
                                                        context,
                                                        index,
                                                      );
                                                    });
                                                    refreshData(context);
                                                    _scrollController.animateTo(
                                                      0.0,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                    );
                                                  }
                                                  setState(() {
                                                    bookingPending =
                                                        listLength -
                                                            1 -
                                                            currentPosition;
                                                  });
                                                }

                                                // Reset isWaitingForCheckout to false after 3 seconds
                                                isCheckoutTapped = false;
                                              });
                                            } else {
                                              GeneralServices.instance
                                                  .showErrorMessage(context,
                                                      "please confirm the Check in");
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ctr.bookingData[index]
                                                        .isCheckedout ==
                                                    1
                                                ? kCardColor
                                                : kMainColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: const AssetImage(
                                                    "assets/icons/check_out.png"),
                                                color: ctr.bookingData[index]
                                                            .isCheckedout ==
                                                        1
                                                    ? kMainColor
                                                    : Colors.white,
                                              ),
                                              Text(
                                                "Check Out",
                                                style: TextStyle(
                                                  fontSize: size.width > 450
                                                      ? 12.sp
                                                      : 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: ctr.bookingData[index]
                                                              .isCheckedout ==
                                                          1
                                                      ? kMainColor
                                                      : Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                VerticalSpacingWidget(
                                    height: Platform.isIOS ? 30 : 10),
                                //  SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // }
                    // return Container();
                  }),
                ),
              );
            }
          },
        ),
        //),
      ),
    );
  }

//!pending==
  Container pendingContainer(Size size, int bookingPending) {
    return Container(
      height: 30.h,
      width: size.width > 450 ? 80.w : 110.w,
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                "Pending",
                style: size.width > 450
                    ? TextStyle(
                        fontSize: 10.sp,
                        color: kCardColor,
                        fontWeight: FontWeight.bold,
                      )
                    : TextStyle(
                        fontSize: 15.sp,
                        color: kCardColor,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
            Container(
              height: 25.h,
              width: size.width > 450 ? 22.w : 28.w,
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  // "123",
                  "$bookingPending",
                  style: size.width > 450 ? blackTab12B600 : black15B600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell checkinButton(int index, BuildContext context, Size size) {
    return InkWell(
      onTap: () async {
        if (getAllAppointmentController.bookingData[index].isCheckedin != 1) {
          if (getAllAppointmentController
                  .bookingData[currentPosition].firstIndexStatus ==
              1) {
            GeneralServices.instance.appCloseDialogue(
                context, "Are you sure you want to start the consultation", () {
              Navigator.of(context).pop();
              setState(() {
                getAllAppointmentController.bookingData[index].isCheckedin = 1;
              });
              Future.delayed(const Duration(seconds: 2), () {
                log("First call ============================..........===============...===========");
                BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                  AddCheckinOrCheckout(
                    clinicId: getAllAppointmentController
                        .bookingData[index].clinicId
                        .toString(),
                    isCompleted: 0,
                    isCheckin: 1,
                    tokenNumber: getAllAppointmentController
                        .bookingData[index].tokenNumber
                        .toString(),
                    isReached: '',
                  ),
                );
              }).then((_) {
                return Future.delayed(const Duration(seconds: 8), () {
                  log("Second call ============================..........===============...===========");
                  BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                    EstimateUpdateCheckin(
                      tokenId: getAllAppointmentController
                          .bookingData[index].tokenId
                          .toString(),
                    ),
                  );
                });
              });

              //second bloc

              // isFirstCheckIn =
              //     false; // Update is
            });
          } else {
            // clickedIndex = index;
            setState(() {
              getAllAppointmentController.bookingData[index].isCheckedin = 1;
            });
            //first calling bloc

            Future.delayed(const Duration(seconds: 2), () {
              log("First call else ============================..........===============...===========");
              BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                AddCheckinOrCheckout(
                  clinicId: getAllAppointmentController
                      .bookingData[index].clinicId
                      .toString(),
                  isCompleted: 0,
                  isCheckin: 1,
                  tokenNumber: getAllAppointmentController
                      .bookingData[index].tokenNumber
                      .toString(),
                  isReached: '',
                ),
              );
            }).then((_) {
              return Future.delayed(const Duration(seconds: 8), () {
                log("Second call else ============================..........===============...===========");
                BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                  EstimateUpdateCheckin(
                    tokenId: getAllAppointmentController
                        .bookingData[index].tokenId
                        .toString(),
                  ),
                );
              });
            });
          }
        }
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: getAllAppointmentController.bookingData[index].isCheckedin == 1
              ? kCardColor
              : kMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage("assets/icons/check_in.png"),
              color:
                  getAllAppointmentController.bookingData[index].isCheckedin ==
                          1
                      ? kMainColor
                      : kCardColor,
            ),
            Text(
              "Check In",
              style: size.width > 450
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: getAllAppointmentController
                                  .bookingData[index].isCheckedin ==
                              1
                          ? kMainColor
                          : kCardColor,
                    )
                  : TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: getAllAppointmentController
                                  .bookingData[index].isCheckedin ==
                              1
                          ? kMainColor
                          : kCardColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void estimateUpdateCheckout(
    BuildContext context,
    int index,
  ) {
    BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
        EstimateUpdateCheckout(
            tokenId: getAllAppointmentController.bookingData[index].tokenId
                .toString()));
  }

  void handleCheckout(
    BuildContext context,
    int index,
  ) {
    BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
      AddCheckinOrCheckout(
        clinicId:
            getAllAppointmentController.bookingData[index].clinicId.toString(),
        isCompleted: 1,
        isCheckin: 0,
        tokenNumber: getAllAppointmentController.bookingData[index].tokenNumber
            .toString(),
        isReached: '',
      ),
    );

    getAllAppointmentController.bookingData[index].isCheckedout = 1;
    scanTestController.clear();
    afterDaysController.clear();
    noteController.clear();
    bokingAppointmentLabController.resetToPreviousValue();
    imagePath = null;
    // imageFiles.clear();
    selectedScanTests.clear();
    selectedLabs.clear();
  }

  // Future<void> handleCheckoutLastSection(
  //     BuildContext context, int index) async {
  //   log("section one 1============");
  //   BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
  //     AddCheckinOrCheckout(
  //       clinicId:
  //           getAllAppointmentController.bookingData[index].clinicId.toString(),
  //       isCompleted: 1,
  //       isCheckin: 0,
  //       tokenNumber: getAllAppointmentController.bookingData[index].tokenNumber
  //           .toString(),
  //       isReached: '',
  //     ),
  //   );
  //   getAllAppointmentController.bookingData[index].isCheckedout = 1;
  //   scanTestController.clear();
  //   afterDaysController.clear();
  //   noteController.clear();
  //   labTestController.clear();
  //   bokingAppointmentLabController.resetToPreviousValue();
  //   imageFiles.clear();
  //   getSelectedScanTestIds().clear();
  //   getSelectedLabTestIds().clear();
  //   imagePath = null;
  // }

  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => BottomNavigationControlWidget(
                selectedIndex: 0,
              )),
      (route) => false,
    );
  }

  void refreshData(BuildContext context) {
    getAllAppointmentController.getAllAppointmentGetxController(
      date: controller.formatDate(),
      clinicId: controller.initialIndex.value,
      scheduleType: controller.scheduleIndex.value,
    );
    // BlocProvider.of<GetAppointmentsBloc>(context).add(
    //   FetchAllAppointments(
    //     date: widget.date,
    //     clinicId: controller.initialIndex.value,
    //     scheduleType: controller.scheduleIndex.value,
    //   ),
    // );
  }

  Future<File> compressImage(String imagePath) async {
    File imageFile = File(imagePath);

    int fileSize = await imageFile.length();

    int maxFileSize = 2048 * 1024;

    if (fileSize <= maxFileSize) {
      return imageFile;
    }

    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 85,
    );

    if (compressedBytes != null) {
      File compressedImage =
          File(imagePath.replaceAll('.jpg', '_compressed.jpg'));

      await compressedImage.writeAsBytes(compressedBytes);

      return compressedImage;
    } else {
      throw Exception('Image compression failed');
    }
  }

  Future placePicImage() async {
    var image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (image == null) return;
    final imageTemporary = image.path;
    setState(() {
      imagePath = imageTemporary;
      log("$imageTemporary======= image");
    });
  }

  //   void showPickerOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Photo Library'),
  //               onTap: () {
  //                 pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

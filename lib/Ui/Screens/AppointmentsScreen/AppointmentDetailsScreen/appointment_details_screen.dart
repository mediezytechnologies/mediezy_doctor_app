// import 'dart:async';
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddAllAppointmentDetails/add_all_appointment_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_appointments/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
import 'package:mediezy_doctor/Repositary/getx/apointment_detail_getx.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/image_view_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/medicine_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/patient_details_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/vitals_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../CommonWidgets/custom_back_button.dart';

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
  // List<Widget> textFormFields = [];

  ////lab

  late ValueNotifier<String> dropValueLabNotifier;
  String dropValueLab = "";
  late List<FavoriteLabs> labId;
  List<FavoriteLabs> labValues = [FavoriteLabs(laboratory: "Select lab")];

  // scanning

  DateTime currentDate = DateTime.now();

  String formatDate() {
    String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedSelectedDate;
  }

  late ValueNotifier<String> dropValueScanningNotifier;
  String dropValueScanning = "";
  late List<FavoriteLabs> scanningId;
  List<FavoriteLabs> scanningValues = [
    FavoriteLabs(laboratory: "Select scanning centre")
  ];

  // medical store
  late ValueNotifier<String> dropValueMedicalStoreNotifier;
  String dropValueMedicalStore = "";
  late List<Favoritemedicalshop> medicalStoreId;
  List<Favoritemedicalshop> medicalStoreValues = [
    Favoritemedicalshop(laboratory: "Select medical store")
  ];

  // late AppointmentDetailsPageModel appointmentDetailsPageModel;
  late GetAppointmentsModel getAppointmentsModel;
  late GetAllFavouriteLabModel getAllFavouriteLabModel;
  late GetAllFavouriteMedicalStoresModel getAllFavouriteMedicalStoresModel;
  late ClinicGetModel clinicGetModel;
  // late GetAllAppointmentsModel getAllAppointmentsModel;
  //File? imageFromCamera;
  String? imageFromCamera;
  int currentPosition = 0;
  int currentPage = 0;
  late PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int? count = 0;

  int? length;
  String? selectedValue;

  bool isFirstCheckIn = true;

  final ImagePicker imagePicker = ImagePicker();
  String? imagePath;

  AddCheckinOrCheckoutBloc? _addCheckinOrCheckoutBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtain the bloc reference
  }

  final HospitalController controller = Get.put(HospitalController());

  void handleDropValueChanged(String newValue) {
    // Handle the value here in your first screen

    setState(() {
      selectedValue = newValue;
    });
  }

  int? currentTokenLength = 1;
  int clickedIndex = 0;

  //new

  int? scrollIndex;
  late int listLength;

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
    } else {}
  }

  late StreamSubscription<ConnectivityResult> subscription;

  // final ScrollController _scrollController = ScrollController();

  // int initialLength =widget

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
    //medical store
    BlocProvider.of<GetAllFavouriteMedicalStoreBloc>(context)
        .add(FetchAllFavouriteMedicalStore());
    //slect lab
    BlocProvider.of<GetAllFavouriteLabBloc>(context)
        .add(FetchAllFavouriteLab());
    //currentPosition = widget.position;
    dropValueMedicalStoreNotifier =
        ValueNotifier(medicalStoreValues.first.laboratory!);
    dropValueLabNotifier = ValueNotifier(labValues.first.laboratory!);
    dropValueScanningNotifier = ValueNotifier(scanningValues.first.laboratory!);
    super.initState();
  }

  DateTime? lastpressed;

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

  @override
  Widget build(BuildContext context) {
    log("current position then : $currentPosition");
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return DoubleTapBackPress(
      onTap: () {
         foodDropdownController.resetToInitialValue();
                bokingAppointmentLabController.resetToPreviousValue();
                //Navigator.pop(context);
                BlocProvider.of<GetAppointmentsBloc>(context)
                    .add(FetchAllAppointments(
                  date: widget.date,
                  clinicId: controller.initialIndex!,
                  scheduleType: controller.scheduleIndex.value,
                ));
        log("kljsdfkljaskdlfjadklsf=======================");
      },
        lastpressed: lastpressed,
      // onWillPop: () async {
      //   final now = DateTime.now();
      //   const maxDuration = const Duration(seconds: 1);
      //   final isWarning =
      //       lastpressed == null || now.difference(lastpressed!) > maxDuration;
      //   if (isWarning) {
      //     lastpressed = DateTime.now();

      //     return Future.value(false);
      //   } else {
      //     Navigator.pop(context);
      //     BlocProvider.of<GetAppointmentsBloc>(context)
      //         .add(FetchAllAppointments(
      //       date: widget.date,
      //       clinicId: controller.initialIndex!,
      //       scheduleType: controller.scheduleIndex.value,
      //     ));

      //     return Future.value(true);
      //   }

      //   // Navigator.pop(context);
      //   // BlocProvider.of<GetAppointmentsBloc>(context).add(FetchAllAppointments(
      //   //   date: widget.date,
      //   //   clinicId: controller.initialIndex!,
      //   //   scheduleType: controller.scheduleIndex.value,
      //   // ));
      //   // return Future.value(false);
      // },
        widget: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     bokingAppointmentLabController.resetToPreviousValue();
        //   },
        // ),
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                foodDropdownController.resetToInitialValue();
                bokingAppointmentLabController.resetToPreviousValue();
                //Navigator.pop(context);
                BlocProvider.of<GetAppointmentsBloc>(context)
                    .add(FetchAllAppointments(
                  date: widget.date,
                  clinicId: controller.initialIndex!,
                  scheduleType: controller.scheduleIndex.value,
                ));
              },
              icon: const Icon(Icons.arrow_back)),
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
                        BlocProvider.of<GetAppointmentsBloc>(context)
                            .add(FetchAllAppointments(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value,
                        ));
                      }
                    },
                  ),
                  BlocListener<AddVitalsBloc, AddVitalsState>(
                    listener: (context, state) {
                      if (state is AddVitalsLoaded) {
                        BlocProvider.of<GetAppointmentsBloc>(context)
                            .add(FetchAllAppointments(
                          date: widget.date,
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value,
                        ));
                      }
                      if (state is EditVitalsLoaded) {
                        BlocProvider.of<GetAppointmentsBloc>(context)
                            .add(FetchAllAppointments(
                          date: widget.date,
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value,
                        ));
                      }
                      if (state is DeleteVitalsLoaded) {
                        BlocProvider.of<GetAppointmentsBloc>(context)
                            .add(FetchAllAppointments(
                          date: widget.date,
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value,
                        ));
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
                        BlocProvider.of<GetAppointmentsBloc>(context)
                            .add(FetchAllAppointments(
                          date: widget.date,
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value,
                        ));
                      }
                    },
                  ),
                ],
                child: FadedSlideAnimation(
                  beginOffset: const Offset(0, 0.3),
                  endOffset: const Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: BlocBuilder<GetAppointmentsBloc, GetAppointmentsState>(
                      builder: (context, state) {
                    if (state is GetAppointmentsError) {
                      return const Center(
                        child: Text("Something Went Wrong"),
                      );
                    }
                    if (state is GetAppointmentsLoaded) {
                      getAppointmentsModel =
                          BlocProvider.of<GetAppointmentsBloc>(context)
                              .getAppointmentsModel;
                      return PageView.builder(
                        physics: const ClampingScrollPhysics(),
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
                          listLength = getAppointmentsModel.bookingData!.length;

                          int bookingPending = listLength - 1 - currentPosition;

                          return SingleChildScrollView(
                            controller: _scrollController,
                            physics: const ClampingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
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
                                              BlocProvider.of<
                                                          GetAppointmentsBloc>(
                                                      context)
                                                  .add(FetchAllAppointments(
                                                date: widget.date,
                                                clinicId:
                                                    controller.initialIndex!,
                                                scheduleType: controller
                                                    .scheduleIndex.value,
                                              ));
                                              setState(() {
                                                listLength =
                                                    getAppointmentsModel
                                                        .bookingData!.length;
                                                bookingPending = listLength -
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
                                            patientImage: getAppointmentsModel
                                                        .bookingData![
                                                            currentPosition]
                                                        .userImage ==
                                                    null
                                                ? ""
                                                : getAppointmentsModel
                                                    .bookingData![
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
                                              getAppointmentsModel
                                                  .bookingData![currentPosition]
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
                                                  getAppointmentsModel
                                                      .bookingData![
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
                                            getAppointmentsModel
                                                        .bookingData![
                                                            currentPosition]
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
                                                        getAppointmentsModel
                                                            .bookingData![
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
                                            getAppointmentsModel
                                                        .bookingData![
                                                            currentPosition]
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
                                                        getAppointmentsModel
                                                            .bookingData![
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
                                      IconButton(
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
                                              BlocProvider.of<
                                                          GetAppointmentsBloc>(
                                                      context)
                                                  .add(FetchAllAppointments(
                                                date: widget.date,
                                                clinicId:
                                                    controller.initialIndex!,
                                                scheduleType: controller
                                                    .scheduleIndex.value,
                                              ));
                                              setState(() {
                                                // balanceAppoiment=widget.length!-1;
                                                bookingPending = listLength -
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
                                  pendingContainer(size, bookingPending),
                                  PatientDetailsWidget(
                                    allergiesDetails: getAppointmentsModel
                                        .bookingData![index].allergiesDetails,
                                    mainSymptoms: getAppointmentsModel
                                        .bookingData![index].mainSymptoms,
                                    medicineDetails: getAppointmentsModel
                                        .bookingData![index].medicineDetails,
                                    otherSymptoms: getAppointmentsModel
                                        .bookingData![index].otherSymptoms,
                                    surgeryName: getAppointmentsModel
                                        .bookingData![index].surgeryName,
                                    treatmentTaken: getAppointmentsModel
                                        .bookingData![index].treatmentTaken,
                                    whenitcomes: getAppointmentsModel
                                        .bookingData![index].whenitcomes
                                        .toString(),
                                    whenitstart: getAppointmentsModel
                                        .bookingData![index].whenitstart
                                        .toString(),
                                    patientId: getAppointmentsModel
                                        .bookingData![index].patientId!,
                                    treatmentTakenDetails: getAppointmentsModel
                                        .bookingData![index]
                                        .treatmentTakenDetails
                                        .toString(),
                                    surgeryDetails: getAppointmentsModel
                                        .bookingData![index].surgeryDetails
                                        .toString(),
                                    bookedPersonId: getAppointmentsModel
                                        .bookingData![index].bookedPersonId
                                        .toString(),
                                  ),
                                  getAppointmentsModel
                                              .bookingData![index].date ==
                                          formatDate()
                                      ? checkinButton(index, context, size)
                                      : Container(),
                                  const VerticalSpacingWidget(height: 10),
                                  VitalsWidget(
                                    tokenId: getAppointmentsModel
                                        .bookingData![index].tokenId
                                        .toString(),
                                    vitals: getAppointmentsModel
                                        .bookingData![index].vitals,
                                    bookingData:
                                        getAppointmentsModel.bookingData!,
                                  ),
                                  // },
                                  // child: Text("data")),
                                  //MedicineWidget
                                  MedicineWidget(
                                    tokenId: getAppointmentsModel
                                        .bookingData![index].tokenId
                                        .toString(),
                                    medicine: getAppointmentsModel
                                        .bookingData![index].medicine,
                                    medicalStoreId:
                                        bokingAppointmentLabController
                                            .initialMedicalStoreIndex
                                            .toString(),

                                    //dropValueMedicalStore,
                                    bookedPersonId: getAppointmentsModel
                                        .bookingData![index].bookedPersonId
                                        .toString(),
                                    bookingData:
                                        getAppointmentsModel.bookingData,
                                  ),
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
                                          Text('Upload attachments',
                                              style: size.width > 450
                                                  ? blackTabMainText
                                                  : blackMainText),
                                          IconButton(
                                            onPressed: () async {
                                              await placePicImage();
                                              setState(
                                                  () {}); // Refresh the screen after picking the image
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
                                    // ? Container()
                                    // :

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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue)
                                                : TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue),
                                          ),
                                          const HorizontalSpacingWidget(
                                              width: 10),
                                          Icon(
                                            Icons.image,
                                            color: Colors.blue,
                                            size: size.width > 450
                                                ? 20.sp
                                                : 28.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                  const VerticalSpacingWidget(height: 5),
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

                                  // Container(
                                  //   height: 40.h,
                                  //   width: 340.w,
                                  //   decoration: BoxDecoration(
                                  //       color: kCardColor,
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       border: Border.all(
                                  //           color: const Color(0xFF9C9C9C))),
                                  //   child: Padding(
                                  //     padding:
                                  //         EdgeInsets.symmetric(horizontal: 8.w),
                                  //     child: Center(
                                  //       child: ValueListenableBuilder(
                                  //         valueListenable:
                                  //             dropValueMedicalStoreNotifier,
                                  //         builder: (BuildContext context,
                                  //             String dropValue1, _) {
                                  //           return DropdownButtonFormField(
                                  //             iconEnabledColor: kMainColor,
                                  //             decoration: const InputDecoration
                                  //                 .collapsed(hintText: ''),
                                  //             value: dropValue1,
                                  //             style: size.width > 450
                                  //                 ? blackTabMainText
                                  //                 : blackMainText,
                                  //             icon: const Icon(
                                  //                 Icons.keyboard_arrow_down),
                                  //             onChanged: (String? value) {
                                  //               dropValue1 = value!;
                                  //               dropValueMedicalStoreNotifier
                                  //                   .value = value;
                                  //               medicalStoreId =
                                  //                   medicalStoreValues
                                  //                       .where((element) =>
                                  //                           element.laboratory!
                                  //                               .contains(
                                  //                                   value))
                                  //                       .toList();
                                  //               // widget.onDropValueChanged(dropValueMedicalStore);
                                  //               log(dropValueMedicalStoreNotifier
                                  //                   .toString());
                                  //               log(">>>>>>>>>$medicalStoreId");
                                  //             },
                                  //             items: medicalStoreValues.map<
                                  //                     DropdownMenuItem<String>>(
                                  //                 (value) {
                                  //               return DropdownMenuItem<String>(
                                  //                 onTap: () {
                                  //                   dropValueMedicalStore =
                                  //                       value.id.toString();
                                  //                   log(".........................$dropValueMedicalStore");
                                  //                   log(dropValueMedicalStore);
                                  //                 },
                                  //                 value: value.laboratory!,
                                  //                 child:
                                  //                     Text(value.laboratory!),
                                  //               );
                                  //             }).toList(),
                                  //           );
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const VerticalSpacingWidget(height: 10),
                                  Obx(() {
                                    return bokingAppointmentLabController
                                            .favoritemedicalshop.isEmpty
                                        ? const Text(
                                            "No Favourite Medical Stores.\n Please add Medical Stores")
                                        : CustomDropDown(
                                            width: double.infinity,
                                            value:
                                                bokingAppointmentLabController
                                                    .initialMedicalStoreIndex
                                                    .value,
                                            items:
                                                bokingAppointmentLabController
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
                                                  .dropdownValueChanging(
                                                      newValue,
                                                      bokingAppointmentLabController
                                                          .initialMedicalStoreIndex
                                                          .value);
                                            },
                                          );
                                  }),
                                  // BlocBuilder<GetAllFavouriteMedicalStoreBloc,
                                  //     GetAllFavouriteMedicalStoreState>(
                                  //   builder: (context, state) {
                                  //     if (state
                                  //         is GetAllFavouriteMedicalStoreLoaded) {
                                  //       final getAllFavouriteMedicalStoreModel =
                                  //           BlocProvider.of<
                                  //                       GetAllFavouriteMedicalStoreBloc>(
                                  //                   context)
                                  //               .getAllFavouriteMedicalStoresModel;

                                  //       if (medicalStoreValues.length <= 1) {
                                  //         medicalStoreValues.addAll(
                                  //             getAllFavouriteMedicalStoreModel
                                  //                 .favoritemedicalshop!);
                                  //       }
                                  //       if (getAllFavouriteMedicalStoreModel
                                  //           .favoritemedicalshop!.isEmpty) {
                                  //         return const Padding(
                                  //           padding: EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //               "No Favourite Medical Stores.\n Please add Medical Stores"),
                                  //         );
                                  //       }
                                  //       return Container(
                                  //         height: 40.h,
                                  //         width: 340.w,
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
                                  //                   dropValueMedicalStoreNotifier,
                                  //               builder: (BuildContext context,
                                  //                   String dropValue1, _) {
                                  //                 return DropdownButtonFormField(
                                  //                   iconEnabledColor:
                                  //                       kMainColor,
                                  //                   decoration:
                                  //                       const InputDecoration
                                  //                           .collapsed(
                                  //                           hintText: ''),
                                  //                   value: dropValue1,
                                  //                   style: size.width > 450
                                  //                       ? blackTabMainText
                                  //                       : blackMainText,
                                  //                   icon: const Icon(Icons
                                  //                       .keyboard_arrow_down),
                                  //                   onChanged: (String? value) {
                                  //                     dropValue1 = value!;
                                  //                     dropValueMedicalStoreNotifier
                                  //                         .value = value;
                                  //                     medicalStoreId =
                                  //                         medicalStoreValues
                                  //                             .where((element) =>
                                  //                                 element
                                  //                                     .laboratory!
                                  //                                     .contains(
                                  //                                         value))
                                  //                             .toList();
                                  //                     // widget.onDropValueChanged(dropValueMedicalStore);
                                  //                     log(dropValueMedicalStoreNotifier
                                  //                         .toString());
                                  //                     log(">>>>>>>>>$medicalStoreId");
                                  //                   },
                                  //                   items: medicalStoreValues
                                  //                       .map<
                                  //                               DropdownMenuItem<
                                  //                                   String>>(
                                  //                           (value) {
                                  //                     return DropdownMenuItem<
                                  //                         String>(
                                  //                       onTap: () {
                                  //                         dropValueMedicalStore =
                                  //                             value.id
                                  //                                 .toString();
                                  //                         log(".........................$dropValueMedicalStore");
                                  //                         log(dropValueMedicalStore);
                                  //                       },
                                  //                       value:
                                  //                           value.laboratory!,
                                  //                       child: Text(
                                  //                           value.laboratory!),
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
                                  const VerticalSpacingWidget(height: 5),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize:
                                              size.width > 450 ? 9.sp : 14.sp),
                                      cursorColor: kMainColor,
                                      controller: labTestController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintStyle: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                        hintText: "Lab test",
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
                                  const VerticalSpacingWidget(height: 5),
                                  Text(
                                    "Select Lab",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                  ),
                                  Obx(() {
                                    return bokingAppointmentLabController
                                            .favoriteLabs.isEmpty
                                        ? const Text(
                                            "No Favourite Labs.Please add Labs")
                                        : CustomDropDown(
                                            width: double.infinity,
                                            value:
                                                bokingAppointmentLabController
                                                    .initialSelectLabIndex
                                                    .value,
                                            items:
                                                bokingAppointmentLabController
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
                                  // BlocBuilder<GetAllFavouriteLabBloc,
                                  //     GetAllFavouriteLabState>(
                                  //   builder: (context, state) {
                                  //     if (state is GetAllFavouriteLabLoaded) {
                                  //       final getAllFavouriteLabModel =
                                  //           BlocProvider.of<
                                  //                       GetAllFavouriteLabBloc>(
                                  //                   context)
                                  //               .getAllFavouriteLabModel;
                                  //       if (labValues.length <= 1) {
                                  //         labValues.addAll(
                                  //             getAllFavouriteLabModel
                                  //                 .favoriteLabs!);
                                  //       }
                                  //       if (getAllFavouriteLabModel
                                  //           .favoriteLabs!.isEmpty) {
                                  //         return const Padding(
                                  //           padding: EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //               "No Favourite Labs.Please add Labs"),
                                  //         );
                                  //       }
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
                                  //                   dropValueLabNotifier,
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
                                  //                   style: size.width > 450
                                  //                       ? blackTabMainText
                                  //                       : blackMainText,
                                  //                   icon: const Icon(Icons
                                  //                       .keyboard_arrow_down),
                                  //                   onChanged: (String? value) {
                                  //                     dropValue = value!;
                                  //                     dropValueLabNotifier
                                  //                         .value = value;
                                  //                     labId = labValues
                                  //                         .where((element) =>
                                  //                             element
                                  //                                 .laboratory!
                                  //                                 .contains(
                                  //                                     value))
                                  //                         .toList();
                                  //                     log("$labId");
                                  //                   },
                                  //                   items: labValues.map<
                                  //                       DropdownMenuItem<
                                  //                           String>>((value) {
                                  //                     return DropdownMenuItem<
                                  //                         String>(
                                  //                       onTap: () {
                                  //                         dropValueLab = value
                                  //                             .id
                                  //                             .toString();
                                  //                         log(dropValueLab);
                                  //                       },
                                  //                       value:
                                  //                           value.laboratory!,
                                  //                       child: Text(
                                  //                           value.laboratory!),
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
                                  // const VerticalSpacingWidget(height: 10),
                                  const VerticalSpacingWidget(height: 5),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize:
                                              size.width > 450 ? 9.sp : 14.sp),
                                      cursorColor: kMainColor,
                                      controller: scanTestController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintStyle: size.width > 450
                                            ? greyTab10B600
                                            : grey13B600,
                                        hintText: "Scan test",
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
                                  const VerticalSpacingWidget(height: 5),
                                  Text(
                                    "Select scanning centre",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                  ),

                                  Obx(() {
                                    return bokingAppointmentLabController
                                            .favoriteLabs.isEmpty
                                        ? const Text(
                                            "No Favourite Labs.Please add Labs")
                                        : CustomDropDown(
                                            width: double.infinity,
                                            value:
                                                bokingAppointmentLabController
                                                    .initialScaningCenerIndex
                                                    .value,
                                            items:
                                                bokingAppointmentLabController
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
                                                  .dropdownValueChanging(
                                                      newValue,
                                                      bokingAppointmentLabController
                                                          .initialScaningCenerIndex
                                                          .value);
                                            },
                                          );
                                  }),

                                  // BlocBuilder<GetAllFavouriteLabBloc,
                                  //     GetAllFavouriteLabState>(
                                  //   builder: (context, state) {
                                  //     if (state is GetAllFavouriteLabLoaded) {
                                  //       final getAllFavouriteLabModel =
                                  //           BlocProvider.of<
                                  //                       GetAllFavouriteLabBloc>(
                                  //                   context)
                                  //               .getAllFavouriteLabModel;
                                  //       if (scanningValues.length <= 1) {
                                  //         scanningValues.addAll(
                                  //             getAllFavouriteLabModel
                                  //                 .favoriteLabs!);
                                  //       }
                                  //       if (getAllFavouriteLabModel
                                  //           .favoriteLabs!.isEmpty) {
                                  //         return const Padding(
                                  //           padding: EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //               "No Favourite Labs.Please add Labs"),
                                  //         );
                                  //       }
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
                                  //                   dropValueScanningNotifier,
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
                                  //                   style: size.width > 450
                                  //                       ? blackTabMainText
                                  //                       : blackMainText,
                                  //                   icon: const Icon(Icons
                                  //                       .keyboard_arrow_down),
                                  //                   onChanged: (String? value) {
                                  //                     dropValue = value!;
                                  //                     dropValueScanningNotifier
                                  //                         .value = value;
                                  //                     scanningId = scanningValues
                                  //                         .where((element) =>
                                  //                             element
                                  //                                 .laboratory!
                                  //                                 .contains(
                                  //                                     value))
                                  //                         .toList();
                                  //                     log("$scanningId");
                                  //                   },
                                  //                   items: scanningValues.map<
                                  //                       DropdownMenuItem<
                                  //                           String>>((value) {
                                  //                     return DropdownMenuItem<
                                  //                         String>(
                                  //                       onTap: () {
                                  //                         dropValueScanning =
                                  //                             value.id
                                  //                                 .toString();
                                  //                         log(dropValueScanning);
                                  //                       },
                                  //                       value:
                                  //                           value.laboratory!,
                                  //                       child: Text(
                                  //                           value.laboratory!),
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
                                  //! add note
                                  Text(
                                    'Add Note',
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
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
                                  getAppointmentsModel
                                              .bookingData![index].date ==
                                          formatDate()
                                      ? InkWell(
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            BlocProvider.of<
                                                        AddAllAppointmentDetailsBloc>(
                                                    context)
                                                .add(
                                              AddAllAppointmentDetails(
                                                tokenId: getAppointmentsModel
                                                    .bookingData![index].tokenId
                                                    .toString(),
                                                labId:
                                                    bokingAppointmentLabController
                                                        .initialSelectLabIndex
                                                        .toString(),
                                                //dropValueLab,
                                                labTest: labTestController.text,
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
                                                //dropValueScanning,
                                                scanTest:
                                                    scanTestController.text,
                                              ),
                                            );
                                            // Wait for 2 seconds

                                            await Future.delayed(
                                                    const Duration(seconds: 3))
                                                .then((value) async {
                                              if (getAppointmentsModel
                                                      .bookingData![index]
                                                      .isCheckedout !=
                                                  1) {
                                                if (currentPosition ==
                                                        listLength - 1 &&
                                                    currentPosition == 0) {
                                                  log("1111111111111111111111111111111111111");

                                                  handleCheckout(
                                                      context, index);
                                                  BlocProvider.of<
                                                              AddCheckinOrCheckoutBloc>(
                                                          context)
                                                      .add(
                                                    EstimateUpdateCheckout(
                                                      tokenId:
                                                          getAppointmentsModel
                                                              .bookingData![
                                                                  index]
                                                              .tokenId
                                                              .toString(),
                                                    ),
                                                  );
                                                  log(" working    ======== with out the");

                                                  navigateToHome(context);
                                                  log("last section currentPosition: $currentPosition");
                                                } else if (currentPosition ==
                                                    listLength - 1) {
                                                  currentPosition--;
                                                  log("Last section: $currentPosition");

                                                  pageController.animateToPage(
                                                    currentPosition,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  log("2222222222222222222222222222222222222222222");
                                                  handleCheckout(
                                                      context, index);
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 8), () {
                                                    BlocProvider.of<
                                                                AddCheckinOrCheckoutBloc>(
                                                            context)
                                                        .add(EstimateUpdateCheckout(
                                                            tokenId:
                                                                getAppointmentsModel
                                                                    .bookingData![
                                                                        index]
                                                                    .tokenId
                                                                    .toString()));
                                                    navigateToHome(context);
                                                  });
                                                  refreshData(context);
                                                } else if (currentPosition <
                                                    listLength - 1) {
                                                  log("33333333333333333333333333333333");
                                                  currentPosition + 1;
                                                  pageController.animateToPage(
                                                    currentPosition,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  handleCheckout(
                                                      context, currentPosition);
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 8), () {
                                                    BlocProvider.of<
                                                                AddCheckinOrCheckoutBloc>(
                                                            context)
                                                        .add(EstimateUpdateCheckout(
                                                            tokenId:
                                                                getAppointmentsModel
                                                                    .bookingData![
                                                                        index]
                                                                    .tokenId
                                                                    .toString()));
                                                    // navigateToHome(context);
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
                                                  bookingPending = listLength -
                                                      1 -
                                                      currentPosition;
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 50.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: getAppointmentsModel
                                                          .bookingData![index]
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
                                                  color: getAppointmentsModel
                                                              .bookingData![
                                                                  index]
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
                                                    color: getAppointmentsModel
                                                                .bookingData![
                                                                    index]
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
                    }
                    return Container();
                  }),
                ),
              );
            }
          },
        ),
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
        if (getAppointmentsModel.bookingData![index].isCheckedin != 1) {
          if (getAppointmentsModel
                  .bookingData![currentPosition].firstIndexStatus ==
              1) {
            GeneralServices.instance.appCloseDialogue(
                context, "Are you sure you want to start the consultation", () {
              Navigator.of(context).pop();
              setState(() {
                getAppointmentsModel.bookingData![index].isCheckedin = 1;
              });
              Future.delayed(const Duration(seconds: 2), () {
                log("First call ============================..........===============...===========");
                BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                  AddCheckinOrCheckout(
                    clinicId: getAppointmentsModel.bookingData![index].clinicId
                        .toString(),
                    isCompleted: 0,
                    isCheckin: 1,
                    tokenNumber: getAppointmentsModel
                        .bookingData![index].tokenNumber
                        .toString(),
                    isReached: '',
                  ),
                );
              }).then((_) {
                return Future.delayed(const Duration(seconds: 8), () {
                  log("Second call ============================..........===============...===========");
                  BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                    EstimateUpdateCheckin(
                      tokenId: getAppointmentsModel.bookingData![index].tokenId
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
              getAppointmentsModel.bookingData![index].isCheckedin = 1;
            });
            //first calling bloc

            Future.delayed(const Duration(seconds: 2), () {
              log("First call else ============================..........===============...===========");
              BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                AddCheckinOrCheckout(
                  clinicId: getAppointmentsModel.bookingData![index].clinicId
                      .toString(),
                  isCompleted: 0,
                  isCheckin: 1,
                  tokenNumber: getAppointmentsModel
                      .bookingData![index].tokenNumber
                      .toString(),
                  isReached: '',
                ),
              );
            }).then((_) {
              return Future.delayed(const Duration(seconds: 8), () {
                log("Second call else ============================..........===============...===========");
                BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
                  EstimateUpdateCheckin(
                    tokenId: getAppointmentsModel.bookingData![index].tokenId
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
          color: getAppointmentsModel.bookingData![index].isCheckedin == 1
              ? kCardColor
              : kMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage("assets/icons/check_in.png"),
              color: getAppointmentsModel.bookingData![index].isCheckedin == 1
                  ? kMainColor
                  : kCardColor,
            ),
            Text(
              "Check In",
              style: size.width > 450
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: getAppointmentsModel
                                  .bookingData![index].isCheckedin ==
                              1
                          ? kMainColor
                          : kCardColor,
                    )
                  : TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: getAppointmentsModel
                                  .bookingData![index].isCheckedin ==
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

  void handleCheckout(
    BuildContext context,
    int index,
  ) {
    BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
      AddCheckinOrCheckout(
        clinicId: getAppointmentsModel.bookingData![index].clinicId.toString(),
        isCompleted: 1,
        isCheckin: 0,
        tokenNumber:
            getAppointmentsModel.bookingData![index].tokenNumber.toString(),
        isReached: '',
      ),
    );

    getAppointmentsModel.bookingData![index].isCheckedout = 1;
    scanTestController.clear();
    afterDaysController.clear();
    noteController.clear();
    labTestController.clear();
    dropValueMedicalStore = '';
    bokingAppointmentLabController.resetToPreviousValue();
    imagePath = null;
  }

  Future<void> handleCheckoutLastSection(
      BuildContext context, int index) async {
    BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
      AddCheckinOrCheckout(
        clinicId: getAppointmentsModel.bookingData![index].clinicId.toString(),
        isCompleted: 1,
        isCheckin: 0,
        tokenNumber:
            getAppointmentsModel.bookingData![index].tokenNumber.toString(),
        isReached: '',
      ),
    );
    getAppointmentsModel.bookingData![index].isCheckedout = 1;
    scanTestController.clear();
    afterDaysController.clear();
    noteController.clear();
    labTestController.clear();
    dropValueMedicalStore = '';
    bokingAppointmentLabController.resetToPreviousValue();

    imagePath = null;
  }

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
    BlocProvider.of<GetAppointmentsBloc>(context).add(
      FetchAllAppointments(
        date: widget.date,
        clinicId: controller.initialIndex!,
        scheduleType: controller.scheduleIndex.value,
      ),
    );
  }

  // Future<void> _showConsultationDialog(BuildContext context, int index) async {
  //   await GeneralServices.instance.appCloseDialogue(
  //     context,
  //     "Are you sure you want to start the consultation",
  //     () {
  //       Navigator.of(context).pop();
  //       _updateCheckInStatus(context, index);
  //     },
  //   );
  // }

  // Future<void> _checkInWithoutDialog(BuildContext context, int index) async {
  //   _updateCheckInStatus(context, index);
  //   await _performDelayedEstimateUpdate(context, index);
  // }

  // void _updateCheckInStatus(BuildContext context, int index) {
  //   setState(() {
  //     getAppointmentsModel.bookingData![index].isCheckedin = 1;
  //   });

  //   BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
  //     AddCheckinOrCheckout(
  //       clinicId: getAppointmentsModel.bookingData![index].clinicId.toString(),
  //       isCompleted: 0,
  //       isCheckin: 1,
  //       tokenNumber:
  //           getAppointmentsModel.bookingData![index].tokenNumber.toString(),
  //       isReached: '',
  //     ),
  //   );
  // }

  // Future<void> _performDelayedEstimateUpdate(
  //     BuildContext context, int index) async {
  //   try {
  //     await Future.delayed(const Duration(seconds: 2));
  //     log("Future.delayed completed for tokenId: ${getAppointmentsModel.bookingData![index].tokenId}");
  //     BlocProvider.of<AddCheckinOrCheckoutBloc>(context).add(
  //       EstimateUpdateCheckin(
  //         tokenId: getAppointmentsModel.bookingData![index].tokenId.toString(),
  //       ),
  //     );
  //   } catch (e) {
  //     log("Error in _performDelayedEstimateUpdate: $e");
  //   }
  // }

  Future<File> compressImage(String imagePath) async {
    // Get the original image file
    File imageFile = File(imagePath);

    // Get the image file size
    int fileSize = await imageFile.length();

    // Set the maximum file size (2048 KB)
    int maxFileSize = 2048 * 1024;

    // Check if the image is already within the size limit
    if (fileSize <= maxFileSize) {
      return imageFile;
    }

    // Compress the image to reduce its size
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 85, // Adjust the quality as needed (0 to 100)
    );

    // Handle nullable Uint8List
    if (compressedBytes != null) {
      // Create a new file for the compressed image
      File compressedImage =
          File(imagePath.replaceAll('.jpg', '_compressed.jpg'));

      // Write the compressed bytes to the new file
      await compressedImage.writeAsBytes(compressedBytes);

      return compressedImage;
    } else {
      // Handle the case when compression fails
      throw Exception('Image compression failed');
    }
  }

  //string replav=ce//
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

  // Future<void> pickImageFromCamera() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     try {
  //       // ignore: unused_local_variable
  //       File compressedImage = await compressImage(pickedFile.path);
  //       imageFromCamera = File(pickedFile.path);
  //     } catch (e) {
  //       log('Error compressing image: $e');
  //       GeneralServices.instance.showToastMessage('Error compressing image');
  //     }
  //   } else {
  //     GeneralServices.instance.showToastMessage('No image selected');
  //   }
  // }
}

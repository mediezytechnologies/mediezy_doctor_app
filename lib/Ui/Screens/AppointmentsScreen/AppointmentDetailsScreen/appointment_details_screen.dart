// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable, avoid_print

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddAllAppointmentDetails/add_all_appointment_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAppointmentDetailsPage/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/image_view_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/medicine_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/patient_details_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/vitals_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({
    Key? key,
    required this.tokenId,
    required this.appointmentsDetails,
    required this.position,
    //mahesh//====
    this.length,
    required this.firstIndex,
  }) : super(key: key);

  final String tokenId;
  final List<Appointments> appointmentsDetails;
  final int position;

  //mahesh//====
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
  List<Widget> textFormFields = [];

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

  late AppointmentDetailsPageModel appointmentDetailsPageModel;
  late GetAllFavouriteLabModel getAllFavouriteLabModel;
  late GetAllFavouriteMedicalStoresModel getAllFavouriteMedicalStoresModel;
  late ClinicGetModel clinicGetModel;
  File? imageFromCamera;
  int currentPosition = 0;

  int? count = 0;

  int? length;
  String? selectedValue;

  bool isFirstCheckIn = true;

//mahesh//====
  int? balanceAppoiment;

  void handleDropValueChanged(String newValue) {
    // Handle the value here in your first screen

    setState(() {
      selectedValue = newValue;
    });
    print("Received value: $newValue");
    // print("::::::::::::::::::$selectedValue");
  }

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetAppointmentsBloc>(context)
        .add(FetchAppointmentDetailsPage(tokenId: widget.tokenId));
    BlocProvider.of<GetAllFavouriteMedicalStoreBloc>(context)
        .add(FetchAllFavouriteMedicalStore());
    BlocProvider.of<GetAllFavouriteLabBloc>(context)
        .add(FetchAllFavouriteLab());
    currentPosition = widget.position;
    dropValueMedicalStoreNotifier =
        ValueNotifier(medicalStoreValues.first.laboratory!);
    dropValueLabNotifier = ValueNotifier(labValues.first.laboratory!);
    dropValueScanningNotifier = ValueNotifier(scanningValues.first.laboratory!);

    setState(() {
      // balanceAppoiment=widget.length!-1;
      balanceAppoiment = widget.length! - 1 - widget.position;
    });

    // dropValueMedicalStoreNotifier =
    //     ValueNotifier(medicalStoreValues.first.laboratory!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddPrescriptionBloc, AddPrescriptionState>(
            listener: (context, state) {
              if (state is AddPrescriptionLoaded) {
                BlocProvider.of<GetAppointmentsBloc>(context).add(
                    FetchAppointmentDetailsPage(
                        tokenId: appointmentDetailsPageModel
                            .bookingData!.tokenId
                            .toString()));
              }
            },
          ),
          BlocListener<AddVitalsBloc, AddVitalsState>(
            listener: (context, state) {
              if (state is AddVitalsLoaded) {
                BlocProvider.of<GetAppointmentsBloc>(context).add(
                    FetchAppointmentDetailsPage(
                        tokenId: appointmentDetailsPageModel
                            .bookingData!.tokenId
                            .toString()));
              }
              if (state is EditVitalsLoaded) {
                BlocProvider.of<GetAppointmentsBloc>(context).add(
                    FetchAppointmentDetailsPage(
                        tokenId: appointmentDetailsPageModel
                            .bookingData!.tokenId
                            .toString()));
              }
              if (state is DeleteVitalsLoaded) {
                BlocProvider.of<GetAppointmentsBloc>(context).add(
                    FetchAppointmentDetailsPage(
                        tokenId: appointmentDetailsPageModel
                            .bookingData!.tokenId
                            .toString()));
              }
            },
          ),
        ],
        child: BlocBuilder<GetAppointmentsBloc, GetAppointmentsState>(
          builder: (context, state) {
            if (state is GetAppointmentsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAppointmentsError) {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
            if (state is GetAppointmentsLoaded) {
              appointmentDetailsPageModel =
                  BlocProvider.of<GetAppointmentsBloc>(context)
                      .appointmentDetailsPageModel;
              return FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacingWidget(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (currentPosition != 0) {
                                  currentPosition--;
                                  BlocProvider.of<GetAppointmentsBloc>(context)
                                      .add(
                                    FetchAppointmentDetailsPage(
                                      tokenId: widget
                                          .appointmentsDetails[currentPosition]
                                          .id
                                          .toString(),
                                    ),
                                  );
                                  setState(() {
                                    balanceAppoiment =
                                        widget.length! - currentPosition - 1;
                                    log("pos-- $currentPosition");
                                  });
                                } else {
                                  // ignore: void_checks
                                  return GeneralServices.instance
                                      .showToastMessage(
                                          "There is no more appointments");
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                                color: kMainColor,
                              )),
                          FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: PatientImageWidget(
                                patientImage: appointmentDetailsPageModel
                                            .bookingData!.userImage ==
                                        null
                                    ? ""
                                    : appointmentDetailsPageModel
                                        .bookingData!.userImage
                                        .toString(),
                                radius: 40),
                          ),
                          // const HorizontalSpacingWidget(width: 25),
                          //! name
                          nameCard(),
                          IconButton(
                              onPressed: () {
                                if (currentPosition >= 0 &&
                                    currentPosition <
                                        widget.appointmentsDetails.length) {
                                  currentPosition++;
                                  BlocProvider.of<GetAppointmentsBloc>(context)
                                      .add(
                                    FetchAppointmentDetailsPage(
                                      tokenId: widget
                                          .appointmentsDetails[currentPosition]
                                          .id
                                          .toString(),
                                    ),
                                  );
                                  setState(() {
                                    balanceAppoiment =
                                        widget.length! - 1 - currentPosition;
                                    log("pos-- $currentPosition");
                                  });
                                } else {
                                  GeneralServices.instance.showToastMessage(
                                      "There are no more appointments");
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: kMainColor,
                                size: 30,
                              )),
                        ],
                      ),
                      // Text("data:${length}"),
                      //
                      // Text("len : ${widget.length}"),
                      // Text("balace $balanceAppoiment"),
                      Container(
                        height: 30.h,
                        width: 120.w,
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
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: kCardColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25.h,
                                width: 28.w,
                                decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    // "12",
                                    "$balanceAppoiment",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      PatientDetailsWidget(
                          appointmentDetailsPageModel:
                              appointmentDetailsPageModel),
                      appointmentDetailsPageModel.bookingData!.date ==
                              formatDate()
                          ? InkWell(
                              onTap: () {
                                if (appointmentDetailsPageModel
                                        .bookingData!.isCheckedin !=
                                    1) {
                                  if (widget
                                          .appointmentsDetails[currentPosition]
                                          .firstIndexStatus ==
                                      1) {
                                    // Show alert dialog only for the first token's check-in
                                    GeneralServices.instance.appCloseDialogue(
                                        context,
                                        "Are you sure you want to start the consultation",
                                        () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        appointmentDetailsPageModel
                                            .bookingData!.isCheckedin = 1;
                                      });
                                      // Execute the BlocProvider logic for the first token only when the user presses OK
                                      BlocProvider.of<AddCheckinOrCheckoutBloc>(
                                              context)
                                          .add(
                                        AddCheckinOrCheckout(
                                          clinicId: appointmentDetailsPageModel
                                              .bookingData!.clinicId
                                              .toString(),
                                          isCompleted: 0,
                                          isCheckin: 1,
                                          tokenNumber:
                                              appointmentDetailsPageModel
                                                  .bookingData!.tokenNumber
                                                  .toString(),
                                          isReached: '',
                                        ),
                                      );
                                      isFirstCheckIn = false; // Update is
                                    });
                                  } else {
                                    // For tokens other than the first one, directly execute the BlocProvider logic
                                    // clickedIndex = index;
                                    setState(() {
                                      appointmentDetailsPageModel
                                          .bookingData!.isCheckedin = 1;
                                    });
                                    BlocProvider.of<AddCheckinOrCheckoutBloc>(
                                            context)
                                        .add(
                                      AddCheckinOrCheckout(
                                        clinicId: appointmentDetailsPageModel
                                            .bookingData!.clinicId
                                            .toString(),
                                        isCompleted: 0,
                                        isCheckin: 1,
                                        tokenNumber: appointmentDetailsPageModel
                                            .bookingData!.tokenNumber
                                            .toString(),
                                        isReached: '',
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: appointmentDetailsPageModel
                                              .bookingData!.isCheckedin ==
                                          1
                                      ? kCardColor
                                      : kMainColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          "assets/icons/check_in.png"),
                                      color: appointmentDetailsPageModel
                                                  .bookingData!.isCheckedin ==
                                              1
                                          ? kMainColor
                                          : kCardColor,
                                    ),
                                    Text(
                                      "Check In",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: appointmentDetailsPageModel
                                                    .bookingData!.isCheckedin ==
                                                1
                                            ? kMainColor
                                            : kCardColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      const VerticalSpacingWidget(height: 10),
                      VitalsWidget(
                          tokenId: appointmentDetailsPageModel
                              .bookingData!.tokenId
                              .toString(),
                          appointmentDetailsPageModel:
                              appointmentDetailsPageModel),
                      // }, child: Text("data")),
                      MedicineWidget(
                        tokenId: appointmentDetailsPageModel
                            .bookingData!.tokenId
                            .toString(),
                        appointmentDetailsPageModel:
                            appointmentDetailsPageModel,
                        medicalStoreId: dropValueMedicalStore,
                        // medicalStoreId: ,
                      ),
                      // const VerticalSpacingWidget(height: 10),
                      // const VerticalSpacingWidget(height: 5),
                      //! upload attachments
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Upload attachments',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: kTextColor),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await pickImageFromCamera();
                                  setState(
                                      () {}); // Refresh the screen after picking the image
                                },
                                icon: Icon(
                                  Icons.upload_file_outlined,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      imageFromCamera == null
                          ? Container()
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ImageViewWidget(
                                            image: imageFromCamera)));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View your uploaded image",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                  const HorizontalSpacingWidget(width: 10),
                                  const Icon(
                                    Icons.image,
                                    color: Colors.blue,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                      const VerticalSpacingWidget(height: 5),
                      Text(
                        "Review After",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Colors.black),
                      ),
                      //! dosage
                      Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            height: 45.h,
                            width: 120.w,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: afterDaysController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 13.sp, color: kSubTextColor),
                                hintText: "Days",
                                filled: true,
                                fillColor: kCardColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpacingWidget(height: 10),
                      BlocBuilder<GetAllFavouriteMedicalStoreBloc,
                          GetAllFavouriteMedicalStoreState>(
                        builder: (context, state) {
                          if (state is GetAllFavouriteMedicalStoreLoaded) {
                            final getAllFavouriteMedicalStoreModel =
                                BlocProvider.of<
                                            GetAllFavouriteMedicalStoreBloc>(
                                        context)
                                    .getAllFavouriteMedicalStoresModel;
                            if (medicalStoreValues.length <= 1) {
                              medicalStoreValues.addAll(
                                  getAllFavouriteMedicalStoreModel
                                      .favoritemedicalshop!);
                            }
                            if (getAllFavouriteMedicalStoreModel
                                .favoritemedicalshop!.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    "No Favourite Medical Stores.\n Please add Medical Stores"),
                              );
                            }
                            return Container(
                              height: 40.h,
                              width: 340.w,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        dropValueMedicalStoreNotifier,
                                    builder: (BuildContext context,
                                        String dropValue1, _) {
                                      return DropdownButtonFormField(
                                        iconEnabledColor: kMainColor,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: dropValue1,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        onChanged: (String? value) {
                                          dropValue1 = value!;
                                          dropValueMedicalStoreNotifier.value =
                                              value;
                                          medicalStoreId = medicalStoreValues
                                              .where((element) => element
                                                  .laboratory!
                                                  .contains(value))
                                              .toList();
                                          // widget.onDropValueChanged(dropValueMedicalStore);
                                          (">>>>>>>>>$medicalStoreId");
                                        },
                                        items: medicalStoreValues
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            onTap: () {
                                              dropValueMedicalStore =
                                                  value.id.toString();
                                              print(
                                                  ".........................$dropValueMedicalStore");
                                            },
                                            value: value.laboratory!,
                                            child: Text(value.laboratory!),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      const VerticalSpacingWidget(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: labTestController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
                            hintText: "Lab test",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 5),
                      Text(
                        "Select Lab",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: kSubTextColor),
                      ),
                      BlocBuilder<GetAllFavouriteLabBloc,
                          GetAllFavouriteLabState>(
                        builder: (context, state) {
                          if (state is GetAllFavouriteLabLoaded) {
                            final getAllFavouriteLabModel =
                                BlocProvider.of<GetAllFavouriteLabBloc>(context)
                                    .getAllFavouriteLabModel;
                            if (labValues.length <= 1) {
                              labValues.addAll(
                                  getAllFavouriteLabModel.favoriteLabs!);
                            }
                            if (getAllFavouriteLabModel.favoriteLabs!.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Text("No Favourite Labs.Please add Labs"),
                              );
                            }
                            return Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: ValueListenableBuilder(
                                    valueListenable: dropValueLabNotifier,
                                    builder: (BuildContext context,
                                        String dropValue, _) {
                                      return DropdownButtonFormField(
                                        iconEnabledColor: kMainColor,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: dropValue,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        onChanged: (String? value) {
                                          dropValue = value!;
                                          dropValueLabNotifier.value = value;
                                          labId = labValues
                                              .where((element) => element
                                                  .laboratory!
                                                  .contains(value))
                                              .toList();
                                          print(labId);
                                        },
                                        items: labValues
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            onTap: () {
                                              dropValueLab =
                                                  value.id.toString();
                                              print(dropValueLab);
                                            },
                                            value: value.laboratory!,
                                            child: Text(value.laboratory!),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      // const VerticalSpacingWidget(height: 10),
                      const VerticalSpacingWidget(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: scanTestController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
                            hintText: "Scan test",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 5),
                      Text(
                        "Select scanning centre",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: kSubTextColor),
                      ),
                      BlocBuilder<GetAllFavouriteLabBloc,
                          GetAllFavouriteLabState>(
                        builder: (context, state) {
                          if (state is GetAllFavouriteLabLoaded) {
                            final getAllFavouriteLabModel =
                                BlocProvider.of<GetAllFavouriteLabBloc>(context)
                                    .getAllFavouriteLabModel;
                            if (scanningValues.length <= 1) {
                              scanningValues.addAll(
                                  getAllFavouriteLabModel.favoriteLabs!);
                            }
                            if (getAllFavouriteLabModel.favoriteLabs!.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Text("No Favourite Labs.Please add Labs"),
                              );
                            }
                            return Container(
                              height: 40.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF9C9C9C))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Center(
                                  child: ValueListenableBuilder(
                                    valueListenable: dropValueScanningNotifier,
                                    builder: (BuildContext context,
                                        String dropValue, _) {
                                      return DropdownButtonFormField(
                                        iconEnabledColor: kMainColor,
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        value: dropValue,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        onChanged: (String? value) {
                                          dropValue = value!;
                                          dropValueScanningNotifier.value =
                                              value;
                                          scanningId = scanningValues
                                              .where((element) => element
                                                  .laboratory!
                                                  .contains(value))
                                              .toList();
                                          print(scanningId);
                                        },
                                        items: scanningValues
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            onTap: () {
                                              dropValueScanning =
                                                  value.id.toString();
                                              print(dropValueScanning);
                                            },
                                            value: value.laboratory!,
                                            child: Text(value.laboratory!),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),

                      const VerticalSpacingWidget(height: 10),
                      //! add note
                      Text(
                        'Add Note',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: kTextColor),
                      ),
                      const VerticalSpacingWidget(height: 5),
                      TextFormField(
                        cursorColor: kMainColor,
                        controller: noteController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 15.sp, color: kSubTextColor),
                          hintText: "Add you notes",
                          filled: true,
                          fillColor: kCardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      appointmentDetailsPageModel.bookingData!.date ==
                              formatDate()
                          ? InkWell(
                              onTap: () {
                                BlocProvider.of<AddAllAppointmentDetailsBloc>(
                                        context)
                                    .add(
                                  AddAllAppointmentDetails(
                                    tokenId: widget.tokenId,
                                    labId: dropValueLab,
                                    labTest: labTestController.text,
                                    // labTest: labTestValues.join(', '),
                                    // medicalshopId: dropValueMedicalStore,
                                    // medicalshopId: selectedValue.toString(),
                                    medicalshopId: selectedValue == "null"
                                        ? ""
                                        : selectedValue.toString(),
                                    imageFromCamera,
                                    reviewAfter: afterDaysController.text,
                                    notes: noteController.text,
                                    scanId: dropValueScanning,
                                    scanTest: scanTestController.text,
                                  ),
                                );
                                Future.delayed(
                                        const Duration(milliseconds: 1000))
                                    .then((value) {
                                  if (appointmentDetailsPageModel
                                          .bookingData!.isCheckedout !=
                                      1) {
                                    // clickedIndex = index;
                                    BlocProvider.of<AddCheckinOrCheckoutBloc>(
                                            context)
                                        .add(
                                      AddCheckinOrCheckout(
                                        clinicId: appointmentDetailsPageModel
                                            .bookingData!.clinicId
                                            .toString(),
                                        isCompleted: 1,
                                        isCheckin: 1,
                                        tokenNumber: appointmentDetailsPageModel
                                            .bookingData!.tokenNumber
                                            .toString(),
                                        isReached: '',
                                      ),
                                    );
                                    setState(() {
                                      appointmentDetailsPageModel
                                          .bookingData!.isCheckedout = 1;
                                    });
                                  }
                                  if (currentPosition >= 0 &&
                                      currentPosition <
                                          widget.appointmentsDetails.length) {
                                    currentPosition++;
                                    BlocProvider.of<GetAppointmentsBloc>(
                                            context)
                                        .add(
                                      FetchAppointmentDetailsPage(
                                        tokenId: widget
                                            .appointmentsDetails[
                                                currentPosition]
                                            .id
                                            .toString(),
                                      ),
                                    );
                                  } else {
                                    GeneralServices.instance.showToastMessage(
                                        "There are no more appointments");
                                  }
                                });

                                print(selectedValue);
                                // setState(() {
                                afterDaysController.clear();
                                noteController.clear();
                                labTestController.clear();
                                imageFromCamera = null;
                                // });
                              },
                              child: Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: appointmentDetailsPageModel
                                              .bookingData!.isCheckedout ==
                                          1
                                      ? kCardColor
                                      : kMainColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          "assets/icons/check_out.png"),
                                      color: appointmentDetailsPageModel
                                                  .bookingData!.isCheckedout ==
                                              1
                                          ? kMainColor
                                          : Colors.white,
                                    ),
                                    Text(
                                      "Check Out",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: appointmentDetailsPageModel
                                                      .bookingData!
                                                      .isCheckedout ==
                                                  1
                                              ? kMainColor
                                              : Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),

                      const VerticalSpacingWidget(height: 10),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  SizedBox nameCard() {
    return SizedBox(
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointmentDetailsPageModel.bookingData!.patientName.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // const VerticalSpacingWidget(height: 10),
          Row(
            children: [
              Text(
                "Token Number : ",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: kSubTextColor),
              ),
              Text(
                appointmentDetailsPageModel.bookingData!.tokenNumber!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          appointmentDetailsPageModel.bookingData!.mediezyPatientId == null
              ? Container()
              : Row(
                  children: [
                    Text(
                      "Patient Id : ",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: kSubTextColor),
                    ),
                    Text(
                      appointmentDetailsPageModel
                          .bookingData!.mediezyPatientId!,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
          // const VerticalSpacingWidget(height: 10),
          // appointmentDetailsPageModel
          //     .bookingData!.patient=="null"?Container():
          appointmentDetailsPageModel.bookingData!.patient == null
              ? Container()
              : Text(
                  appointmentDetailsPageModel.bookingData!.patient!.age
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
    // imageFromCamera?.dispose();
  }

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

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        File compressedImage = await compressImage(pickedFile.path);
        imageFromCamera = File(pickedFile.path);
      } catch (e) {
        print('Error compressing image: $e');
        GeneralServices.instance.showToastMessage('Error compressing image');
      }
    } else {
      GeneralServices.instance.showToastMessage('No image selected');
    }
  }
}

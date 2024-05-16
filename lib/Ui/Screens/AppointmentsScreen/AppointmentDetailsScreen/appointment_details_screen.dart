import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddAllAppointmentDetails/add_all_appointment_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAppointmentDetailsPage/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
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

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({
    Key? key,
    required this.tokenId,
    required this.appointmentsDetails,
    required this.position,
    //mahesh//====
    this.length,
    required this.firstIndex,
    required this.date,
  }) : super(key: key);

  final String tokenId;
  final List<Appointments> appointmentsDetails;
  final int position;
  final String date;

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

  final HospitalController controller = Get.put(HospitalController());

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
    BlocProvider.of<GetAllAppointmentsBloc>(context).add(FetchAllAppointments(
      date: widget.date,
      clinicId: controller.initialIndex!,
      scheduleType: controller.scheduleIndex.value,
    ));
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
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        BlocProvider.of<GetAllAppointmentsBloc>(context)
            .add(FetchAllAppointments(
          date: widget.date,
          clinicId: controller.initialIndex!,
          scheduleType: controller.scheduleIndex.value,
        ));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<GetAllAppointmentsBloc>(context)
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
                                  size: size.width > 450 ? 16.sp : 25.sp,
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
                                  radius: 40.r),
                            ),
                            // const HorizontalSpacingWidget(width: 25),
                            //! name
                            nameCard(context),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (currentPosition >= 0 &&
                                        currentPosition <
                                            widget.appointmentsDetails.length) {
                                      currentPosition++;
                                      // setState(() {
                                      BlocProvider.of<GetAllAppointmentsBloc>(
                                              context)
                                          .add(FetchAllAppointments(
                                        date: widget.date,
                                        clinicId: controller.initialIndex!,
                                        scheduleType:
                                            controller.scheduleIndex.value,
                                      ));
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
                                      // });
                                      log("counttttttttttttttt${widget.appointmentsDetails.length.toString()}");

                                      // setState(() {
                                      balanceAppoiment =
                                          widget.length! - 1 - currentPosition;
                                      log("pos-- $currentPosition");
                                      // });
                                    } else {
                                      GeneralServices.instance.showToastMessage(
                                          "There are no more appointments");
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: kMainColor,
                                  size: size.width > 450 ? 16.sp : 25.sp,
                                )),
                          ],
                        ),
                        // Text("data:${length}"),
                        //
                        // Text("len : ${widget.length}"),
                        // Text("balance $balanceAppoiment"),
                        Container(
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
                                      "$balanceAppoiment",
                                      style: size.width > 450
                                          ? blackTab12B600
                                          : black15B600,
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
                                            .appointmentsDetails[
                                                currentPosition]
                                            .firstIndexStatus ==
                                        1) {
                                      GeneralServices.instance.appCloseDialogue(
                                          context,
                                          "Are you sure you want to start the consultation",
                                          () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          appointmentDetailsPageModel
                                              .bookingData!.isCheckedin = 1;
                                        });
                                        BlocProvider.of<
                                                    AddCheckinOrCheckoutBloc>(
                                                context)
                                            .add(
                                          AddCheckinOrCheckout(
                                            clinicId:
                                                appointmentDetailsPageModel
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
                                          tokenNumber:
                                              appointmentDetailsPageModel
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
                                        style: size.width > 450
                                            ? TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    appointmentDetailsPageModel
                                                                .bookingData!
                                                                .isCheckedin ==
                                                            1
                                                        ? kMainColor
                                                        : kCardColor,
                                              )
                                            : TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    appointmentDetailsPageModel
                                                                .bookingData!
                                                                .isCheckedin ==
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
                        ),
                        //! upload attachments
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Upload attachments',
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText),
                                IconButton(
                                  onPressed: () async {
                                    await pickImageFromCamera();
                                    setState(
                                        () {}); // Refresh the screen after picking the image
                                  },
                                  icon: Icon(
                                    Icons.upload_file_outlined,
                                    color: kMainColor,
                                    size: size.width > 450 ? 15.sp : 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 5),
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
                                    const HorizontalSpacingWidget(width: 10),
                                    Icon(
                                      Icons.image,
                                      color: Colors.blue,
                                      size: size.width > 450 ? 20.sp : 28.sp,
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
                                    fontSize: size.width > 450 ? 9.sp : 14.sp),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
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
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          onChanged: (String? value) {
                                            dropValue1 = value!;
                                            dropValueMedicalStoreNotifier
                                                .value = value;
                                            medicalStoreId = medicalStoreValues
                                                .where((element) => element
                                                    .laboratory!
                                                    .contains(value))
                                                .toList();
                                            // widget.onDropValueChanged(dropValueMedicalStore);
                                            log(dropValueMedicalStoreNotifier
                                                .toString());
                                            log(">>>>>>>>>$medicalStoreId");
                                          },
                                          items: medicalStoreValues
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              onTap: () {
                                                dropValueMedicalStore =
                                                    value.id.toString();
                                                log(".........................$dropValueMedicalStore");
                                                log(dropValueMedicalStore);
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
                            style: TextStyle(
                                fontSize: size.width > 450 ? 9.sp : 14.sp),
                            cursorColor: kMainColor,
                            controller: labTestController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
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
                          style: size.width > 450 ? greyTabMain : greyMain,
                        ),
                        BlocBuilder<GetAllFavouriteLabBloc,
                            GetAllFavouriteLabState>(
                          builder: (context, state) {
                            if (state is GetAllFavouriteLabLoaded) {
                              final getAllFavouriteLabModel =
                                  BlocProvider.of<GetAllFavouriteLabBloc>(
                                          context)
                                      .getAllFavouriteLabModel;
                              if (labValues.length <= 1) {
                                labValues.addAll(
                                    getAllFavouriteLabModel.favoriteLabs!);
                              }
                              if (getAllFavouriteLabModel
                                  .favoriteLabs!.isEmpty) {
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
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
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
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
                                            log("$labId");
                                          },
                                          items: labValues
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              onTap: () {
                                                dropValueLab =
                                                    value.id.toString();
                                                log(dropValueLab);
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
                            style: TextStyle(
                                fontSize: size.width > 450 ? 9.sp : 14.sp),
                            cursorColor: kMainColor,
                            controller: scanTestController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle:
                                  size.width > 450 ? greyTab10B600 : grey13B600,
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
                          style: size.width > 450 ? greyTabMain : greyMain,
                        ),
                        BlocBuilder<GetAllFavouriteLabBloc,
                            GetAllFavouriteLabState>(
                          builder: (context, state) {
                            if (state is GetAllFavouriteLabLoaded) {
                              final getAllFavouriteLabModel =
                                  BlocProvider.of<GetAllFavouriteLabBloc>(
                                          context)
                                      .getAllFavouriteLabModel;
                              if (scanningValues.length <= 1) {
                                scanningValues.addAll(
                                    getAllFavouriteLabModel.favoriteLabs!);
                              }
                              if (getAllFavouriteLabModel
                                  .favoriteLabs!.isEmpty) {
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Center(
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          dropValueScanningNotifier,
                                      builder: (BuildContext context,
                                          String dropValue, _) {
                                        return DropdownButtonFormField(
                                          iconEnabledColor: kMainColor,
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          value: dropValue,
                                          style: size.width > 450
                                              ? blackTabMainText
                                              : blackMainText,
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
                                            log("$scanningId");
                                          },
                                          items: scanningValues
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              onTap: () {
                                                dropValueScanning =
                                                    value.id.toString();
                                                log(dropValueScanning);
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
                          style: size.width > 450 ? greyTabMain : greyMain,
                        ),
                        const VerticalSpacingWidget(height: 5),
                        TextFormField(
                          style: TextStyle(
                              fontSize: size.width > 450 ? 9.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: noteController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
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
                                      medicalshopId: dropValueMedicalStore,
                                      // medicalshopId: selectedValue.toString(),
                                      // medicalshopId: selectedValue == "null"
                                      //     ? ""
                                      //     : selectedValue.toString(),
                                      imageFromCamera,
                                      reviewAfter: afterDaysController.text,
                                      notes: noteController.text,
                                      scanId: dropValueScanning,
                                      scanTest: scanTestController.text,
                                    ),
                                  );
                                  Future.delayed(const Duration(seconds: 2))
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
                                          isCheckin: 0,
                                          tokenNumber:
                                              appointmentDetailsPageModel
                                                  .bookingData!.tokenNumber
                                                  .toString(),
                                          isReached: '',
                                        ),
                                      );
                                      // setState(() {
                                      appointmentDetailsPageModel
                                          .bookingData!.isCheckedout = 1;
                                      // });
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

                                  log("$selectedValue");
                                  // setState(() {
                                  scanTestController.clear();
                                  afterDaysController.clear();
                                  noteController.clear();
                                  labTestController.clear();
                                  dropValueMedicalStore = '';
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
                                                    .bookingData!
                                                    .isCheckedout ==
                                                1
                                            ? kMainColor
                                            : Colors.white,
                                      ),
                                      Text(
                                        "Check Out",
                                        style: size.width > 450
                                            ? TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    appointmentDetailsPageModel
                                                                .bookingData!
                                                                .isCheckedout ==
                                                            1
                                                        ? kMainColor
                                                        : Colors.white)
                                            : TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    appointmentDetailsPageModel
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
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  SizedBox nameCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointmentDetailsPageModel.bookingData!.patientName.toString(),
            style: size.width > 450 ? blackTabMainText : blackMainText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // const VerticalSpacingWidget(height: 10),
          Row(
            children: [
              Text(
                "Token Number : ",
                style: size.width > 450 ? greyTabMain : grey10B400,
              ),
              Text(
                appointmentDetailsPageModel.bookingData!.tokenNumber!,
                style: size.width > 450 ? blackTabMainText : blackMainText,
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
                      style: size.width > 450 ? greyTabMain : grey10B400,
                    ),
                    Text(
                      appointmentDetailsPageModel
                          .bookingData!.mediezyPatientId!,
                      style:
                          size.width > 450 ? blackTabMainText : blackMainText,
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
              : Row(
                  children: [
                    Text(
                      "Age : ",
                      style: size.width > 450 ? greyTabMain : grey10B400,
                    ),
                    Text(
                      appointmentDetailsPageModel.bookingData!.patient!.age
                          .toString(),
                      style:
                          size.width > 450 ? blackTabMainText : blackMainText,
                    ),
                  ],
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

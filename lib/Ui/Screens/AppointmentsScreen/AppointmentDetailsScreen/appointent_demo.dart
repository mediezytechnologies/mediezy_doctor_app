// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_favourite_lab_model.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_fav_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAppointmentDetailsPage/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class AppointmentDemo extends StatefulWidget {
  const AppointmentDemo({
    super.key,
    required this.tokenId,
    required this.appointmentsDetails,
    this.itemCount,
    this.itemLength,
  });

  final String tokenId;
  final List<Appointments> appointmentsDetails;
  final int? itemCount;

  final int? itemLength;

  @override
  State<AppointmentDemo> createState() => _AppointmentDemoState();
}

class _AppointmentDemoState extends State<AppointmentDemo> {
  final PageController controller = PageController();
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

  late ValueNotifier<String> dropValueScanningNotifier;
  String dropValueScanning = "";
  late List<FavoriteLabs> scanningId;
  List<FavoriteLabs> scanningValues = [
    FavoriteLabs(laboratory: "Select scanning centre")
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

  int clickedIndex = 0;
  int? currentTokenLength = 1;
  int currentIndex = 0;

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
    // currentPosition = widget.position;

    dropValueLabNotifier = ValueNotifier(labValues.first.laboratory!);
    dropValueScanningNotifier = ValueNotifier(scanningValues.first.laboratory!);
    // dropValueMedicalStoreNotifier =
    //     ValueNotifier(medicalStoreValues.first.laboratory!);
    setState(() {
      currentIndex = widget.itemCount!;
    });
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
        body: PageView.builder(
          itemCount: widget.itemLength, // Number of pages
          itemBuilder: (context, index) {
            // Builder function to build each page
            return BlocBuilder<GetAppointmentsBloc, GetAppointmentsState>(
              builder: (context, state) {
                if (state is GetAppointmentsLoaded) {
                  appointmentDetailsPageModel =
                      BlocProvider
                          .of<GetAppointmentsBloc>(context)
                          .appointmentDetailsPageModel;
                  return Column(
                    children: [
                      Container(
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            'Page ${appointmentDetailsPageModel.bookingData!.patientName
                                .toString()}',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }return Container();
              },
            );
          },
        ));
    // body: MultiBlocListener(
    //   listeners: [
    //     BlocListener<AddPrescriptionBloc, AddPrescriptionState>(
    //       listener: (context, state) {
    //         if (state is AddPrescriptionLoaded) {
    //           BlocProvider.of<GetAppointmentsBloc>(context).add(
    //               FetchAppointmentDetailsPage(
    //                   tokenId: appointmentDetailsPageModel
    //                       .bookingData!.tokenId
    //                       .toString()));
    //         }
    //         // if (state is AddPrescriptionError) {
    //         //   GeneralServices.instance
    //         //       .showErrorMessage(context, state.errorMessage);
    //         // }
    //       },
    //     ),
    //     BlocListener<AddVitalsBloc, AddVitalsState>(
    //       listener: (context, state) {
    //         if (state is AddVitalsLoaded) {
    //           BlocProvider.of<GetAppointmentsBloc>(context).add(
    //               FetchAppointmentDetailsPage(
    //                   tokenId: appointmentDetailsPageModel
    //                       .bookingData!.tokenId
    //                       .toString()));
    //         }
    //         if (state is EditVitalsLoaded) {
    //           BlocProvider.of<GetAppointmentsBloc>(context).add(
    //               FetchAppointmentDetailsPage(
    //                   tokenId: appointmentDetailsPageModel
    //                       .bookingData!.tokenId
    //                       .toString()));
    //         }
    //         if (state is DeleteVitalsLoaded) {
    //           BlocProvider.of<GetAppointmentsBloc>(context).add(
    //               FetchAppointmentDetailsPage(
    //                   tokenId: appointmentDetailsPageModel
    //                       .bookingData!.tokenId
    //                       .toString()));
    //         }
    //       },
    //     ),
    //   ],
    //   child: BlocBuilder<GetAppointmentsBloc, GetAppointmentsState>(
    //     builder: (context, state) {
    //       log(">>>>>>>>>>>>>>>>>>$currentIndex");
    //       log("<<<<<<<<<<<<<<<<<<<<<<<<>>${widget.itemLength}");
    //       if (state is GetAppointmentsLoading) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (state is GetAppointmentsError) {
    //         return const Center(
    //           child: Text("Something Went Wrong"),
    //         );
    //       }
    //       if (state is GetAppointmentsLoaded) {
    //         appointmentDetailsPageModel =
    //             BlocProvider.of<GetAppointmentsBloc>(context)
    //                 .appointmentDetailsPageModel;
    //
    //         // SizedBox(
    //         //   height: 520.h,
    //         //   width: 700.w,
    //         //   child: PageView.builder(
    //         //  //   physics: const NeverScrollableScrollPhysics(),
    //         //     itemCount: widget.itemLength,
    //         //     controller: controller,
    //         //     onPageChanged: (index) {
    //         //       // if (clickedIndex != 0) {
    //         //       //   index = clickedIndex;
    //         //       // }
    //         //       currentTokenLength = index + 1;
    //         //       clickedIndex = index;
    //         //       currentIndex = index % widget.itemLength!.toInt();
    //         //       log("$currentIndex");
    //         //     },
    //         //     itemBuilder: (context, index) {
    //         //       // length = widget.itemLength;
    //         //
    //         //       // if (clickedIndex != 0) {
    //         //       //   index = clickedIndex;
    //         //       // }
    //         //       return Column(
    //         //         children: [
    //         //           Center(
    //         //             child: Container(
    //         //                 height: 50,
    //         //                 width: 50,
    //         //                 color: Colors.yellow,
    //         //                 child: Text("gdsfxdg")),
    //         //           ),
    //         //         ],
    //         //       );
    //         //     },
    //         //   ),
    //         // );
    //       }
    //       return Container();
    //     },
    //   ),
    // ),
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

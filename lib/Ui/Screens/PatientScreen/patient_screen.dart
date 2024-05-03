import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/HealthRecords/patients_get_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/patients_card_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/search_patients_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../Repositary/Bloc/HealthRecords/PatientsGet/patients_get_bloc.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  late PatientsGetModel patientsGetModel;
  late ClinicGetModel clinicGetModel;

  final HospitalController dController = Get.put(HospitalController());

  // late ValueNotifier<String> dropValueClinicNotifier;
  // String clinicId = "";
  // late String selectedClinicId;
  // List<HospitalDetails> clinicValues = [];

  //! sorting
  var items = ['All', 'Year', 'Month', 'Week', 'Today', 'Custom'];
  String dropdownValue = 'All';

  String _startRange = '';
  String _endRange = '';

  DateTime? selectedDate;

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<PatientsGetBloc>(context)
        .add(FetchPatients(clinicId: dController.initialIndex!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => const BottomNavigationControlWidget()));
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Patients"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPatientsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search your Patients",
                              style: TextStyle(
                                  fontSize: 15.sp, color: kSubTextColor),
                            ),
                            CircleAvatar(
                              backgroundColor: kMainColor,
                              radius: 16.r,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  IconlyLight.search,
                                  color: kCardColor,
                                  size: 16.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "Select Clinic",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: kSubTextColor),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        GetBuilder<HospitalController>(builder: (clx) {
                          return CustomDropDown(
                            width: 210.w,
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
                              BlocProvider.of<PatientsGetBloc>(context).add(
                                  FetchPatients(
                                      clinicId: dController.initialIndex!));
                            },
                          );
                        }),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "Sort",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: kSubTextColor),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        CustomDropDown(
                          width: 130.w,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              setState(() {
                                dropdownValue = newValue;
                                if (newValue == 'Custom') {
                                  _showCustomAlertDialog(context);
                                } else {
                                  // Handle other options
                                }
                              });
                              BlocProvider.of<PatientsGetBloc>(context).add(
                                  FetchSortPatients(
                                      sort: dropdownValue,
                                      clinicId: dController.initialIndex!,
                                      fromDate: _startRange,
                                      toDate: _endRange));
                              // print(dropdownvalue);
                            });
                          },
                          value: dropdownValue,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                        ),
                        // Container(
                        //   height: 40.h,
                        //   width: 130.w,
                        //   decoration: BoxDecoration(
                        //       color: kCardColor,
                        //       borderRadius: BorderRadius.circular(5),
                        //       border: Border.all(color: const Color(0xFF9C9C9C))),
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                        //     child: Center(
                        //       child: DropdownButtonFormField(
                        //         iconEnabledColor: kMainColor,
                        //         decoration:
                        //             const InputDecoration.collapsed(hintText: ''),
                        //         value: dropdownValue,
                        //         style: TextStyle(
                        //             fontSize: 14.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: kTextColor),
                        //         icon: const Icon(Icons.keyboard_arrow_down),
                        //         items: items.map((String items) {
                        //           return DropdownMenuItem(
                        //             value: items,
                        //             child: Text(items),
                        //           );
                        //         }).toList(),
                        //         onChanged: (String? newValue) {
                        //           setState(() {
                        //             dropdownValue = newValue!;
                        //             setState(() {
                        //               dropdownValue = newValue;
                        //               if (newValue == 'Custom') {
                        //                 _showCustomAlertDialog(context);
                        //               } else {
                        //                 // Handle other options
                        //               }
                        //             });
                        //             BlocProvider.of<PatientsGetBloc>(context).add(
                        //                 FetchSortPatients(
                        //                     sort: dropdownValue,
                        //                     clinicId: dController.initialIndex!,
                        //                     fromDate: _startRange,
                        //                     toDate: _endRange));
                        //             // print(dropdownvalue);
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                // const VerticalSpacingWidget(height: 5),
            
                const VerticalSpacingWidget(height: 5),
                BlocBuilder<PatientsGetBloc, PatientsGetState>(
                  builder: (context, state) {
                    if (state is PatientsGetLoading) {
                      return SizedBox(
                        height: 400.h,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 7, // Choose a number of shimmer items
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80.w, // Adjust width as needed
                                      height: 80.h, // Adjust height as needed
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 16.h,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 5.h),
                                          Container(
                                            width: 150.w,
                                            // Adjust width as needed
                                            height: 12.h,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    if (state is PatientsGetError) {
                      return const Center(
                        child: Text("Something Went Wrong"),
                      );
                    }
                    if (state is PatientsGetLoaded) {
                      patientsGetModel = BlocProvider.of<PatientsGetBloc>(context)
                          .patientsGetModel;
                      if (patientsGetModel.patientData == null ||
                          patientsGetModel.patientData!.isEmpty) {
                        return Expanded(
                          child: Center(
                              child: Image(
                            height: 200.h,
                            width: 200.w,
                            // color: kMainColor,
                            image: const AssetImage(
                                "assets/images/You ahve no patients-01.png"),
                            color: kMainColor,
                          )),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              "Patient Count (${patientsGetModel.patientData!.length.toString()})",
                              style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 11.sp),
                            ),
                          ),
                          SizedBox(
                            height: 440.h,
                            // color: Colors.yellow,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: patientsGetModel.patientData!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const VerticalSpacingWidget(height: 3),
                              itemBuilder: (context, index) {
                                return PatientsCardWidget(
                                  patientId: patientsGetModel
                                      .patientData![index].id
                                      .toString(),
                                  userId: patientsGetModel
                                      .patientData![index].userId
                                      .toString(),
                                  patientName: patientsGetModel
                                      .patientData![index].firstname
                                      .toString(),
                                  age: patientsGetModel
                                      .patientData![index].displayAge
                                      .toString(),
                                  gender: patientsGetModel
                                      .patientData![index].gender
                                      .toString(),
                                  userImage: patientsGetModel
                                              .patientData![index].userImage ==
                                          null
                                      ? ""
                                      : patientsGetModel
                                          .patientData![index].userImage
                                          .toString(),
                                  mediezyPatientId: patientsGetModel
                                      .patientData![index].mediezyPatientId
                                      .toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          )),
    );
  }

  //date picker alertDialog

  Future<void> _showCustomAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: SizedBox(
              height: 240.h,
              width: 500.w,
              child: Column(
                children: [
                  SfDateRangePicker(
                    todayHighlightColor: kMainColor,
                    selectionColor: kMainColor,
                    startRangeSelectionColor: kMainColor,
                    endRangeSelectionColor: kMainColor,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<PatientsGetBloc>(context).add(FetchSortPatients(
                    sort: "Custom",
                    clinicId: dController.initialIndex!,
                    fromDate: _startRange,
                    toDate: _endRange));
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // datepicker

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        DateTime startDate = args.value.startDate;
        DateTime endDate = args.value.endDate ?? args.value.startDate;

        _startRange = DateFormat('yyyy-MM-dd').format(startDate);
        _endRange = DateFormat('yyyy-MM-dd').format(endDate);
      }
    });
  }
}
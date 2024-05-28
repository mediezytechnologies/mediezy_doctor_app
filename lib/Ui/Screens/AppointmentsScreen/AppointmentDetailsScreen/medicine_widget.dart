// import 'dart:developer';

<<<<<<< Updated upstream
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:mediezy_doctor/Model/appointment_demo_model.dart';
// import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/DeleteMedicine/delete_medicine_bloc.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/EditMedicine/edit_medicine_bloc.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAppointmentDetailsPage/get_appointments_bloc.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/get_all_medicines_bloc.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
// import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/medicine_search_widget.dart';
// import 'package:mediezy_doctor/Ui/Services/general_services.dart';

// class MedicineWidget extends StatefulWidget {
//   const MedicineWidget({
//     super.key,
//     required this.tokenId,
//     required this.medicalStoreId,
//     this.medicine,
//     this.bookingData,
//     required this.bookedPersonId,
//   });
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Model/appointment_demo_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/DeleteMedicine/delete_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/EditMedicine/edit_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/get_all_medicines_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/medicine_search_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

import '../../../../Repositary/Bloc/GetAppointments/bloc/appointments_demo_bloc_bloc.dart';

class MedicineWidget extends StatefulWidget {
  const MedicineWidget({
    super.key,
    required this.tokenId,
    required this.medicalStoreId,
    this.medicine,
    this.bookingData,
    required this.bookedPersonId,
  });
>>>>>>> Stashed changes

//   final String tokenId;
//   final String medicalStoreId;
//   final List<Medicine>? medicine;
//   final List<BookingData>? bookingData;
//   final String bookedPersonId;

//   @override
//   State<MedicineWidget> createState() => _MedicineWidgetState();
// }

// class _MedicineWidgetState extends State<MedicineWidget> {
//   final TextEditingController medicineNameController = TextEditingController();
//   final TextEditingController dosageController = TextEditingController();
//   final TextEditingController daysController = TextEditingController();
//   final TextEditingController days1Controller = TextEditingController();
//   final TextEditingController hourlyController = TextEditingController();

//   TextEditingController myController = TextEditingController();

//   String? _selectedMedicineId;

//   void handleMedicineSelection(
//       String selectedMedicine, String selectedMedicineId) {
//     setState(() {
//       medicineNameController.text = selectedMedicine;
//       _selectedMedicineId = selectedMedicineId;
//     });
//   }

//   String dropdownHourlyValue = 'Hour interval';
//   var itemsHourly = [
//     'Hour interval',
//     'Day interval',
//     'Week interval',
//     'Month interval',
//   ];

<<<<<<< Updated upstream
//   String dropdownvalue = 'After Food';
//   var items = [
//     'After Food',
//     'Before Food',
//     'With Food',
//   ];
//   String passingFood = "1";

//   int editingMedicineIndex = -1;
//   var timeItems = ['1', '2', '3'];
//   bool morningValue = false;
//   String mrngStringValue = '0';
//   bool noonValue = false;
//   String noonStringValue = '0';
//   bool nightValue = false;
//   bool eveningValue = false;
//   String nightStringValue = '0';
//   String eveningStringValue = '0';
//   int medicineCount = 0;
//   var selectedItem = '';
//   String dropdownCheck = "1";
//   String selectedTime = "";
=======
  //String dropdownvalue = 'After Food';
  // var items = [
  //   'After Food',
  //   'Before Food',
  //   'With Food',
  // ];

  int editingMedicineIndex = -1;

  var timeItems = ['1', '2', '3'];
  bool morningValue = false;

  int medicineCount = 0;
  var selectedItem = '';
  String dropdownCheck = "1";
  String selectedTime = "";
>>>>>>> Stashed changes

//   String _medicineId = "";

//   String searchText = '';

<<<<<<< Updated upstream
//   final HospitalController controller = Get.put(HospitalController());
=======
  final HospitalController controller = Get.put(HospitalController());
  final FoodDropdownController foodDropdownController =
      Get.put(FoodDropdownController());
>>>>>>> Stashed changes

//   @override
//   void initState() {
//     BlocProvider.of<GetAllMedicinesBloc>(context)
//         .add(FetchMedicines(searchQuery: ""));
//     super.initState();
//   }

<<<<<<< Updated upstream
//   @override
//   void dispose() {
//     super.dispose();
//     passingFood;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     // log("${widget.medicalStoreId}");
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       // const VerticalSpacingWidget(height: 5),
//       widget.medicine!.isEmpty
//           ? Container()
//           : Text(
//               'All Prescriptions',
//               style: size.width > 450 ? greyTabMain : greyMain,
//             ),
//       // const VerticalSpacingWidget(height: 5),
//       ListView.builder(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: widget.medicine!.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 2.h),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   color: kCardColor, borderRadius: BorderRadius.circular(10)),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ShortNamesWidget(
//                           firstText: "Medicine : ",
//                           secondText:
//                               widget.medicine![index].medicineName.toString(),
//                         ),
//                         ShortNamesWidget(
//                           firstText: "Dosage : ",
//                           secondText: widget.medicine![index].dosage.toString(),
//                         ),
//                         widget.medicine![index].interval == null ||
//                                 widget.medicine![index].interval == "null"
//                             ? Container()
//                             : ShortNamesWidget(
//                                 firstText: "Interval : ",
//                                 secondText:
//                                     "${widget.medicine![index].interval.toString()} ${widget.medicine![index].timeSection.toString()}",
//                               ),
//                         ShortNamesWidget(
//                           firstText: "Days : ",
//                           secondText:
//                               widget.medicine![index].noOfDays.toString(),
//                         ),
//                         const VerticalSpacingWidget(height: 5),
//                         ShortNamesWidget(
//                           firstText: "",
//                           secondText: widget.medicine![index].type == 1
//                               ? "After Food"
//                               : widget.medicine![index].type == 2
//                                   ? "Before Food"
//                                   : "With Food",
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 if (widget.medicine![index].morning == 1)
//                                   Text(
//                                     "Morning",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].morning == 1 &&
//                                     (widget.medicine![index].noon == 1 ||
//                                         widget.medicine![index].evening == 1 ||
//                                         widget.medicine![index].night == 1))
//                                   Text(
//                                     ",",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].noon == 1)
//                                   Text(
//                                     "Noon",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].noon == 1 &&
//                                     (widget.medicine![index].evening == 1 ||
//                                         widget.medicine![index].night == 1))
//                                   Text(
//                                     ",",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].evening == 1)
//                                   Text(
//                                     "Evening",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].evening == 1 &&
//                                     widget.medicine![index].night == 1)
//                                   Text(
//                                     ",",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                                 if (widget.medicine![index].night == 1)
//                                   Text(
//                                     "Night",
//                                     style: size.width > 450
//                                         ? blackTabMainText
//                                         : blackMainText,
//                                   ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Column(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         PopupMenuButton(
//                           iconSize: size.width > 450 ? 14.sp : 20.sp,
//                           icon: Icon(
//                             Icons.more_vert,
//                             color: kMainColor,
//                           ),
//                           itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
//                             PopupMenuItem(
//                               onTap: () {
//                                 setState(() {
//                                   editingMedicineIndex = index;
//                                 });

//                                 if (widget.bookingData != null &&
//                                     index < widget.medicine!.length) {
//                                   medicineNameController.text = widget
//                                       .medicine![index].medicineName
//                                       .toString();
//                                   dosageController.text =
//                                       widget.medicine![index].dosage.toString();
//                                   daysController.text = widget
//                                       .medicine![index].noOfDays
//                                       .toString();
//                                   days1Controller.text = widget
//                                       .medicine![index].interval
//                                       .toString();
//                                   final medicineId =
//                                       widget.medicine![index].id.toString();

//                                   // Update dropdown value based on type
//                                   String type =
//                                       widget.medicine![index].type.toString();
//                                   dropdownvalue = type == "1"
//                                       ? "After Food"
//                                       : dropdownvalue = type == "2"
//                                           ? "Before Food"
//                                           : "With Food";
//                                   passingFood = type;
=======
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // log("${widget.medicalStoreId}");
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // const VerticalSpacingWidget(height: 5),
      widget.medicine!.isEmpty
          ? Container()
          : Text(
              'All Prescriptions',
              style: size.width > 450 ? greyTabMain : greyMain,
            ),
      // const VerticalSpacingWidget(height: 5),
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.medicine!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: kCardColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ShortNamesWidget(
                          firstText: "Medicine : ",
                          secondText:
                              widget.medicine![index].medicineName.toString(),
                        ),
                        ShortNamesWidget(
                          firstText: "Dosage : ",
                          secondText: widget.medicine![index].dosage.toString(),
                        ),
                        widget.medicine![index].interval == null ||
                                widget.medicine![index].interval == "null"
                            ? Container()
                            : ShortNamesWidget(
                                firstText: "Interval : ",
                                secondText:
                                    "${widget.medicine![index].interval.toString()} ${widget.medicine![index].timeSection.toString()}",
                              ),
                        ShortNamesWidget(
                          firstText: "Days : ",
                          secondText:
                              widget.medicine![index].noOfDays.toString(),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        ShortNamesWidget(
                          firstText: "",
                          secondText: widget.medicine![index].type == 1
                              ? "After Food"
                              : widget.medicine![index].type == 2
                                  ? "Before Food"
                                  : widget.medicine![index].type == 3
                                      ? "With Food"
                                      : 'If Required',
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (widget.medicine![index].morning == 1)
                                  Text(
                                    "Morning",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].morning == 1 &&
                                    (widget.medicine![index].noon == 1 ||
                                        widget.medicine![index].evening == 1 ||
                                        widget.medicine![index].night == 1))
                                  Text(
                                    ",",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].noon == 1)
                                  Text(
                                    "Noon",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].noon == 1 &&
                                    (widget.medicine![index].evening == 1 ||
                                        widget.medicine![index].night == 1))
                                  Text(
                                    ",",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].evening == 1)
                                  Text(
                                    "Evening",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].evening == 1 &&
                                    widget.medicine![index].night == 1)
                                  Text(
                                    ",",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                                if (widget.medicine![index].night == 1)
                                  Text(
                                    "Night",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PopupMenuButton(
                          iconSize: size.width > 450 ? 14.sp : 20.sp,
                          icon: Icon(
                            Icons.more_vert,
                            color: kMainColor,
                          ),
                          itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  editingMedicineIndex = index;
                                  foodDropdownController.isEdit.value = true;
                                  log("index =========>>>>$editingMedicineIndex");
                                });

                                if (widget.bookingData != null &&
                                    index < widget.medicine!.length) {
                                  var medicine = widget.medicine![index];
                                  medicineNameController.text = widget
                                      .medicine![index].medicineName
                                      .toString();
                                  dosageController.text =
                                      widget.medicine![index].dosage.toString();
                                  daysController.text = widget
                                      .medicine![index].noOfDays
                                      .toString();
                                  days1Controller.text = widget
                                      .medicine![index].interval
                                      .toString();

                                  final medicineId =
                                      widget.medicine![index].id.toString();
                                  foodDropdownController.toggleEdit(
                                      "Morning", medicine.morning!);
                                  foodDropdownController.toggleEdit(
                                      "Noon", medicine.noon!);
                                  foodDropdownController.toggleEdit(
                                      "Evening", medicine.evening!);
                                  foodDropdownController.toggleEdit(
                                      "Night", medicine.night!);

                                  foodDropdownController
                                      .dropdownEdit(medicine.type.toString());
                                  dropdownHourlyValue =
                                      medicine.timeSection.toString();

                                  // String type = medicine.type.toString();
                                  // foodDropdownController.dropdownEdit(type);
                                  // dropdownHourlyValue =
                                  //     medicine.timeSection.toString();

                                  // dropdownvalue = type == "1"
                                  //     ? "After Food"
                                  //     : dropdownvalue = type == "2"
                                  //         ? "Before Food"
                                  //         : "With Food";
                                  // passingFood = type;
                                  //  log("food type ===========$type");
>>>>>>> Stashed changes

//                                   String typeInterval = widget
//                                       .medicine![index].timeSection
//                                       .toString();

//                                   dropdownHourlyValue = typeInterval;

<<<<<<< Updated upstream
//                                   // Update morning value based on type
//                                   String mrngType = widget
//                                       .medicine![index].morning
//                                       .toString();
//                                   morningValue = mrngType == "1" ? true : false;
//                                   mrngStringValue = mrngType;

//                                   // Update noon value based on type
//                                   String noonType =
//                                       widget.medicine![index].noon.toString();
//                                   noonValue = noonType == "1" ? true : false;
//                                   noonStringValue = noonType;

//                                   // Update evening value based on type
//                                   String evngType = widget
//                                       .medicine![index].evening
//                                       .toString();
//                                   eveningValue = evngType == "1" ? true : false;
//                                   eveningStringValue = evngType;

//                                   // Update morning value based on type
//                                   String nightType =
//                                       widget.medicine![index].night.toString();
//                                   nightValue = nightType == "1" ? true : false;
//                                   nightStringValue = nightType;

//                                   setState(() {
//                                     _medicineId = medicineId;
//                                   });
//                                 }
//                               },
//                               child: Text(
//                                 "Edit",
//                                 style: size.width > 450
//                                     ? blackTabMainText
//                                     : blackMainText,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             PopupMenuItem(
//                               onTap: () {
//                                 BlocProvider.of<DeleteMedicineBloc>(context)
//                                     .add(DeleteMedicine(
//                                         medicineId: widget.medicine![index].id
//                                             .toString()));
//                                 setState(() {
//                                   widget.medicine!.removeAt(index);
//                                 });
//                               },
//                               child: Text(
//                                 "Delete",
//                                 style: size.width > 450
//                                     ? blackTabMainText
//                                     : blackMainText,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       const VerticalSpacingWidget(height: 5),
//       Text(
//         'Add Prescription',
//         style: size.width > 450 ? greyTabMain : greyMain,
//       ),
//       const VerticalSpacingWidget(height: 10),
//       Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MedicineSearchWidget(
//                             onMedicineSelected: handleMedicineSelection,
//                             typeId: 0,
//                           ),
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       // height: 40.h,
//                       width: size.width > 450 ? 245.w : 235.w,
//                       child: TextFormField(
//                         style: TextStyle(
//                           color: Colors.black, // Set the text color to black
//                           fontSize: size.width > 450 ? 9.sp : 14.sp,
//                         ),
//                         cursorColor: kMainColor,
//                         controller: medicineNameController,
//                         onChanged: (newValue) {
//                           BlocProvider.of<GetAllMedicinesBloc>(context)
//                               .add(FetchMedicines(searchQuery: newValue));
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         enabled: false,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 10.h, horizontal: 2.w),
//                           hintStyle:
//                               size.width > 450 ? greyTab10B600 : grey13B600,
//                           hintText: "Medicine Name",
//                           filled: true,
//                           fillColor: kCardColor,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(4),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // );
//                   SizedBox(
//                     // height: 40.h,
//                     width: 90.w,
//                     child: TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       controller: dosageController,
//                       keyboardType: TextInputType.name,
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.h, horizontal: 2.w),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Dosage",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const VerticalSpacingWidget(height: 5),
//               Text(
//                 "E.g: 1 tab,3 drops,etc..",
//                 style: TextStyle(fontSize: 8.7.sp),
//               ),
//               size.width > 450
//                   ? const VerticalSpacingWidget(height: 5)
//                   : const VerticalSpacingWidget(height: 1),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         morningValue = !morningValue;

//                         if (morningValue == false) {
//                           mrngStringValue = '0';
//                         } else {
//                           mrngStringValue = '1';
//                         }
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                           child: Checkbox(
//                             materialTapTargetSize:
//                                 MaterialTapTargetSize.shrinkWrap,
//                             activeColor: kMainColor,
//                             value: morningValue,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 morningValue = newValue!;

//                                 if (morningValue == false) {
//                                   mrngStringValue = '0';
//                                 } else {
//                                   mrngStringValue = '1';
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         const HorizontalSpacingWidget(width: 7),
//                         Text(
//                           "Morning",
//                           style: TextStyle(
//                               fontSize: 12.sp, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         noonValue = !noonValue;

//                         if (noonValue == false) {
//                           noonStringValue = '0';
//                         } else {
//                           noonStringValue = '1';
//                         }
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                           child: Checkbox(
//                             activeColor: kMainColor,
//                             value: noonValue,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 noonValue = newValue!;

//                                 if (noonValue == false) {
//                                   noonStringValue = '0';
//                                 } else {
//                                   noonStringValue = '1';
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         const HorizontalSpacingWidget(width: 10),
//                         Text(
//                           "Noon",
//                           style: TextStyle(
//                               fontSize: 12.sp, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         eveningValue = !eveningValue;
//                         if (eveningValue == false) {
//                           eveningStringValue = '0';
//                         } else {
//                           eveningStringValue = '1';
//                         }
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                           child: Checkbox(
//                             activeColor: kMainColor,
//                             value: eveningValue,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 eveningValue = newValue!;
//                                 if (eveningValue == false) {
//                                   eveningStringValue = '0';
//                                 } else {
//                                   eveningStringValue = '1';
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         const HorizontalSpacingWidget(width: 10),
//                         Text(
//                           "Evening",
//                           style: TextStyle(
//                               fontSize: 12.sp, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         nightValue = !nightValue;
//                         if (nightValue == false) {
//                           nightStringValue = '0';
//                         } else {
//                           nightStringValue = '1';
//                         }
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10.w,
//                           child: Checkbox(
//                             activeColor: kMainColor,
//                             value: nightValue,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 nightValue = newValue!;
//                                 if (nightValue == false) {
//                                   nightStringValue = '0';
//                                 } else {
//                                   nightStringValue = '1';
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         const HorizontalSpacingWidget(width: 10),
//                         Text(
//                           "Night",
//                           style: TextStyle(
//                               fontSize: 12.sp, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               size.width > 450
//                   ? const VerticalSpacingWidget(height: 5)
//                   : const VerticalSpacingWidget(height: 1),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       addInterval(context);
//                     },
//                     child: Container(
//                       height: 40.h,
//                       width: 70.w,
//                       decoration: BoxDecoration(
//                         color: kCardColor,
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "More",
//                           style: size.width > 450
//                               ? blackTabMainText
//                               : blackMainText,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 40.h,
//                     width: size.width > 450 ? 170.w : 160.w,
//                     color: kCardColor,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.w),
//                       child: Center(
//                         child: DropdownButtonFormField(
//                           iconEnabledColor: kMainColor,
//                           decoration:
//                               const InputDecoration.collapsed(hintText: ''),
//                           value: dropdownvalue,
//                           style: size.width > 450
//                               ? blackTabMainText
//                               : blackMainText,
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           items: items.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(items),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               dropdownvalue = newValue!;
//                               passingFood = dropdownvalue == "After Food"
//                                   ? "1"
//                                   : dropdownvalue == "Before Food"
//                                       ? "2"
//                                       : "3";
//                               log(">???????????$passingFood");
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 40.h,
//                     width: 90.w,
//                     child: TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       controller: daysController,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.h, horizontal: 2.w),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Days",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   //! drop down before and after
//                 ],
//               ),
//               const VerticalSpacingWidget(height: 10),
//               //! select times
//               //! add
//               BlocListener<EditMedicineBloc, EditMedicineState>(
//                 listener: (context, state) {
//                   if (state is EditMedicineLoaded) {
//                     BlocProvider.of<GetAppointmentsBloc>(context).add(
//                         FetchAppointmentDetailsPage(tokenId: widget.tokenId));
//                     // Navigator.pushReplacement(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => AppointmentDetailsScreen(
//                     //             tokenId: widget.appointmentDetailsPageModel
//                     //                 .bookingData!.tokenId
//                     //                 .toString(),
//                     //             appointmentsDetails: const [],
//                     //             position: 0)));
//                   }
//                 },
//                 child: Row(
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // print(dropValueMedicalStore);
//                         if (medicineNameController.text.isEmpty) {
//                           GeneralServices.instance.showErrorMessage(
//                               context, "Please fill medicine name");
//                         } else if (dosageController.text.isEmpty) {
//                           GeneralServices.instance
//                               .showErrorMessage(context, "Please fill dosage");
//                         } else if (daysController.text.isEmpty) {
//                           GeneralServices.instance
//                               .showErrorMessage(context, "Please fill days");
//                         } else if (editingMedicineIndex != -1) {
//                           BlocProvider.of<EditMedicineBloc>(context).add(
//                             EditMedicine(
//                               medicineName: medicineNameController.text,
//                               medicineId: _medicineId,
//                               dosage: dosageController.text,
//                               noOfDays: daysController.text,
//                               type: passingFood,
//                               night: nightStringValue.toString(),
//                               morning: mrngStringValue.toString(),
//                               noon: noonStringValue.toString(),
//                               evening: eveningStringValue,
//                               timeSection: dropdownHourlyValue,
//                               interval: days1Controller.text,
//                             ),
//                           );
//                         } else {
//                           BlocProvider.of<AddPrescriptionBloc>(context).add(
//                             FetchAddPrescription(
//                               medicineName: medicineNameController.text,
//                               dosage: dosageController.text,
//                               noOfDays: daysController.text,
//                               type: passingFood,
//                               night: nightStringValue.toString(),
//                               morning: mrngStringValue.toString(),
//                               noon: noonStringValue.toString(),
//                               tokenId: widget.tokenId.toString(),
//                               bookedPersonId: widget.bookedPersonId.toString(),
//                               evening: eveningStringValue,
//                               medicalStoreId: widget.medicalStoreId,
//                               timeSection: dropdownHourlyValue,
//                               interval: days1Controller.text,
//                               medicineId: _selectedMedicineId!,
//                             ),
//                           );
//                         }
//                         medicineNameController.clear();
//                         daysController.clear();
//                         days1Controller.clear();
//                         dosageController.clear();
//                       },
//                       child: Container(
//                         height: 45.h,
//                         width: 200.w,
//                         decoration: BoxDecoration(
//                           color: kMainColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             editingMedicineIndex != -1 ? "UPDATE" : "ADD",
//                             style: size.width > 450
//                                 ? TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold)
//                                 : TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
=======
                                  setState(() {
                                    _medicineId = medicineId;
                                  });
                                }
                              },
                              child: Text(
                                "Edit",
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                BlocProvider.of<DeleteMedicineBloc>(context)
                                    .add(DeleteMedicine(
                                        medicineId: widget.medicine![index].id
                                            .toString()));
                                setState(() {
                                  widget.medicine!.removeAt(index);
                                });
                              },
                              child: Text(
                                "Delete",
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      const VerticalSpacingWidget(height: 5),
      Text(
        'Add Prescription',
        style: size.width > 450 ? greyTabMain : greyMain,
      ),
      const VerticalSpacingWidget(height: 10),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineSearchWidget(
                            onMedicineSelected: handleMedicineSelection,
                            typeId: 0,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      // height: 40.h,
                      width: size.width > 450 ? 245.w : 235.w,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black, // Set the text color to black
                          fontSize: size.width > 450 ? 9.sp : 14.sp,
                        ),
                        cursorColor: kMainColor,
                        controller: medicineNameController,
                        onChanged: (newValue) {
                          BlocProvider.of<GetAllMedicinesBloc>(context)
                              .add(FetchMedicines(searchQuery: newValue));
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 2.w),
                          hintStyle:
                              size.width > 450 ? greyTab10B600 : grey13B600,
                          hintText: "Medicine Name",
                          filled: true,
                          fillColor: kCardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // );
                  SizedBox(
                    // height: 40.h,
                    width: 90.w,
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: dosageController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 2.w),
                        hintStyle:
                            size.width > 450 ? greyTab10B600 : grey13B600,
                        hintText: "Dosage",
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
              const VerticalSpacingWidget(height: 5),

              Text(
                "E.g: 1 tab,3 drops,etc..",
                style: TextStyle(fontSize: 8.7.sp),
              ),
              size.width > 450
                  ? const VerticalSpacingWidget(height: 5)
                  : const VerticalSpacingWidget(height: 1),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    checkboxCustom(
                        'Morning',
                        foodDropdownController.morningCheckedValue.value == 0
                            ? Icons.square_outlined
                            : Icons.check_box),
                    checkboxCustom(
                        'Noon',
                        foodDropdownController.noonCheckedValue.value == 0
                            ? Icons.square_outlined
                            : Icons.check_box),
                    checkboxCustom(
                        'Evening',
                        foodDropdownController.evnigCheckedValue.value == 0
                            ? Icons.square_outlined
                            : Icons.check_box),
                    checkboxCustom(
                      'Night',
                      foodDropdownController.nightCheckedValue.value == 0
                          ? Icons.square_outlined
                          : Icons.check_box,
                    ),
                  ],
                );
              }),
              size.width > 450
                  ? const VerticalSpacingWidget(height: 5)
                  : const VerticalSpacingWidget(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      addInterval(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: kCardColor,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "More",
                          style: size.width > 450
                              ? blackTabMainText
                              : blackMainText,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return Container(
                      height: 40.h,
                      width: size.width > 450 ? 170.w : 160.w,
                      color: kCardColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Center(
                          child: DropdownButtonFormField(
                            iconEnabledColor: kMainColor,
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            value: foodDropdownController.foodValue.value,
                            style: size.width > 450
                                ? blackTabMainText
                                : blackMainText,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: foodDropdownController.foodData.map((entry) {
                              return DropdownMenuItem(
                                  value: entry.fodeId.toString(),
                                  child: Text(entry.foodeName));
                            }).toList(),
                            onChanged: (String? newValue) {
                              log(newValue!);

                              foodDropdownController.dropdownValueChanging(
                                  newValue, '1');

                              log("value =======================    ==== == = = $newValue");

                              // });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    // height: 40.h,
                    width: 90.w,
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: daysController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 2.w),
                        hintStyle:
                            size.width > 450 ? greyTab10B600 : grey13B600,
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
                  //! drop down before and after
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              //! select times
              //! add
              BlocListener<EditMedicineBloc, EditMedicineState>(
                listener: (context, state) {
                  if (state is EditMedicineLoaded) {
                    BlocProvider.of<AppointmentsDemoBlocBloc>(context)
                        .add(FetchAllAppointmentsDemo(
                      date: controller.formatDate(),
                      clinicId: controller.initialIndex!,
                      scheduleType: controller.scheduleIndex.value,
                    ));

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AppointmentDetailsScreen(
                    //             tokenId: widget.appointmentDetailsPageModel
                    //                 .bookingData!.tokenId
                    //                 .toString(),
                    //             appointmentsDetails: const [],
                    //             position: 0)));
                  }
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          // print(dropValueMedicalStore);
                          if (medicineNameController.text.isEmpty) {
                            GeneralServices.instance.showErrorMessage(
                                context, "Please fill medicine name");
                          } else if (dosageController.text.isEmpty) {
                            GeneralServices.instance.showErrorMessage(
                                context, "Please fill dosage");
                          } else if (daysController.text.isEmpty) {
                            GeneralServices.instance
                                .showErrorMessage(context, "Please fill days");
                          } else if (foodDropdownController.isEdit.value) {
                            BlocProvider.of<EditMedicineBloc>(context).add(
                              EditMedicine(
                                medicineName: medicineNameController.text,
                                medicineId: _medicineId,
                                dosage: dosageController.text,
                                noOfDays: daysController.text,
                                type: foodDropdownController.foodValue.value,
                                // passingFood,
                                night: foodDropdownController
                                    .nightCheckedValue.value
                                    .toString(),
                                morning: foodDropdownController
                                    .morningCheckedValue
                                    .toString(),
                                noon: foodDropdownController
                                    .noonCheckedValue.value
                                    .toString(),
                                evening: foodDropdownController
                                    .evnigCheckedValue.value
                                    .toString(),
                                timeSection: dropdownHourlyValue,
                                interval: days1Controller.text,
                              ),
                            );
                            // foodDropdownController.resetToPreviousValue();
                          } else {
                            BlocProvider.of<AddPrescriptionBloc>(context).add(
                              FetchAddPrescription(
                                medicineName: medicineNameController.text,
                                dosage: dosageController.text,
                                noOfDays: daysController.text,
                                type: foodDropdownController.foodValue.value,
                                //  type: passingFood,
                                night: foodDropdownController
                                    .nightCheckedValue.value
                                    .toString(),
                                morning: foodDropdownController
                                    .morningCheckedValue
                                    .toString(),
                                noon: foodDropdownController
                                    .noonCheckedValue.value
                                    .toString(),
                                evening: foodDropdownController
                                    .evnigCheckedValue.value
                                    .toString(),

                                tokenId: widget.tokenId.toString(),
                                bookedPersonId:
                                    widget.bookedPersonId.toString(),

                                medicalStoreId: widget.medicalStoreId,
                                timeSection: dropdownHourlyValue,
                                interval: days1Controller.text,
                                medicineId: _selectedMedicineId!,
                              ),
                            );
                          }
                          medicineNameController.clear();
                          daysController.clear();
                          days1Controller.clear();
                          dosageController.clear();

                          setState(() {
                            foodDropdownController.resetToInitialValue();
                            foodDropdownController.isEdit.value = false;
                          });
                        },
                        child: Container(
                          height: 45.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              foodDropdownController.isEdit.value
                                  ? "UPDATE"
                                  : "ADD",
                              style: size.width > 450
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
>>>>>>> Stashed changes

//       const VerticalSpacingWidget(height: 5),
//     ]);
//   }

<<<<<<< Updated upstream
//   Future<dynamic> addInterval(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: ((context) {
//         return AlertDialog(
//           backgroundColor: Theme.of(context).cardColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const VerticalSpacingWidget(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(color: const Color(0xFF9C9C9C))),
//                     height: size.height * 0.055,
//                     width: size.width * .17,
//                     child: TextFormField(
//                       style:
//                           TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
//                       cursorColor: kMainColor,
//                       controller: days1Controller,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.h, horizontal: 2.w),
//                         hintStyle:
//                             size.width > 450 ? greyTab10B600 : grey13B600,
//                         hintText: "Interval",
//                         filled: true,
//                         fillColor: kCardColor,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   CustomDropDown(
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownHourlyValue = newValue!;
//                         log(">???????????$dropdownHourlyValue");
//                       });
//                     },
//                     items: itemsHourly.map((String items) {
//                       return DropdownMenuItem(
//                         value: items,
//                         child: Text(items),
//                       );
//                     }).toList(),
//                     width: 150.w,
//                     value: dropdownHourlyValue,
//                   ),
//                 ],
//               ),
//               const VerticalSpacingWidget(height: 5),
//               Text(
//                 "E.g:- 8 hour interval",
//                 style: TextStyle(fontSize: 11.sp),
//               ),
//               const VerticalSpacingWidget(height: 5),
//               Container(
//                 height: size.height * 0.055,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(color: const Color(0xFF9C9C9C))),
//                 width: double.infinity,
//                 child: TextFormField(
//                   style: TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
//                   cursorColor: kMainColor,
//                   controller: dosageController,
//                   keyboardType: TextInputType.name,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
//                     hintStyle: size.width > 450 ? greyTab10B600 : grey13B600,
//                     hintText: "Dosage",
//                     filled: true,
//                     fillColor: kCardColor,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const VerticalSpacingWidget(height: 5),
//               Text(
//                 "E.g:- 1 tablet,2 puffs,3 drops,10 ml etc...",
//                 style: TextStyle(fontSize: 11.sp),
//               ),
//               const VerticalSpacingWidget(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "Cancel",
//                       style: size.width > 450
//                           ? TextStyle(fontSize: 9.sp)
//                           : TextStyle(fontSize: 12.sp),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "OK",
//                       style: size.width > 450
//                           ? TextStyle(fontSize: 9.sp)
//                           : TextStyle(fontSize: 12.sp),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   medicineNameController.dispose();
//   //   daysController.dispose();
//   //   // imageFromCamera?.dispose();
//   // }
// }
=======
  GestureDetector checkboxCustom(String checkingText, IconData iconData) {
    return GestureDetector(
        onTap: () {
          foodDropdownController.toggleChecking(checkingText);

          log("text check value ==== $checkingText");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: kMainColor,
            ),
            const HorizontalSpacingWidget(width: 7),
            Text(
              checkingText,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }

  Future<dynamic> addInterval(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF9C9C9C))),
                    height: size.height * 0.055,
                    width: size.width * .17,
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: days1Controller,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 2.w),
                        hintStyle:
                            size.width > 450 ? greyTab10B600 : grey13B600,
                        hintText: "Interval",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  CustomDropDown(
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownHourlyValue = newValue!;
                        log(">???????????$dropdownHourlyValue");
                      });
                    },
                    items: itemsHourly.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    width: 150.w,
                    value: dropdownHourlyValue,
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 5),
              Text(
                "E.g:- 8 hour interval",
                style: TextStyle(fontSize: 11.sp),
              ),
              const VerticalSpacingWidget(height: 5),
              Container(
                height: size.height * 0.055,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF9C9C9C))),
                width: double.infinity,
                child: TextFormField(
                  style: TextStyle(fontSize: size.width > 450 ? 9.sp : 14.sp),
                  cursorColor: kMainColor,
                  controller: dosageController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                    hintStyle: size.width > 450 ? greyTab10B600 : grey13B600,
                    hintText: "Dosage",
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
                "E.g:- 1 tablet,2 puffs,3 drops,10 ml etc...",
                style: TextStyle(fontSize: 11.sp),
              ),
              const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: size.width > 450
                          ? TextStyle(fontSize: 9.sp)
                          : TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: size.width > 450
                          ? TextStyle(fontSize: 9.sp)
                          : TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   medicineNameController.dispose();
  //   daysController.dispose();
  //   // imageFromCamera?.dispose();
  // }
}

class FoodDropdownController extends GetxController {
  var isEdit = false.obs;
  var foodValue = '1'.obs;
  var previousFoodValue = '1'.obs;
  var timeZoneId = "0".obs;

//TimezoneModel

  RxBool isCheckedmorning = false.obs;
  RxBool isCheckednoon = false.obs;
  RxBool isCheckedEvening = false.obs;
  RxBool isCheckedNight = false.obs;
  //
  RxInt morningCheckedValue = 0.obs;
  RxInt evnigCheckedValue = 0.obs;
  RxInt noonCheckedValue = 0.obs;
  RxInt nightCheckedValue = 0.obs;

  //privious//===

  var previousisCheckedmorning = false.obs;
  var previousisCheckednoon = false.obs;
  var previousisCheckedNight = false.obs;
  var previousisCheckedEvening = false.obs;

  var previousmorningCheckedValue = 0.obs;
  var previousevnigCheckedValue = 0.obs;
  var previousnoonCheckedValue = 0.obs;
  var previousnightCheckedValue = 0.obs;

  //
  List<FoodDropdowneModel> foodData = [
    FoodDropdowneModel(fodeId: '1', foodeName: 'After Food'),
    FoodDropdowneModel(fodeId: '2', foodeName: 'Before Food'),
    FoodDropdowneModel(fodeId: '3', foodeName: 'With Food'),
    FoodDropdowneModel(fodeId: '4', foodeName: 'If Required'),
  ];

  void toggleChecking(String checkingValue) {
    switch (checkingValue) {
      case 'Morning':
        isCheckedmorning.value = !isCheckedmorning.value;
        morningCheckedValue.value = isCheckedmorning.value ? 1 : 0;
        break;
      case 'Noon':
        isCheckednoon.value = !isCheckednoon.value;
        noonCheckedValue.value = isCheckednoon.value ? 1 : 0;
        break;
      case 'Evening':
        isCheckedEvening.value = !isCheckedEvening.value;
        evnigCheckedValue.value = isCheckedEvening.value ? 1 : 0;
        break;
      case 'Night':
        isCheckedNight.value = !isCheckedNight.value;
        nightCheckedValue.value = isCheckedNight.value ? 1 : 0;
        break;
    }
    update();
  }

  void toggleEdit(String checkingValue, int editValue) {
    switch (checkingValue) {
      case 'Morning':
        morningCheckedValue.value = editValue;
        isCheckedmorning.value = editValue == 1;
        break;
      case 'Noon':
        noonCheckedValue.value = editValue;
        isCheckednoon.value = editValue == 1;
        break;
      case 'Evening':
        evnigCheckedValue.value = editValue;
        isCheckedEvening.value = editValue == 1;
        break;
      case 'Night':
        nightCheckedValue.value = editValue;
        isCheckedNight.value = editValue == 1;
        break;
    }
    update();
  }

  dropdownValueChanging(String value, String checkingValue) {
    if (checkingValue == '1') {
      log("before  :: $foodValue");
      previousFoodValue.value = foodValue.value;
      foodValue.value = value;
      update();
    }
    update();
  }

  void dropdownEdit(String value) {
    previousFoodValue.value = value;
    foodValue.value = value;
    update();
  }

  void resetToInitialValue() {
    foodValue.value = '1';

    isCheckedmorning.value = false;
    isCheckednoon.value = false;
    isCheckedEvening.value = false;
    isCheckedNight.value = false;

    morningCheckedValue.value = 0;
    evnigCheckedValue.value = 0;
    noonCheckedValue.value = 0;
    nightCheckedValue.value = 0;

    update();
  }

  void setPreviousValues() {
    previousFoodValue.value = foodValue.value;
    previousisCheckedmorning.value = isCheckedmorning.value;
    previousisCheckednoon.value = isCheckednoon.value;
    previousisCheckedEvening.value = isCheckedEvening.value;
    previousisCheckedNight.value = isCheckedNight.value;

    previousmorningCheckedValue.value = morningCheckedValue.value;
    previousevnigCheckedValue.value = evnigCheckedValue.value;
    previousnoonCheckedValue.value = noonCheckedValue.value;
    previousnightCheckedValue.value = nightCheckedValue.value;
  }

  void resetToPreviousValue() {
    foodValue.value = previousFoodValue.value;

    isCheckedmorning.value = previousisCheckedmorning.value;
    isCheckednoon.value = previousisCheckednoon.value;
    isCheckedEvening.value = previousisCheckedEvening.value;
    isCheckedNight.value = previousisCheckedNight.value;

    morningCheckedValue.value = previousmorningCheckedValue.value;
    evnigCheckedValue.value = previousevnigCheckedValue.value;
    noonCheckedValue.value = previousnoonCheckedValue.value;
    nightCheckedValue.value = previousnightCheckedValue.value;

    update();
  }
}
>>>>>>> Stashed changes

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/DeleteMedicine/delete_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/EditMedicine/edit_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAppointmentDetailsPage/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class MedicineWidget extends StatefulWidget {
  const MedicineWidget({
    super.key,
    required this.tokenId,
    required this.appointmentDetailsPageModel,
    required this.medicalStoreId,
    // required this.medicalStoreId
  });

  final String tokenId;
  final String medicalStoreId;
  // final Function(String) onDropValueChanged;

  // final String medicalStoreId;
  final AppointmentDetailsPageModel appointmentDetailsPageModel;

  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController days1Controller = TextEditingController();
  final TextEditingController hourlyController = TextEditingController();

  String dropdownHourlyValue = 'Hour interval';
  var itemsHourly = [
    'Hour interval',
    'Day interval',
    'Week interval',
    'Month interval',
  ];

  String dropdownvalue = 'After Food';
  var items = [
    'After Food',
    'Before Food',
    'With Food',
  ];
  String passingFood = "1";

  int editingMedicineIndex = -1;
  var timeItems = ['1', '2', '3'];
  bool morningValue = false;
  String mrngStringValue = '0';
  bool noonValue = false;
  String noonStringValue = '0';
  bool nightValue = false;
  bool eveningValue = false;
  String nightStringValue = '0';
  String eveningStringValue = '0';
  int medicineCount = 0;
  var selectedItem = '';
  String dropdownCheck = "1";
  String selectedTime = "";

  String _medicineId = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log("${widget.medicalStoreId}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const VerticalSpacingWidget(height: 5),
        widget.appointmentDetailsPageModel.bookingData!.medicine!.isEmpty
            ? Container()
            : Text(
                'All Prescriptions',
                style: size.width > 400 ? greyTabMain : greyMain,
              ),
        // const VerticalSpacingWidget(height: 5),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              widget.appointmentDetailsPageModel.bookingData!.medicine!.length,
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
                            secondText: widget.appointmentDetailsPageModel
                                .bookingData!.medicine![index].medicineName
                                .toString(),
                          ),
                          ShortNamesWidget(
                            firstText: "Dosage : ",
                            secondText: widget.appointmentDetailsPageModel
                                .bookingData!.medicine![index].dosage
                                .toString(),
                          ),
                          ShortNamesWidget(
                            firstText: "Interval : ",
                            secondText:
                                "${widget.appointmentDetailsPageModel.bookingData!.medicine![index].interval.toString()} ${widget.appointmentDetailsPageModel.bookingData!.medicine![index].timeSection.toString()}",
                          ),
                          ShortNamesWidget(
                            firstText: "Days : ",
                            secondText: widget.appointmentDetailsPageModel
                                .bookingData!.medicine![index].noOfDays
                                .toString(),
                          ),
                          const VerticalSpacingWidget(height: 5),
                          ShortNamesWidget(
                            firstText: "",
                            secondText: widget.appointmentDetailsPageModel
                                        .bookingData!.medicine![index].type ==
                                    1
                                ? "After Food"
                                : widget
                                            .appointmentDetailsPageModel
                                            .bookingData!
                                            .medicine![index]
                                            .type ==
                                        2
                                    ? "Before Food"
                                    : "With Food",
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (widget
                                          .appointmentDetailsPageModel
                                          .bookingData!
                                          .medicine![index]
                                          .morning ==
                                      1)
                                    Text(
                                      "Morning",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget
                                              .appointmentDetailsPageModel
                                              .bookingData!
                                              .medicine![index]
                                              .morning ==
                                          1 &&
                                      (widget
                                                  .appointmentDetailsPageModel
                                                  .bookingData!
                                                  .medicine![index]
                                                  .noon ==
                                              1 ||
                                          widget
                                                  .appointmentDetailsPageModel
                                                  .bookingData!
                                                  .medicine![index]
                                                  .evening ==
                                              1 ||
                                          widget
                                                  .appointmentDetailsPageModel
                                                  .bookingData!
                                                  .medicine![index]
                                                  .night ==
                                              1))
                                    Text(
                                      ",",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget.appointmentDetailsPageModel
                                          .bookingData!.medicine![index].noon ==
                                      1)
                                    Text(
                                      "Noon",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget
                                              .appointmentDetailsPageModel
                                              .bookingData!
                                              .medicine![index]
                                              .noon ==
                                          1 &&
                                      (widget
                                                  .appointmentDetailsPageModel
                                                  .bookingData!
                                                  .medicine![index]
                                                  .evening ==
                                              1 ||
                                          widget
                                                  .appointmentDetailsPageModel
                                                  .bookingData!
                                                  .medicine![index]
                                                  .night ==
                                              1))
                                    Text(
                                      ",",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget
                                          .appointmentDetailsPageModel
                                          .bookingData!
                                          .medicine![index]
                                          .evening ==
                                      1)
                                    Text(
                                      "Evening",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget
                                              .appointmentDetailsPageModel
                                              .bookingData!
                                              .medicine![index]
                                              .evening ==
                                          1 &&
                                      widget
                                              .appointmentDetailsPageModel
                                              .bookingData!
                                              .medicine![index]
                                              .night ==
                                          1)
                                    Text(
                                      ",",
                                      style: size.width > 400
                                          ? blackTabMainText
                                          : blackMainText,
                                    ),
                                  if (widget
                                          .appointmentDetailsPageModel
                                          .bookingData!
                                          .medicine![index]
                                          .night ==
                                      1)
                                    Text(
                                      "Night",
                                      style: size.width > 400
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
                            iconSize: size.width > 400 ? 14.sp : 20.sp,
                            icon: Icon(
                              Icons.more_vert,
                              color: kMainColor,
                            ),
                            itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    editingMedicineIndex = index;
                                  });

                                  if (widget.appointmentDetailsPageModel
                                              .bookingData !=
                                          null &&
                                      index <
                                          widget.appointmentDetailsPageModel
                                              .bookingData!.medicine!.length) {
                                    medicineNameController.text = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .medicineName
                                        .toString();
                                    dosageController.text = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .dosage
                                        .toString();
                                    daysController.text = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .noOfDays
                                        .toString();
                                    days1Controller.text = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .interval
                                        .toString();
                                    final medicineId = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .id
                                        .toString();

                                    // Update dropdown value based on type
                                    String type = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .type
                                        .toString();
                                    dropdownvalue = type == "1"
                                        ? "After Food"
                                        : dropdownvalue = type == "2"
                                            ? "Before Food"
                                            : "With Food";
                                    passingFood = type;

                                    String typeInterval = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .timeSection
                                        .toString();

                                    dropdownHourlyValue = typeInterval;

                                    // Update morning value based on type
                                    String mrngType = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .morning
                                        .toString();
                                    morningValue =
                                        mrngType == "1" ? true : false;
                                    mrngStringValue = mrngType;

                                    // Update noon value based on type
                                    String noonType = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .noon
                                        .toString();
                                    noonValue = noonType == "1" ? true : false;
                                    noonStringValue = noonType;

                                    // Update evening value based on type
                                    String evngType = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .evening
                                        .toString();
                                    eveningValue =
                                        evngType == "1" ? true : false;
                                    eveningStringValue = evngType;

                                    // Update morning value based on type
                                    String nightType = widget
                                        .appointmentDetailsPageModel
                                        .bookingData!
                                        .medicine![index]
                                        .night
                                        .toString();
                                    nightValue =
                                        nightType == "1" ? true : false;
                                    nightStringValue = nightType;

                                    setState(() {
                                      _medicineId = medicineId;
                                    });
                                  }
                                },
                                child: Text(
                                  "Edit",
                                  style: size.width > 400
                                      ? blackTabMainText
                                      : blackMainText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  BlocProvider.of<DeleteMedicineBloc>(context)
                                      .add(DeleteMedicine(
                                          medicineId: widget
                                              .appointmentDetailsPageModel
                                              .bookingData!
                                              .medicine![index]
                                              .id
                                              .toString()));
                                  setState(() {
                                    widget.appointmentDetailsPageModel
                                        .bookingData!.medicine!
                                        .removeAt(index);
                                  });
                                },
                                child: Text(
                                  "Delete",
                                  style: size.width > 400
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
          style: size.width > 400 ? greyTabMain : greyMain,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: 40.h,
                      width: size.width > 400 ? 245.w : 235.w,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: size.width > 400 ? 9.sp : 14.sp),
                        cursorColor: kMainColor,
                        controller: medicineNameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 2.w),
                          hintStyle:
                              size.width > 400 ? greyTab10B600 : grey13B600,
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
                    SizedBox(
                      // height: 40.h,
                      width: 90.w,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: size.width > 400 ? 9.sp : 14.sp),
                        cursorColor: kMainColor,
                        controller: dosageController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 2.w),
                          hintStyle:
                              size.width > 400 ? greyTab10B600 : grey13B600,
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
                size.width > 400
                    ? const VerticalSpacingWidget(height: 5)
                    : const VerticalSpacingWidget(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          morningValue = !morningValue;

                          if (morningValue == false) {
                            mrngStringValue = '0';
                          } else {
                            mrngStringValue = '1';
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: kMainColor,
                              value: morningValue,
                              onChanged: (newValue) {
                                setState(() {
                                  morningValue = newValue!;

                                  if (morningValue == false) {
                                    mrngStringValue = '0';
                                  } else {
                                    mrngStringValue = '1';
                                  }
                                });
                              },
                            ),
                          ),
                          const HorizontalSpacingWidget(width: 7),
                          Text(
                            "Morning",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          noonValue = !noonValue;

                          if (noonValue == false) {
                            noonStringValue = '0';
                          } else {
                            noonStringValue = '1';
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: Checkbox(
                              activeColor: kMainColor,
                              value: noonValue,
                              onChanged: (newValue) {
                                setState(() {
                                  noonValue = newValue!;

                                  if (noonValue == false) {
                                    noonStringValue = '0';
                                  } else {
                                    noonStringValue = '1';
                                  }
                                });
                              },
                            ),
                          ),
                          const HorizontalSpacingWidget(width: 10),
                          Text(
                            "Noon",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          eveningValue = !eveningValue;
                          if (eveningValue == false) {
                            eveningStringValue = '0';
                          } else {
                            eveningStringValue = '1';
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: Checkbox(
                              activeColor: kMainColor,
                              value: eveningValue,
                              onChanged: (newValue) {
                                setState(() {
                                  eveningValue = newValue!;
                                  if (eveningValue == false) {
                                    eveningStringValue = '0';
                                  } else {
                                    eveningStringValue = '1';
                                  }
                                });
                              },
                            ),
                          ),
                          const HorizontalSpacingWidget(width: 10),
                          Text(
                            "Evening",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nightValue = !nightValue;
                          if (nightValue == false) {
                            nightStringValue = '0';
                          } else {
                            nightStringValue = '1';
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: Checkbox(
                              activeColor: kMainColor,
                              value: nightValue,
                              onChanged: (newValue) {
                                setState(() {
                                  nightValue = newValue!;
                                  if (nightValue == false) {
                                    nightStringValue = '0';
                                  } else {
                                    nightStringValue = '1';
                                  }
                                });
                              },
                            ),
                          ),
                          const HorizontalSpacingWidget(width: 10),
                          Text(
                            "Night",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                size.width > 400
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
                            style: size.width > 400
                                ? blackTabMainText
                                : blackMainText,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      width: size.width > 400 ? 170.w : 160.w,
                      color: kCardColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Center(
                          child: DropdownButtonFormField(
                            iconEnabledColor: kMainColor,
                            decoration:
                                const InputDecoration.collapsed(hintText: ''),
                            value: dropdownvalue,
                            style: size.width > 400
                                ? blackTabMainText
                                : blackMainText,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                passingFood = dropdownvalue == "After Food"
                                    ? "1"
                                    : dropdownvalue == "Before Food"
                                        ? "2"
                                        : "3";
                                print(">???????????$passingFood");
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 40.h,
                      width: 90.w,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: size.width > 400 ? 9.sp : 14.sp),
                        cursorColor: kMainColor,
                        controller: daysController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 2.w),
                          hintStyle:
                              size.width > 400 ? greyTab10B600 : grey13B600,
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
                      BlocProvider.of<GetAppointmentsBloc>(context).add(
                          FetchAppointmentDetailsPage(tokenId: widget.tokenId));
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
                      InkWell(
                        onTap: () {
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
                          } else if (editingMedicineIndex != -1) {
                            BlocProvider.of<EditMedicineBloc>(context).add(
                              EditMedicine(
                                medicineName: medicineNameController.text,
                                medicineId: _medicineId,
                                dosage: dosageController.text,
                                noOfDays: daysController.text,
                                type: passingFood,
                                night: nightStringValue.toString(),
                                morning: mrngStringValue.toString(),
                                noon: noonStringValue.toString(),
                                evening: eveningStringValue,
                                timeSection: dropdownHourlyValue,
                                interval: days1Controller.text,
                              ),
                            );
                          } else {
                            BlocProvider.of<AddPrescriptionBloc>(context).add(
                              FetchAddPrescription(
                                medicineName: medicineNameController.text,
                                dosage: dosageController.text,
                                noOfDays: daysController.text,
                                type: passingFood,
                                night: nightStringValue.toString(),
                                morning: mrngStringValue.toString(),
                                noon: noonStringValue.toString(),
                                tokenId: widget.appointmentDetailsPageModel
                                    .bookingData!.tokenId
                                    .toString(),
                                bookedPersonId: widget
                                    .appointmentDetailsPageModel
                                    .bookingData!
                                    .bookedPersonId
                                    .toString(),
                                evening: eveningStringValue,
                                medicalStoreId: widget.medicalStoreId,
                                timeSection: dropdownHourlyValue,
                                interval: days1Controller.text,
                              ),
                            );
                          }
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
                              editingMedicineIndex != -1 ? "UPDATE" : "ADD",
                              style: size.width > 400
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalSpacingWidget(height: 5),
      ],
    );
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // height: 40.h,
                    width: 60.w,
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: size.width > 400 ? 9.sp : 14.sp),
                      cursorColor: kMainColor,
                      controller: days1Controller,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 2.w),
                        hintStyle:
                            size.width > 400 ? greyTab10B600 : grey13B600,
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
                        print(">???????????$dropdownHourlyValue");
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
              SizedBox(
                // height: 40.h,
                width: double.infinity,
                child: TextFormField(
                  style: TextStyle(fontSize: size.width > 400 ? 9.sp : 14.sp),
                  cursorColor: kMainColor,
                  controller: dosageController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
                    hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
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
                      style: size.width > 400
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
                      style: size.width > 400
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

  @override
  void dispose() {
    super.dispose();
    medicineNameController.dispose();
    daysController.dispose();
    // imageFromCamera?.dispose();
  }
}

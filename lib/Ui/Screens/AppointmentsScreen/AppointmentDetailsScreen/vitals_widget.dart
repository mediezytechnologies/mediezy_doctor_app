import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import '../../../../Repositary/getx/get_appointment_getx.dart';
import '../../../Services/general_services.dart';

class VitalsWidget extends StatefulWidget {
  const VitalsWidget({
    super.key,
    required this.tokenId,
    this.vitals,
    this.bookingData,
  });

  final String tokenId;
  final Vitals? vitals;
  final List<BookingData>? bookingData;

  @override
  State<VitalsWidget> createState() => _VitalsWidgetState();
}

class _VitalsWidgetState extends State<VitalsWidget> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController sysController = TextEditingController();
  final TextEditingController diaController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();

  final HospitalController controller = Get.put(HospitalController());

  final getAllAppointmentController = Get.put(GetAllAppointmentController());

  String dropdownVitalsValue = 'F';
  var vitalItems = [
    'F',
    'C',
  ];

  String vitalsType = "1";

  //int editingVitalsIndex = -1;
  bool isEdit = false;
  bool showSecondContainer = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: kCardColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Vitals',
                style: size.width > 450 ? blackTabMainText : blackMainText,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      showSecondContainer =
                          !showSecondContainer; // Toggle visibility
                    });
                  },
                  icon: Icon(
                      showSecondContainer
                          ? CupertinoIcons.arrowtriangle_up_circle_fill
                          : CupertinoIcons.arrowtriangle_down_circle_fill,
                      size: size.width > 450 ? 12.sp : 18.sp))
            ],
          ),
        ),
        const VerticalSpacingWidget(height: 5),
        Visibility(
          visible: showSecondContainer,
          child: Container(
            height: 260.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            // color: Colors.yellow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ht",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              maxLength: 3,
                              style: TextStyle(
                                  fontSize: size.width > 450 ? 9.sp : 14.sp),
                              cursorColor: kMainColor,
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                hintStyle: size.width > 450
                                    ? greyTab10B600
                                    : grey13B600,
                                hintText: "Height",
                                counterText: "",
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
                      const HorizontalSpacingWidget(width: 20),
                      Text(
                        "cms",
                        style: size.width > 450
                            ? blackTab14B500
                            : TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                      const HorizontalSpacingWidget(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wt",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              maxLength: 3,
                              style: TextStyle(
                                  fontSize: size.width > 450 ? 9.sp : 14.sp),
                              cursorColor: kMainColor,
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                hintStyle: size.width > 450
                                    ? greyTab10B600
                                    : grey13B600,
                                hintText: "Weight",
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
                      const HorizontalSpacingWidget(width: 20),
                      Text(
                        "kg",
                        style: size.width > 450
                            ? blackTab14B500
                            : TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: TextFormField(
                          maxLength: 4,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 9.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: temperatureController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            hintText: "Temperature",
                            counterText: "",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      Container(
                        height: size.width > 450 ? 35.h : 42.h,
                        width: 70.w,
                        color: kCardColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Center(
                            child: DropdownButtonFormField(
                              iconEnabledColor: kMainColor,
                              decoration:
                                  const InputDecoration.collapsed(hintText: ''),
                              value: dropdownVitalsValue,
                              style: size.width > 450
                                  ? blackTabMainText
                                  : blackMainText,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: vitalItems.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownVitalsValue = newValue!;
                                  vitalsType =
                                      dropdownVitalsValue == "F" ? "1" : "2";
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SpO2",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          SizedBox(
                            width: 135.w,
                            child: TextFormField(
                              maxLength: 3,
                              style: TextStyle(
                                  fontSize: size.width > 450 ? 9.sp : 14.sp),
                              cursorColor: kMainColor,
                              controller: spo2Controller,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                counterText: "",
                                hintStyle: size.width > 450
                                    ? greyTab10B600
                                    : grey13B600,
                                hintText: 'SpO2',
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
                    ],
                  ),
                  const VerticalSpacingWidget(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "BP",
                        style: size.width > 450
                            ? blackTab14B500
                            : TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      SizedBox(
                        width: 70.w,
                        child: TextFormField(
                          maxLength: 3,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 9.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: sysController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            counterText: "",
                            hintText: "sys",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      Text(
                        "/",
                        style: size.width > 450
                            ? TextStyle(color: Colors.grey, fontSize: 15.sp)
                            : TextStyle(color: Colors.grey, fontSize: 25.sp),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      SizedBox(
                        width: 70.w,
                        child: TextFormField(
                          maxLength: 3,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 9.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: diaController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            counterText: "",
                            hintText: "dia",
                            filled: true,
                            fillColor: kCardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      SizedBox(
                        width: 110.w,
                        child: TextFormField(
                          maxLength: 3,
                          style: TextStyle(
                              fontSize: size.width > 450 ? 9.sp : 14.sp),
                          cursorColor: kMainColor,
                          controller: heartRateController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle:
                                size.width > 450 ? greyTab10B600 : grey13B600,
                            hintText: "Heart rate",
                            counterText: "",
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
                  const VerticalSpacingWidget(height: 15),
                  InkWell(
                    onTap: () {
                      double heightValue,
                          weightValue,
                          tempValue,
                          spValue,
                          sysValue,
                          diatValue,
                          heartValue;

                      bool isValid = true;
                      List<String> errorMessages = [];

                      //height
                      try {
                        heightValue = double.parse(heightController.text);
                        if (heightValue > 250) {
                          errorMessages.add(
                              "Height is greater than 250cm please re-check");

                          isValid = false;
                        }
                      } catch (e) {
                        heightValue = 0;
                      }

                      //weight
                      try {
                        weightValue = double.parse(weightController.text);
                        if (weightValue > 250) {
                          errorMessages.add(
                              "Weight is greater than 250kg please re-check");

                          isValid = false;
                        }
                      } catch (e) {
                        weightValue = 0;
                      }
                      //temp

                      try {
                        tempValue = double.parse(temperatureController.text);
                        // if (tempValue==0) {
                        //   errorMessages.add("pleas enter Temperature");
                        // } else

                        if (dropdownVitalsValue == "F") {
                          if (tempValue > 120) {
                            errorMessages.add(
                                "Temperature is greater than 120°F please re-check");
                            isValid = false;
                          } else if (tempValue < 90) {
                            errorMessages.add(
                                "Temperature is less than 90°F please re-check");
                            isValid = false;
                          }
                        } else if (dropdownVitalsValue == "C") {
                          if (tempValue > 48) {
                            errorMessages.add(
                                "Temperature is greater than 48°C please re-check");
                            isValid = false;
                          } else if (tempValue < 32) {
                            errorMessages.add(
                                "Temperature is less than 32°C please re-check");
                            isValid = false;
                          }
                        }
                      } catch (e) {
                        tempValue = 0;
                      }
                      //sp02

                      try {
                        spValue = double.parse(spo2Controller.text);
                        if (spValue > 100) {
                          errorMessages
                              .add("SPO2 is greater than 100% please re-check");
                          isValid = false;
                        } else if (spValue < 80) {
                          errorMessages
                              .add("SPO2 is less than 80% please re-check");
                          isValid = false;
                        }
                      } catch (e) {
                        spValue = 0;
                      }

                      //bp sys
                      try {
                        sysValue = double.parse(sysController.text);
                        if (sysValue > 250) {
                          errorMessages
                              .add("Sys is greater than 250 please re-check");
                          isValid = false;
                        } else if (sysValue < 80) {
                          errorMessages
                              .add("Sys is less than 80 please re-check");
                          isValid = false;
                        }
                      } catch (e) {
                        sysValue = 0;
                      }

                      //bp dia
                      try {
                        diatValue = double.parse(diaController.text);
                        if (diatValue > 180) {
                          errorMessages
                              .add("Dia is greater than 180 please re-check");
                          isValid = false;
                        } else if (diatValue < 40) {
                          errorMessages
                              .add("Dia is less than 40 please re-check");
                          isValid = false;
                        }
                      } catch (e) {
                        diatValue = 0;
                      }

                      //heart rate
                      try {
                        heartValue = double.parse(heartRateController.text);
                        if (heartValue > 250) {
                          errorMessages.add(
                              "Heart rate is greater than 250 please re-check");
                          isValid = false;
                        } else if (heartValue < 30) {
                          errorMessages.add(
                              "Heart rate is less than 30 please re-check");
                          isValid = false;
                        }
                      } catch (e) {
                        heartValue = 0;
                      }

                      if (isValid) {
                        showSecondContainer = false;
                        if (isEdit) {
                          log('editValue  $isEdit');
                          BlocProvider.of<AddVitalsBloc>(context).add(
                              EditVitals(
                                  height: heightController.text,
                                  weight: weightController.text,
                                  temperature: temperatureController.text,
                                  spo2: spo2Controller.text,
                                  sys: sysController.text,
                                  dia: diaController.text,
                                  heartRate: heartRateController.text,
                                  tokenId: widget.tokenId,
                                  temperatureType: dropdownVitalsValue));
                          heightController.clear();
                          weightController.clear();
                          temperatureController.clear();
                          spo2Controller.clear();
                          sysController.clear();
                          diaController.clear();
                          heartRateController.clear();
                          getAllAppointmentController
                              .getAllAppointmentGetxController(
                            date: controller.formatDate(),
                            clinicId: controller.initialIndex.value,
                            scheduleType: controller.scheduleIndex.value,
                          );
                          setState(() {
                            isEdit = false;
                          });
                        } else {
                          log('editValue  $isEdit');
                          BlocProvider.of<AddVitalsBloc>(context).add(AddVitals(
                              height: heightController.text,
                              weight: weightController.text,
                              temperature: temperatureController.text,
                              spo2: spo2Controller.text,
                              sys: sysController.text,
                              dia: diaController.text,
                              heartRate: heartRateController.text,
                              tokenId: widget.tokenId,
                              temperatureType: dropdownVitalsValue));
                          heightController.clear();
                          weightController.clear();
                          temperatureController.clear();
                          spo2Controller.clear();
                          sysController.clear();
                          diaController.clear();
                          heartRateController.clear();
                          setState(() {
                            isEdit = false;
                          });
                        }
                      } else {
                        GeneralServices.instance
                            .showErrorMessage(context, errorMessages[0]);
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
                          isEdit == true ? "Update" : "Save",
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
                  )
                ],
              ),
            ),
          ),
        ),
        widget.vitals == null
            ? Container()
            : const VerticalSpacingWidget(height: 5),
        // if (isSecondContainerVisible)
        widget.vitals == null
            ? Container()
            : Text(
                'Added Vitals',
                style: size.width > 450 ? greyTabMain : greyMain,
              ),
        // const VerticalSpacingWidget(height: 5),
        widget.vitals == null
            ? Container()
            : Container(
                height: 100.h,
                // padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: kCardColor, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ShortNamesWidget(
                          typeId: 1,
                          firstText: "Height : ",
                          secondText: widget.vitals!.height == null
                              ? "N/A"
                              : "${widget.vitals!.height.toString()} cm",
                        ),
                        ShortNamesWidget(
                          typeId: 1,
                          firstText: "Temperature : ",
                          secondText: widget.vitals!.temperature == null
                              ? "N/A"
                              : "${widget.vitals!.temperature.toString()} °${widget.vitals!.temperatureType.toString()}",
                        ),
                        ShortNamesWidget(
                          typeId: 1,
                          firstText: "BP : ",
                          secondText:
                              "${widget.vitals!.sys == null ? "N/A" : widget.vitals!.sys.toString()} / ${widget.vitals!.dia == null ? "N/A" : widget.vitals!.dia.toString()}",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ShortNamesWidget(
                          typeId: 1,
                          firstText: "Weight : ",
                          secondText: widget.vitals!.weight == null
                              ? "N/A"
                              : "${widget.vitals!.weight.toString()} Kg",
                        ),
                        ShortNamesWidget(
                            typeId: 1,
                            firstText: "spo2 : ",
                            secondText:
                                "${widget.vitals!.spo2 == null ? "N/A" : widget.vitals!.spo2.toString()} %"),
                        ShortNamesWidget(
                            typeId: 1,
                            firstText: "Heart Rate : ",
                            secondText:
                                "${widget.vitals!.heartRate == null ? "N/A" : widget.vitals!.heartRate.toString()} BPM"),
                      ],
                    ),
                    Column(
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
                                  showSecondContainer = true;
                                  isEdit = true;
                                });

                                if (widget.bookingData != null) {
                                  heightController.text =
                                      widget.vitals!.height ?? "";
                                  weightController.text =
                                      widget.vitals!.weight ?? "";
                                  temperatureController.text =
                                      widget.vitals!.temperature ?? "";
                                  spo2Controller.text =
                                      widget.vitals!.spo2 ?? "";
                                  sysController.text = widget.vitals!.sys ?? "";
                                  diaController.text = widget.vitals!.dia ?? "";
                                  heartRateController.text =
                                      widget.vitals!.heartRate ?? "";
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
                                BlocProvider.of<AddVitalsBloc>(context).add(
                                    DeleteVitals(
                                        tokenId: widget.tokenId.toString()));
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
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

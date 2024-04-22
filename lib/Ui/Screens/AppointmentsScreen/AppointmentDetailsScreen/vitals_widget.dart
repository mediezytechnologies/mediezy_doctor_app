import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GetAppointments/appointment_details_page_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/short_names_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class VitalsWidget extends StatefulWidget {
  const VitalsWidget(
      {super.key,
      required this.tokenId,
      required this.appointmentDetailsPageModel});

  final String tokenId;
  final AppointmentDetailsPageModel appointmentDetailsPageModel;

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

  String dropdownVitalsValue = 'F';
  var vitalItems = [
    'F',
    'C',
  ];

  String vitalsType = "1";

  int editingVitalsIndex = -1;
  bool showSecondContainer = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showSecondContainer = !showSecondContainer; // Toggle visibility
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Vitals',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
              const Icon(Icons.arrow_drop_down_circle)
            ],
          ),
        ),
        // const VerticalSpacingWidget(height: 10),
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
                          const Text(
                            "Ht",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                hintStyle: TextStyle(
                                    fontSize: 13.sp, color: kSubTextColor),
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
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                      const HorizontalSpacingWidget(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Wt",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                hintStyle: TextStyle(
                                    fontSize: 13.sp, color: kSubTextColor),
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
                        "Kg",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: temperatureController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
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
                        height: 42.h,
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
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor),
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
                          const Text(
                            "Spo2",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 135.w,
                            child: TextFormField(
                              cursorColor: kMainColor,
                              controller: spo2Controller,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                counterText: "",
                                hintStyle: TextStyle(
                                    fontSize: 13.sp, color: kSubTextColor),
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
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w400),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      SizedBox(
                        width: 70.w,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: sysController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
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
                        style: TextStyle(color: Colors.grey, fontSize: 25.sp),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      SizedBox(
                        width: 70.w,
                        child: TextFormField(
                          cursorColor: kMainColor,
                          controller: diaController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
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
                          cursorColor: kMainColor,
                          controller: heartRateController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            hintStyle: TextStyle(
                                fontSize: 13.sp, color: kSubTextColor),
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
                  const VerticalSpacingWidget(height: 10),
                  InkWell(
                    onTap: () {
                      showSecondContainer = false;
                      editingVitalsIndex != -1
                          ? BlocProvider.of<AddVitalsBloc>(context).add(
                              EditVitals(
                                  height: heightController.text,
                                  weight: weightController.text,
                                  temperature: temperatureController.text,
                                  spo2: spo2Controller.text,
                                  sys: sysController.text,
                                  dia: diaController.text,
                                  heartRate: heartRateController.text,
                                  tokenId: widget.tokenId,
                                  temperatureType: dropdownVitalsValue))
                          : BlocProvider.of<AddVitalsBloc>(context).add(
                              AddVitals(
                                  height: heightController.text,
                                  weight: weightController.text,
                                  temperature: temperatureController.text,
                                  spo2: spo2Controller.text,
                                  sys: sysController.text,
                                  dia: diaController.text,
                                  heartRate: heartRateController.text,
                                  tokenId: widget.tokenId,
                                  temperatureType: dropdownVitalsValue));
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
                        editingVitalsIndex != -1 ? "Update" : "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // const VerticalSpacingWidget(height: 5),
        // if (isSecondContainerVisible)
        widget.appointmentDetailsPageModel.bookingData!.vitals == null
            ? Container()
            : Text(
                'Added Vitals',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Colors.grey),
              ),
        // const VerticalSpacingWidget(height: 5),
        widget.appointmentDetailsPageModel.bookingData!.vitals == null
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
                          firstText: "Height : ",
                          secondText: widget.appointmentDetailsPageModel
                                      .bookingData!.vitals!.height ==
                                  null
                              ? "N/A"
                              : "${widget.appointmentDetailsPageModel.bookingData!.vitals!.height.toString()} cm",
                        ),
                        ShortNamesWidget(
                          firstText: "Temperature : ",
                          secondText: widget.appointmentDetailsPageModel
                                      .bookingData!.vitals!.temperature ==
                                  null
                              ? "N/A"
                              : "${widget.appointmentDetailsPageModel.bookingData!.vitals!.temperature.toString()} °${widget.appointmentDetailsPageModel.bookingData!.vitals!.temperatureType.toString()}",
                        ),
                        ShortNamesWidget(
                          firstText: "BP : ",
                          secondText:
                              "${widget.appointmentDetailsPageModel.bookingData!.vitals!.sys == null ? "N/A" : widget.appointmentDetailsPageModel.bookingData!.vitals!.sys.toString()} / ${widget.appointmentDetailsPageModel.bookingData!.vitals!.dia == null ? "N/A" : widget.appointmentDetailsPageModel.bookingData!.vitals!.dia.toString()}",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ShortNamesWidget(
                          firstText: "Weight : ",
                          secondText: widget.appointmentDetailsPageModel
                                      .bookingData!.vitals!.weight ==
                                  null
                              ? "N/A"
                              : "${widget.appointmentDetailsPageModel.bookingData!.vitals!.weight.toString()} Kg",
                        ),
                        ShortNamesWidget(
                            firstText: "spo2 : ",
                            secondText:
                                "${widget.appointmentDetailsPageModel.bookingData!.vitals!.spo2 == null ? "N/A" : widget.appointmentDetailsPageModel.bookingData!.vitals!.spo2.toString()} %"),
                        ShortNamesWidget(
                            firstText: "Heart Rate : ",
                            secondText:
                                "${widget.appointmentDetailsPageModel.bookingData!.vitals!.heartRate == null ? "N/A" : widget.appointmentDetailsPageModel.bookingData!.vitals!.heartRate.toString()} BPM"),
                      ],
                    ),
                    Column(
                      children: [
                        PopupMenuButton(
                          iconSize: 20.sp,
                          icon: Icon(
                            Icons.more_vert,
                            color: kMainColor,
                          ),
                          itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  showSecondContainer = true;
                                  editingVitalsIndex = 1;
                                });

                                if (widget.appointmentDetailsPageModel
                                        .bookingData !=
                                    null) {
                                  heightController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .height
                                      .toString();
                                  weightController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .weight
                                      .toString();
                                  temperatureController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .temperature
                                      .toString();
                                  spo2Controller.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .spo2
                                      .toString();
                                  sysController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .sys
                                      .toString();
                                  diaController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .dia
                                      .toString();
                                  heartRateController.text = widget
                                      .appointmentDetailsPageModel
                                      .bookingData!
                                      .vitals!
                                      .heartRate
                                      .toString();
                                }
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                BlocProvider.of<AddVitalsBloc>(context).add(
                                    DeleteVitals(
                                        tokenId: widget
                                            .appointmentDetailsPageModel
                                            .bookingData!
                                            .tokenId
                                            .toString()));
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
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

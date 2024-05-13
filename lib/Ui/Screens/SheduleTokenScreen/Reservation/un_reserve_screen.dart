// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ReserveToken/reserve_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/RemoveTokens/token_card_remove_widget.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import '../../../../Model/GenerateToken/clinic_get_model.dart';

class UnReserveTokenScreen extends StatefulWidget {
  const UnReserveTokenScreen({super.key});

  @override
  State<UnReserveTokenScreen> createState() => _UnReserveTokenScreenState();
}

class _UnReserveTokenScreenState extends State<UnReserveTokenScreen> {
  late TabController tabSecondController;
  DateTime? selectedManageDate;
  DateTime selectedunreserveDate = DateTime.now();
  DateTime unreserveendDate = DateTime.now();

  late ClinicGetModel clinicGetModel;

  // late GetReservedTokensModel getReservedTokensModel;

  // bool isClickedManage = false;

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedunreserveDate);
    return formattedSelectedDate;
  }

  final HospitalController dController = Get.put(HospitalController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ReserveTokenBloc, ReserveTokenState>(
      listener: (context, state) {
        if (state is UnReserveTokenLoaded) {
          BlocProvider.of<ReserveTokenBloc>(context).add(FetchReservedTokens(
              fromDate: DateFormat('yyy-MM-dd').format(selectedunreserveDate),
              toDate: DateFormat('yyy-MM-dd').format(unreserveendDate),
              clinicId: dController.initialIndex!));
        }
        if (state is UnReserveTokenError) {
          GeneralServices.instance
              .showErrorMessage(context, state.errorMessage);
          Future.delayed(const Duration(seconds: 3), () {
            // Navigator.pop(context);
          });
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Clinic",
                      style: size.width > 450 ? greyTab10B600 : grey13B600,
                    ),
                    const VerticalSpacingWidget(height: 5),
                    GetBuilder<HospitalController>(builder: (clx) {
                      return CustomDropDown(
                        width: double.infinity,
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
                          BlocProvider.of<ReserveTokenBloc>(context).add(
                              FetchReservedTokens(
                                  fromDate: DateFormat('yyy-MM-dd')
                                      .format(selectedunreserveDate),
                                  toDate: DateFormat('yyy-MM-dd')
                                      .format(unreserveendDate),
                                  clinicId: dController.initialIndex!));
                        },
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: selectedunreserveDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            selectedunreserveDate = picked;
                                            unreserveendDate =
                                                picked; // Update unreserveendDate as well
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: selectedunreserveDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            selectedunreserveDate = picked;
                                            unreserveendDate =
                                                picked; // Update unreserveendDate as well
                                          });
                                        },
                                      );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Start Date",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  const HorizontalSpacingWidget(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      Platform.isIOS
                                          ? GeneralServices.instance
                                              .selectIosDate(
                                              context: context,
                                              date: selectedunreserveDate,
                                              onDateSelected:
                                                  (DateTime picked) async {
                                                setState(() {
                                                  selectedunreserveDate =
                                                      picked;
                                                  unreserveendDate =
                                                      picked; // Update unreserveendDate as well
                                                });
                                                BlocProvider.of<
                                                            ReserveTokenBloc>(
                                                        context)
                                                    .add(FetchReservedTokens(
                                                        fromDate: DateFormat(
                                                                'yyy-MM-dd')
                                                            .format(
                                                                selectedunreserveDate),
                                                        toDate: DateFormat(
                                                                'yyy-MM-dd')
                                                            .format(
                                                                unreserveendDate),
                                                        clinicId: dController
                                                            .initialIndex!));
                                              },
                                            )
                                          : GeneralServices.instance.selectDate(
                                              context: context,
                                              date: selectedunreserveDate,
                                              onDateSelected:
                                                  (DateTime picked) async {
                                                setState(() {
                                                  selectedunreserveDate =
                                                      picked;
                                                  unreserveendDate =
                                                      picked; // Update unreserveendDate as well
                                                });
                                                BlocProvider.of<
                                                            ReserveTokenBloc>(
                                                        context)
                                                    .add(FetchReservedTokens(
                                                        fromDate: DateFormat(
                                                                'yyy-MM-dd')
                                                            .format(
                                                                selectedunreserveDate),
                                                        toDate: DateFormat(
                                                                'yyy-MM-dd')
                                                            .format(
                                                                unreserveendDate),
                                                        clinicId: dController
                                                            .initialIndex!));
                                              },
                                            );
                                    },
                                    icon: Icon(
                                      IconlyLight.calendar,
                                      color: kMainColor,
                                      size: size.width > 450 ? 12.sp : 20.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyy')
                                  .format(selectedunreserveDate),
                              style: size.width > 450
                                  ? blackTabMainText
                                  : black14B600,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Platform.isIOS
                                    ? GeneralServices.instance.selectIosDate(
                                        context: context,
                                        date: unreserveendDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            unreserveendDate = picked;
                                            // print(unreserveendDate);
                                          });
                                        },
                                      )
                                    : GeneralServices.instance.selectDate(
                                        context: context,
                                        date: unreserveendDate,
                                        onDateSelected: (DateTime picked) {
                                          setState(() {
                                            unreserveendDate = picked;
                                            // print(unreserveendDate);
                                          });
                                        },
                                      );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "End Date",
                                    style: size.width > 450
                                        ? greyTab10B600
                                        : grey13B600,
                                  ),
                                  const HorizontalSpacingWidget(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      Platform.isIOS
                                          ? GeneralServices.instance
                                              .selectIosDate(
                                              context: context,
                                              date: unreserveendDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  unreserveendDate = picked;
                                                  // print(unreserveendDate);
                                                });
                                              },
                                            )
                                          : GeneralServices.instance.selectDate(
                                              context: context,
                                              date: unreserveendDate,
                                              onDateSelected:
                                                  (DateTime picked) {
                                                setState(() {
                                                  unreserveendDate = picked;
                                                  // print(unreserveendDate);
                                                });
                                              },
                                            );
                                    },
                                    icon: Icon(
                                      IconlyLight.calendar,
                                      color: kMainColor,
                                      size: size.width > 450 ? 12.sp : 20.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyy').format(unreserveendDate),
                              style: size.width > 450
                                  ? blackTabMainText
                                  : black14B600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    BlocBuilder<ReserveTokenBloc, ReserveTokenState>(
                      builder: (context, state) {
                        if (state is ReservedTokensLoading) {
                          return GeneralServices.instance
                              .buildLoadingWidget(context);
                        }
                        if (state is ReservedTokensError) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const VerticalSpacingWidget(height: 100),
                              Center(
                                child: SizedBox(
                                  height: 300.h,
                                  width: 300.w,
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/something went wrong-01.png"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is ReservedTokensLoaded) {
                          final getReservedTokensModel =
                              state.getReservedTokensModel;
                          if (getReservedTokensModel.getTokenDetails!.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const VerticalSpacingWidget(height: 100),
                                Center(
                                  child: Image(
                                    height: 150.h,
                                    image: const AssetImage(
                                        "assets/images/no_data.jpg"),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpacingWidget(height: 10),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: getReservedTokensModel
                                    .getTokenDetails!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: size.width > 450 ? 7 : 5,
                                  mainAxisExtent: size.width > 450 ? 100 : 70,
                                ),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      TokenCardRemoveWidget(
                                        color: Colors.white,
                                        textColor: kTextColor,
                                        tokenNumber: getReservedTokensModel
                                            .getTokenDetails![index]
                                            .tokenNumber!
                                            .toString(),
                                        time: getReservedTokensModel
                                            .getTokenDetails![index]
                                            .tokenStartTime!
                                            .toString(),
                                        isTimedOut: 0,
                                        isReserved: 0,
                                        isBooked: 0,
                                      ),
                                      Positioned(
                                        left: size.width > 450 ? 32.w : 45.w,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<
                                                    ReserveTokenBloc>(context)
                                                .add(UnReserveToken(
                                                    tokenNumber:
                                                        getReservedTokensModel
                                                            .getTokenDetails![
                                                                index]
                                                            .tokenNumber
                                                            .toString(),
                                                    fromDate: DateFormat(
                                                            'yyy-MM-dd')
                                                        .format(
                                                            selectedunreserveDate),
                                                    toDate: DateFormat(
                                                            'yyy-MM-dd')
                                                        .format(
                                                            unreserveendDate),
                                                    clinicId: dController
                                                        .initialIndex!));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius:
                                                size.width > 450 ? 8.r : 8.r,
                                            child: const Icon(
                                              Icons.close,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                              const VerticalSpacingWidget(height: 10),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    const VerticalSpacingWidget(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

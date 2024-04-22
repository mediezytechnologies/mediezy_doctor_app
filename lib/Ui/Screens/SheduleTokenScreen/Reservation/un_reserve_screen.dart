// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetReservedTokensModel/GetReservedTokensModel.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ReserveToken/reserve_token_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shimmer/shimmer.dart';
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

  //* for manage section
  late ValueNotifier<String> dropValueUnreserveNotifier;
  String clinicUnreserveId = "";
  late String selectedUnReserveClinicId;
  List<HospitalDetails> clinicValueUnReserve = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Un Reserve Tokens",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
      body: BlocListener<ReserveTokenBloc, ReserveTokenState>(
        listener: (context, state) {
          if (state is UnReserveTokenLoaded) {
            BlocProvider.of<ReserveTokenBloc>(context).add(FetchReservedTokens(
                fromDate: DateFormat('yyy-MM-dd').format(selectedunreserveDate),
                toDate: DateFormat('yyy-MM-dd').format(unreserveendDate),
                clinicId: selectedUnReserveClinicId));
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
                VerticalSpacingWidget(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Clinic",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: kSubTextColor),
                      ),
                      const VerticalSpacingWidget(height: 5),
                      BlocBuilder<GetClinicBloc, GetClinicState>(
                        builder: (context, state) {
                          if (state is GetClinicLoaded) {
                            clinicGetModel =
                                BlocProvider.of<GetClinicBloc>(context)
                                    .clinicGetModel;

                            if (clinicValueUnReserve.isEmpty) {
                              clinicValueUnReserve
                                  .addAll(clinicGetModel.hospitalDetails!);
                              dropValueUnreserveNotifier = ValueNotifier(
                                  clinicValueUnReserve.first.clinicName!);
                              clinicUnreserveId =
                                  clinicValueUnReserve.first.clinicId.toString();
                              selectedUnReserveClinicId =
                                  clinicValueUnReserve.first.clinicId.toString();
                            }

                            BlocProvider.of<ReserveTokenBloc>(context).add(
                                FetchReservedTokens(
                                    fromDate: DateFormat('yyy-MM-dd')
                                        .format(selectedunreserveDate),
                                    toDate:
                                        DateFormat('yyy-MM-dd').format(unreserveendDate),
                                    clinicId: selectedUnReserveClinicId));
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
                                    valueListenable: dropValueUnreserveNotifier,
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
                                          dropValueUnreserveNotifier.value = value;
                                          clinicUnreserveId = value;
                                          selectedUnReserveClinicId =
                                              clinicValueUnReserve
                                                  .where((element) => element
                                                      .clinicName!
                                                      .contains(value))
                                                  .toList()
                                                  .first
                                                  .clinicId
                                                  .toString();
                                          BlocProvider.of<ReserveTokenBloc>(
                                                  context)
                                              .add(FetchReservedTokens(
                                                  fromDate:
                                                      DateFormat('yyy-MM-dd')
                                                          .format(selectedunreserveDate),
                                                  toDate:
                                                      DateFormat('yyy-MM-dd')
                                                          .format(unreserveendDate),
                                                  clinicId:
                                                      selectedUnReserveClinicId));
                                          // resetSelectedTokens();
                                        },
                                        items: clinicValueUnReserve
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            value: value.clinicName!,
                                            child: Text(value.clinicName!),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  GeneralServices.instance.selectDate(
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
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextColor),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        GeneralServices.instance.selectDate(
                                          context: context,
                                          date: selectedunreserveDate,
                                          onDateSelected:
                                              (DateTime picked) async {
                                            setState(() {
                                              selectedunreserveDate = picked;
                                              unreserveendDate =
                                                  picked; // Update unreserveendDate as well
                                            });
                                            BlocProvider.of<ReserveTokenBloc>(
                                                    context)
                                                .add(FetchReservedTokens(
                                                    fromDate: DateFormat(
                                                            'yyy-MM-dd')
                                                        .format(selectedunreserveDate),
                                                    toDate:
                                                        DateFormat('yyy-MM-dd')
                                                            .format(unreserveendDate),
                                                    clinicId:
                                                        selectedUnReserveClinicId));
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        IconlyLight.calendar,
                                        color: kMainColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('dd-MM-yyy').format(selectedunreserveDate),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  GeneralServices.instance.selectDate(
                                    context: context,
                                    date: unreserveendDate,
                                    onDateSelected: (DateTime picked) {
                                      setState(() {
                                        unreserveendDate = picked;
                                        print(unreserveendDate);
                                      });
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "End Date",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextColor),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        GeneralServices.instance.selectDate(
                                          context: context,
                                          date: unreserveendDate,
                                          onDateSelected: (DateTime picked) {
                                            setState(() {
                                              unreserveendDate = picked;
                                              print(unreserveendDate);
                                            });
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        IconlyLight.calendar,
                                        color: kMainColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('dd-MM-yyy').format(unreserveendDate),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      BlocBuilder<ReserveTokenBloc, ReserveTokenState>(
                        builder: (context, state) {
                          if (state is ReservedTokensLoading) {
                            return _buildLoadingWidget();
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
                            if (getReservedTokensModel
                                .getTokenDetails!.isEmpty) {
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
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 5,
                                    mainAxisExtent: 70,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: kMainColor,
                                              width: 1.w,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                getReservedTokensModel
                                                    .getTokenDetails![index]
                                                    .tokenNumber!
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTextColor,
                                                ),
                                              ),
                                              Text(
                                                getReservedTokensModel
                                                    .getTokenDetails![index]
                                                    .tokenStartTime!
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 45.w,
                                          child: InkWell(
                                            onTap: () {
                                              BlocProvider.of<ReserveTokenBloc>(
                                                      context)
                                                  .add(UnReserveToken(
                                                      tokenNumber:
                                                          getReservedTokensModel
                                                              .getTokenDetails![
                                                                  index]
                                                              .tokenNumber
                                                              .toString(),
                                                      fromDate: DateFormat(
                                                              'yyy-MM-dd')
                                                          .format(selectedunreserveDate),
                                                      toDate: DateFormat(
                                                              'yyy-MM-dd')
                                                          .format(unreserveendDate),
                                                      clinicId:
                                                          selectedUnReserveClinicId));
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.black,
                                              radius: 10,
                                              child: Icon(
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
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 400.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          itemCount: 30,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 5,
            mainAxisExtent: 78,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kMainColor, width: 1.w),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/get_delete_tokens_model.dart';
import 'package:mediezy_doctor/Model/RestoreTokens/restore_dates_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/DeletedTokens/deleted_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/restore_tokens_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class RestoreTokens extends StatefulWidget {
  const RestoreTokens({super.key});

  @override
  State<RestoreTokens> createState() => _RestoreTokensState();
}

class _RestoreTokensState extends State<RestoreTokens> {
  late ClinicGetModel clinicGetModel;

  // late GetTokenModel getTokenModel;
  late RestoreDatesModel restoreDatesModel;
  late GetDeleteTokensModel getDeleteTokensModel;

  late ValueNotifier<String> dropValueRestoreNotifier;
  String clinicRestoreId = "";
  late String selectedRestoreClinicId;
  List<HospitalDetails> clinicValuesRestore = [];

  // List<String> selectedTokenNumbers = [];

  int selectedContainerIndex = 0;

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color morningContainerColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Restore Tokens",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
      body: BlocListener<RestoreTokensBloc, RestoreTokensState>(
        listener: (context, state) {
          if(state is AddRestoreTokensLoaded){
            BlocProvider.of<DeletedTokensBloc>(context)
                .add(FetchDeletedTokens(
              clinicId: selectedRestoreClinicId,
            ));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Clinic",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: kSubTextColor),
              ),
              const VerticalSpacingWidget(height: 2),
              BlocBuilder<GetClinicBloc, GetClinicState>(
                builder: (context, state) {
                  if (state is GetClinicLoaded) {
                    clinicGetModel =
                        BlocProvider.of<GetClinicBloc>(context).clinicGetModel;

                    if (clinicValuesRestore.isEmpty) {
                      clinicValuesRestore
                          .addAll(clinicGetModel.hospitalDetails!);
                      dropValueRestoreNotifier =
                          ValueNotifier(clinicValuesRestore.first.clinicName!);
                      clinicRestoreId =
                          clinicValuesRestore.first.clinicId.toString();
                      selectedRestoreClinicId =
                          clinicValuesRestore.first.clinicId.toString();
                    }
                    // BlocProvider.of<RestoreTokensBloc>(context)
                    //     .add(FetchRestoreDates(clinicId: selectedRestoreClinicId));
                    BlocProvider.of<DeletedTokensBloc>(context)
                        .add(FetchDeletedTokens(
                      clinicId: selectedRestoreClinicId,
                    ));

                    return Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xFF9C9C9C))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: dropValueRestoreNotifier,
                            builder:
                                (BuildContext context, String dropValue, _) {
                              return DropdownButtonFormField(
                                iconEnabledColor: kMainColor,
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                value: dropValue,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onChanged: (String? value) {
                                  dropValue = value!;
                                  dropValueRestoreNotifier.value = value;
                                  clinicRestoreId = value;
                                  selectedRestoreClinicId = clinicValuesRestore
                                      .where((element) =>
                                          element.clinicName!.contains(value))
                                      .toList()
                                      .first
                                      .clinicId
                                      .toString();
                                  BlocProvider.of<DeletedTokensBloc>(context)
                                      .add(FetchDeletedTokens(
                                    clinicId: selectedRestoreClinicId,
                                  ));
                                },
                                items: clinicValuesRestore
                                    .map<DropdownMenuItem<String>>((value) {
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
              const VerticalSpacingWidget(height: 10),
              BlocBuilder<DeletedTokensBloc, DeletedTokensState>(
                builder: (context, state) {
                  if (state is DeletedTokensLoading) {
                    // return _buildLoadingWidget();
                  }
                  if (state is DeletedTokensError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const VerticalSpacingWidget(height: 100),
                        Center(
                          child: Image(
                            height: 120.h,
                            image: const AssetImage(
                                "assets/images/something went wrong-01.png"),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is DeletedTokensLoaded) {
                    getDeleteTokensModel =
                        BlocProvider.of<DeletedTokensBloc>(context)
                            .getDeleteTokensModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: getDeleteTokensModel.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 4,
                            mainAxisExtent: 80,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: kCardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: kMainColor, width: 1.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        getDeleteTokensModel
                                            .data![index].tokenNumber
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kTextColor),
                                      ),
                                      Text(
                                        getDeleteTokensModel.data![index].time
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kTextColor),
                                      ),
                                      Text(
                                        getDeleteTokensModel.data![index].formatdate
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 55.w,
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<RestoreTokensBloc>(
                                              context)
                                          .add(AddRestoreTokens(
                                              tokenId: getDeleteTokensModel
                                                  .data![index].tokenId
                                                  .toString()));
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
                      ],
                    );
                  }
                  return Container();
                },
              ),
              const VerticalSpacingWidget(height: 10),
              // CommonButtonWidget(
              //     title: "Restore Token",
              //     onTapFunction: () {
              //       BlocProvider.of<RestoreTokensBloc>(context)
              //           .add(AddRestoreTokens(tokenId: selectedTokenNumbers));
              //     }),
            ],
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

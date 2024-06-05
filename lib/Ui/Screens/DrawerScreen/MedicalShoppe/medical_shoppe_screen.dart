import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/get_all_medical_shope_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllMedicalShoppe/get_all_medical_shoppe_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_medical_store_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MedicalShoppe/search_medical_store_screen.dart';

class MedicalShoppeScreen extends StatefulWidget {
  const MedicalShoppeScreen({super.key});

  @override
  State<MedicalShoppeScreen> createState() => _MedicalShoppeScreenState();
}

class _MedicalShoppeScreenState extends State<MedicalShoppeScreen> {
  late GetAllMedicalShopeModel getAllMedicalShopeModel;

  @override
  void initState() {
    BlocProvider.of<GetAllMedicalShoppeBloc>(context)
        .add(FetchAllMedicalShoppe());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Medical Store"),
          centerTitle: true,
        ),
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        body: BlocBuilder<GetAllMedicalShoppeBloc, GetAllMedicalShoppeState>(
          builder: (context, state) {
            if (state is GetAllMedicalShoppeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              );
            }
            if (state is GetAllMedicalShoppeError) {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
            if (state is GetAllMedicalShoppeLoaded) {
              getAllMedicalShopeModel =
                  BlocProvider.of<GetAllMedicalShoppeBloc>(context)
                      .getAllMedicalShopeModel;

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const SearchMedicalStoreScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              "Search your Medical Store",
                              style:
                                  size.width > 450 ? greyTab10B400 : grey13B600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CircleAvatar(
                              backgroundColor: kMainColor,
                              radius: size.width > 450 ? 13.r : 16.r,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  IconlyLight.search,
                                  color: kCardColor,
                                  size: size.width > 450 ? 12.sp : 18.sp,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: getAllMedicalShopeModel.medicalShop!.length,
                      itemBuilder: (context, index) {
                        return GetMedicalStoreWidget(
                          imageUrl: getAllMedicalShopeModel
                              .medicalShop![index].medicalShopimage
                              .toString(),
                          mobileNo: getAllMedicalShopeModel
                              .medicalShop![index].mobileNo
                              .toString(),
                          location: getAllMedicalShopeModel
                              .medicalShop![index].location
                              .toString(),
                          favouritesStatus: getAllMedicalShopeModel
                              .medicalShop![index].favoriteStatus
                              .toString(),
                          labName: getAllMedicalShopeModel
                              .medicalShop![index].medicalShop
                              .toString(),
                          labId: getAllMedicalShopeModel.medicalShop![index].id
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
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/Labs/get_all_labs_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllScanningCentre/get_all_scanning_centre_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllLab/get_all_lab_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_lab_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/Labs/search_lab_screen.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({super.key});

  @override
  State<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> with TickerProviderStateMixin {
  late GetAllLabsModel getAllLabsModel;
  late TabController tabController;

  @override
  void initState() {
    BlocProvider.of<GetAllLabBloc>(context).add(FetchGetAllLabs());
    BlocProvider.of<GetAllScanningCentreBloc>(context)
        .add(FetchGetAllScanningCentre());
    tabController = TabController(length: 2, vsync: this);
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
          title: const Text("Lab and Scan"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => BottomNavigationControlWidget(
                              selectedIndex: 0,
                            )));
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        bottomNavigationBar: Platform.isIOS
            ? SizedBox(
                height: size.height * 0.038,
                width: double.infinity,
              )
            : const SizedBox(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetAllLabBloc, GetAllLabState>(
                builder: (context, state) {
                  if (state is GetAllLabLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is GetAllLabError) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                  if (state is GetAllLabLoaded) {
                    getAllLabsModel =
                        BlocProvider.of<GetAllLabBloc>(context).getAllLabsModel;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(),
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
                                    "Search lab and scanning centre",
                                    style: size.width > 450
                                        ? greyTab10B400
                                        : grey13B600,
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
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: getAllLabsModel.laboratory!.length,
                            itemBuilder: (context, index) {
                              return GetLabWidget(
                                labName: getAllLabsModel
                                    .laboratory![index].laboratory
                                    .toString(),
                                imageUrl: getAllLabsModel
                                    .laboratory![index].laboratoryimage
                                    .toString(),
                                mobileNo: getAllLabsModel
                                    .laboratory![index].mobileNo
                                    .toString(),
                                location: getAllLabsModel
                                    .laboratory![index].location
                                    .toString(),
                                labId: getAllLabsModel.laboratory![index].id
                                    .toString(),
                                favouritesStatus: getAllLabsModel
                                    .laboratory![index].favoriteStatus
                                    .toString(),
                              );
                            }),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

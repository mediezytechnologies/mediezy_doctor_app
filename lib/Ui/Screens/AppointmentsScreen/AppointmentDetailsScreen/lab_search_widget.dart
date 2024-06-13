import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/search_lab_test/favourite_lab_test/favourite_lab_test_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

import '../../../../Repositary/Bloc/GetAppointments/search_lab_test/search_lab/search_lab_test_bloc.dart';

class LabSearchWidget extends StatefulWidget {
  const LabSearchWidget({
    super.key,
    required this.onLabSelected,
    required this.typeId,
    required this.labTypeId,
  });

  final int typeId;
  final int labTypeId;
  final Function(String selectedLabName, String selectedLabId) onLabSelected;

  @override
  State<LabSearchWidget> createState() => LabhWidgetState();
}

class LabhWidgetState extends State<LabSearchWidget> {
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    BlocProvider.of<SearchLabTestBloc>(context)
        .add(FetchAllLabTest(searchQuery: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.labTypeId == 1 ? "Scan test" : "Lab test"),
        centerTitle: true,
      ),
      bottomNavigationBar: Platform.isIOS
          ? SizedBox(
              height: size.height * 0.038,
              width: double.infinity,
            )
          : const SizedBox(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                child: TextFormField(
                  autofocus: true,
                  cursorColor: kMainColor,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (newValue) {
                    BlocProvider.of<SearchLabTestBloc>(context)
                        .add(FetchAllLabTest(searchQuery: newValue));
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: kMainColor,
                      size: size.width > 450 ? 14.sp : 20.sp,
                    ),
                    hintStyle: size.width > 450 ? greyTab10B600 : grey13B600,
                    hintText: "Search your labs test's",
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              BlocBuilder<SearchLabTestBloc, SearchLabTestState>(
                builder: (context, state) {
                  if (state is SearchLabTestLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    );
                  }
                  if (state is SearchLabTestError) {
                    return Center(
                      child: Image(
                        image: const AssetImage(
                            "assets/images/something went wrong-01.png"),
                        height: 200.h,
                        width: 200.w,
                      ),
                    );
                  }
                  if (state is SearchLabTestLoaded) {
                    final searchLabTestModel = state.searchLabTestModel;
                    if (searchLabTestModel.labTests != null &&
                        searchLabTestModel.labTests!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchLabTestModel.labTests!.length,
                            itemBuilder: (context, index) {
                              var labData = searchLabTestModel.labTests![index];
                              return ListTile(
                                title: Text(labData.testName ?? ''),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      labData.favStatus =
                                          labData.favStatus == 1 ? 0 : 1;
                                    });
                                    BlocProvider.of<FavouriteLabTestBloc>(
                                            context)
                                        .add(AddFavouriteLabTest(
                                            labTestId: labData.id.toString()));
                                  },
                                  icon: Icon(
                                    labData.favStatus == 1
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: labData.favStatus == 1
                                        ? kMainColor
                                        : null,
                                  ),
                                ),
                                onTap: () {
                                  widget.typeId == 1
                                      ? ""
                                      : setState(() {
                                          widget.onLabSelected(
                                              labData.testName.toString(),
                                              labData.id.toString());
                                          Navigator.pop(context);
                                        });
                                },
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          const VerticalSpacingWidget(height: 110),
                          Center(
                            child: Image(
                              image: const AssetImage(
                                "assets/images/no medicine.png",
                              ),
                              height: 300.h,
                              width: 300.w,
                            ),
                          ),
                        ],
                      );
                    }
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

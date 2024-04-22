import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/Labs/search_lab_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/SearchScanningCentre/search_scanning_centre_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_lab_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class SearchScanningScreen extends StatefulWidget {
  const SearchScanningScreen({super.key});

  @override
  State<SearchScanningScreen> createState() => _SearchScanningScreenState();
}

class _SearchScanningScreenState extends State<SearchScanningScreen> {
  final TextEditingController searchController = TextEditingController();
  late SearchLabModel searchLabModel;

  @override
  void initState() {
    BlocProvider.of<SearchScanningCentreBloc>(context)
        .add(FetchSearchScanningCentre(searchQuery: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  cursorColor: kMainColor,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (newValue) {
                    BlocProvider.of<SearchScanningCentreBloc>(context)
                        .add(FetchSearchScanningCentre(searchQuery: newValue));
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: kMainColor,
                    ),
                    hintStyle: TextStyle(fontSize: 15.sp, color: kSubTextColor),
                    hintText: "Search Scanning Centre",
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                BlocBuilder<SearchScanningCentreBloc,
                    SearchScanningCentreState>(
                  builder: (context, state) {
                    if (state is SearchScanningCentreLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is SearchScanningCentreError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is SearchScanningCentreLoaded) {
                      searchLabModel =
                          BlocProvider.of<SearchScanningCentreBloc>(context)
                              .searchLabModel;
                      return searchLabModel.laboratory!.isEmpty
                          ? Column(
                              children: [
                                VerticalSpacingWidget(height: 130.h),
                                Center(
                                  child: Image(
                                    image: const AssetImage(
                                        "assets/images/There is no scaning01-01-01.png"),
                                    height: 200.h,
                                    width: 200.w,
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: searchLabModel.laboratory!.length,
                              itemBuilder: (context, index) {
                                return GetLabWidget(
                                  labName: searchLabModel
                                      .laboratory![index].laboratory
                                      .toString(),
                                  imageUrl: searchLabModel
                                      .laboratory![index].laboratoryimage
                                      .toString(),
                                  mobileNo: searchLabModel
                                      .laboratory![index].mobileNo
                                      .toString(),
                                  location: searchLabModel
                                      .laboratory![index].location
                                      .toString(),
                                  labId: searchLabModel.laboratory![index].id
                                      .toString(),
                                  favouritesStatus: searchLabModel
                                      .laboratory![index].favoriteStatus
                                      .toString(),
                                );
                              });
                    }
                    return Container(
                      color: Colors.yellow,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

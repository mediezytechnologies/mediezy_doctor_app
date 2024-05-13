import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/MedicalShoppe/search_medical_store_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/SearchMedicalStore/search_medical_store_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/get_lab_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class SearchMedicalStoreScreen extends StatefulWidget {
  const SearchMedicalStoreScreen({super.key});

  @override
  State<SearchMedicalStoreScreen> createState() =>
      _SearchMedicalStoreScreenState();
}

class _SearchMedicalStoreScreenState extends State<SearchMedicalStoreScreen> {
  final TextEditingController searchController = TextEditingController();
  late SearchMedicalStoreModel searchMedicalStoreModel;

  @override
  void initState() {
    BlocProvider.of<SearchMedicalStoreBloc>(context)
        .add(FetchSearchMedicalStore(searchQuery: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  cursorColor: kMainColor,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (newValue) {
                    BlocProvider.of<SearchMedicalStoreBloc>(context)
                        .add(FetchSearchMedicalStore(searchQuery: newValue));
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: kMainColor,
                      size: size.width > 450 ? 12.sp : 18.sp,
                    ),
                    hintStyle: size.width > 450 ? greyTab10B400 : grey13B600,
                    hintText: "Search Medical Store",
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                BlocBuilder<SearchMedicalStoreBloc, SearchMedicalStoreState>(
                  builder: (context, state) {
                    if (state is SearchMedicalStoreLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is SearchMedicalStoreError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is SearchMedicalStoreLoaded) {
                      searchMedicalStoreModel =
                          BlocProvider.of<SearchMedicalStoreBloc>(context)
                              .searchMedicalStoreModel;
                      return searchMedicalStoreModel.medicalShop!.isEmpty
                          ? Column(
                              children: [
                                VerticalSpacingWidget(height: 130.h),
                                Center(
                                  child: Image(
                                    image: const AssetImage(
                                        "assets/images/There is no medical store -01-01.png"),
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
                              itemCount:
                                  searchMedicalStoreModel.medicalShop!.length,
                              itemBuilder: (context, index) {
                                return GetLabWidget(
                                  labName: searchMedicalStoreModel
                                      .medicalShop![index].medicalShop
                                      .toString(),
                                  imageUrl: searchMedicalStoreModel
                                      .medicalShop![index].medicalShopimage
                                      .toString(),
                                  mobileNo: searchMedicalStoreModel
                                      .medicalShop![index].mobileNo
                                      .toString(),
                                  location: searchMedicalStoreModel
                                      .medicalShop![index].location
                                      .toString(),
                                  labId: searchMedicalStoreModel
                                      .medicalShop![index].id
                                      .toString(),
                                  favouritesStatus: searchMedicalStoreModel
                                      .medicalShop![index].favoriteStatus
                                      .toString(),
                                );
                              });
                    }
                    return Container();
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

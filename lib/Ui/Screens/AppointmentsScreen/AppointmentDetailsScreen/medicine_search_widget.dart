import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/update_favourite_medicine/bloc/update_favourite_medicine_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/get_all_medicines_bloc.dart';

class MedicineSearchWidget extends StatefulWidget {
  const MedicineSearchWidget({
    super.key,
    required this.onMedicineSelected,
    required this.typeId,
  });

  final int typeId;
  final Function(String selectedMedicineName, String selectedMedicineId)
      onMedicineSelected;

  @override
  State<MedicineSearchWidget> createState() => _MedicineSearchWidgetState();
}

class _MedicineSearchWidgetState extends State<MedicineSearchWidget> {
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    BlocProvider.of<GetAllMedicinesBloc>(context)
        .add(FetchMedicines(searchQuery: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Medicines"),
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
                    BlocProvider.of<GetAllMedicinesBloc>(context)
                        .add(FetchMedicines(searchQuery: newValue));
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: kMainColor,
                      size: size.width > 450 ? 14.sp : 20.sp,
                    ),
                    hintStyle: size.width > 450 ? greyTab10B600 : grey13B600,
                    hintText: "Search your medicines",
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              BlocListener<UpdateFavouriteMedicineBloc,
                  UpdateFavouriteMedicineState>(
                listener: (context, state) {
                  if (state is DeleteRecentlySearchLoaded) {
                    BlocProvider.of<GetAllMedicinesBloc>(context)
                        .add(FetchMedicines(searchQuery: ""));
                  }
                },
                child: BlocBuilder<GetAllMedicinesBloc, GetAllMedicinesState>(
                  builder: (context, state) {
                    if (state is GetAllMedicinesLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is GetAllMedicinesError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is GetAllMedicinesLoaded) {
                      final getAllMedicinesModel = state.getAllMedicinesModel;
                      if (getAllMedicinesModel.medicines != null &&
                          getAllMedicinesModel.medicines!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.typeId == 1 ||
                                    getAllMedicinesModel
                                        .medicineHistory!.isEmpty
                                ? Container()
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 2.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const VerticalSpacingWidget(
                                              height: 3),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Text(
                                              "Recently search",
                                              style: size.width > 450
                                                  ? greyTabMain
                                                  : greyMain,
                                            ),
                                          ),
                                          const VerticalSpacingWidget(
                                              height: 3),
                                          Wrap(
                                            children: List.generate(
                                              getAllMedicinesModel
                                                  .medicineHistory!.length,
                                              (index) => Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: kMainColor,
                                                          width: 1),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              widget
                                                                  .onMedicineSelected(
                                                                getAllMedicinesModel
                                                                    .medicineHistory![
                                                                        index]
                                                                    .medicineName
                                                                    .toString(),
                                                                getAllMedicinesModel
                                                                    .medicineHistory![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              );
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text(
                                                            getAllMedicinesModel
                                                                .medicineHistory![
                                                                    index]
                                                                .medicineName
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    size.width >
                                                                            450
                                                                        ? 9.sp
                                                                        : 11.sp,
                                                                color:
                                                                    kTextColor),
                                                          ),
                                                        ),
                                                        const HorizontalSpacingWidget(
                                                            width: 5),
                                                        InkWell(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        UpdateFavouriteMedicineBloc>(
                                                                    context)
                                                                .add(
                                                                    DeleteRecentlySearch(
                                                              medicineId:
                                                                  getAllMedicinesModel
                                                                      .medicineHistory![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                            ));
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 16,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getAllMedicinesModel.medicines!.length,
                              itemBuilder: (context, index) {
                                var medicineData =
                                    getAllMedicinesModel.medicines![index];
                                return ListTile(
                                  title: Text(medicineData.medicineName ?? ''),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        medicineData.favStatus =
                                            medicineData.favStatus == 1 ? 0 : 1;
                                      });
                                      BlocProvider.of<
                                                  UpdateFavouriteMedicineBloc>(
                                              context)
                                          .add(UpdateFavouriteMedicine(
                                              medicineId:
                                                  medicineData.id.toString()));
                                    },
                                    icon: Icon(
                                      medicineData.favStatus == 1
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: medicineData.favStatus == 1
                                          ? kMainColor
                                          : null,
                                    ),
                                  ),
                                  onTap: () {
                                    widget.typeId == 1
                                        ? ""
                                        : setState(() {
                                            widget.onMedicineSelected(
                                                medicineData.medicineName
                                                    .toString(),
                                                medicineData.id.toString());
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

import '../../../../Repositary/Bloc/GetAppointments/get_all_medicines/get_all_medicines_bloc.dart';

class MedicineSearchWidget extends StatefulWidget {
  const MedicineSearchWidget({super.key, required this.onMedicineSelected});
  final Function(String) onMedicineSelected;

  @override
  State<MedicineSearchWidget> createState() => _MedicineSearchWidgetState();
}

class _MedicineSearchWidgetState extends State<MedicineSearchWidget> {
  final TextEditingController searchController = TextEditingController();

  TextEditingController _textEditingController = TextEditingController();

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
                        size: size.width > 400 ? 14.sp : 20.sp,
                      ),
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
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
                BlocBuilder<GetAllMedicinesBloc, GetAllMedicinesState>(
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
                      final getAllMedicinesModel =
                          state.getAllMedicinesModel;
                      if (getAllMedicinesModel.medicines != null &&
                          getAllMedicinesModel.medicines!.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: getAllMedicinesModel.medicines!.length,
                            itemBuilder: (context, index) {
                              var medicineData =
                              getAllMedicinesModel.medicines![index];
                              return ListTile(
                                title: Text(medicineData.medicineName
                                    .toString()),
                                onTap: () {
                                  setState(() {
                                    _textEditingController.text =
                                        medicineData.medicineName
                                            .toString();
                                    widget.onMedicineSelected(medicineData.medicineName.toString());
                                    Navigator.pop(context);
                                    // log("${_textEditingController.text}");
                                  });
                                },
                              );
                            });
                      } else {
                        return Column(
                          children: [
                            VerticalSpacingWidget(height: 130.h),
                            Center(
                              child: Image(
                                image: const AssetImage(
                                  "assets/images/You ahve no patients-01.png",
                                ),
                                height: 200.h,
                                color: kMainColor,
                                width: 200.w,
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Container();
                  },
                ),
          // BlocBuilder<GetAllMedicinesBloc, GetAllMedicinesState>(
          //   builder: (context, state) {
          //     if (state is GetAllMedicinesError) {
          //       return Center(
          //         child: Text("Something went wrong"),
          //       );
          //     }
          //     if (state is GetAllMedicinesLoaded) {
          //       final getAllMedicinesModel =
          //           state.getAllMedicinesModel;
          //       return Column(
          //         children: [
          //           ListView.builder(
          //             itemCount: getAllMedicinesModel
          //                 .medicines!.length,
          //             itemBuilder: (context, index) {
          //               final medicine = getAllMedicinesModel
          //                   .medicines![index];
          //               if (searchText.isEmpty ||
          //                   medicine.medicineName
          //                       .toString()
          //                       .toLowerCase()
          //                       .contains(
          //                       searchText.toLowerCase())) {
          //                 return ListTile(
          //                   title: Text(medicine.medicineName
          //                       .toString()),
          //                   onTap: () {
          //                     setState(() {
          //                       _textEditingController.text =
          //                           medicine.medicineName
          //                               .toString();
          //                     });
          //                   },
          //                 );
          //               } else {
          //                 return SizedBox.shrink();
          //               }
          //             },
          //           ),
          //         ],
          //       );
          //     }
          //     return Container();
          //   },
          // ),
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
//
// Column(
// children: [
// SizedBox(
// width: 250,
// child: TextField(
// controller: _textEditingController,
// onChanged: (newValue) {
// BlocProvider.of<GetAllMedicinesBloc>(context)
//     .add(FetchMedicines(searchQuery: newValue));
// },
// decoration: InputDecoration(
// hintText: 'Search...',
// ),
// ),
// ),
// // Container(
// //   color: Colors.yellow,
// //   height: 200,
// //   width: 250,
// //   child: ListView.builder(
// //     itemCount: getAllMedicinesModel.medicines!.length,
// //     itemBuilder: (context, index) {
// //       final medicine = getAllMedicinesModel.medicines![index];
// //       if (searchText.isEmpty ||
// //           medicine.medicineName.toString().toLowerCase().contains(searchText.toLowerCase())) {
// //         return ListTile(
// //           title: Text(medicine.medicineName.toString()),
// //           onTap: () {
// //             setState(() {
// //               _textEditingController.text = medicine.medicineName.toString();
// //             });
// //           },
// //         );
// //       } else {
// //         return SizedBox.shrink();
// //       }
// //     },
// //   ),
// // ),
// ],
// ),
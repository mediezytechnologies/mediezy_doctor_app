// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
// import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
// import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
//
// class ClinicScreen extends StatefulWidget {
//   const ClinicScreen({super.key});
//
//   @override
//   State<ClinicScreen> createState() => _ClinicScreenState();
// }
//
// class _ClinicScreenState extends State<ClinicScreen> {
//
//   late ClinicGetModel clinicGetModel;
//   late ValueNotifier<String> dropValueClinicNotifier;
//   String clinicId = "";
//   String selectedClinicId="";
//   List<HospitalDetails> clinicValues = [];
//   @override
//   void initState() {
//     BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Select Clinic",
//           style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: kTextColor),
//         ),
//       ),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: BlocBuilder<GetClinicBloc, GetClinicState>(
//               builder: (context, state) {
//                 if(state is GetClinicError){
//                  const Center(child: Text("Something Went Wrong"));
//                 }
//                 if (state is GetClinicLoaded) {
//                   clinicGetModel =
//                       BlocProvider.of<GetClinicBloc>(context).clinicGetModel;
//
//                   return ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: clinicGetModel.hospitalDetails!.length,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       bool isSelected = selectedClinicId ==
//                           clinicGetModel.hospitalDetails![index].id.toString();
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedClinicId =
//                                 clinicGetModel.hospitalDetails![index].id.toString();
//                             // print(selectedClinicId);
//                           });
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: 10.h),
//                           padding: const EdgeInsets.all(4),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: isSelected
//                                 ? kMainColor
//                                 : const Color(0xFFEAF3F8),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                             clinicGetModel.hospitalDetails![index].hospitalName
//                                       ?.toString() ??
//                                       "Not Available",
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: isSelected
//                                         ? Colors.white
//                                         : kTextColor,
//                                   ),
//                                 ),
//                                 // Row(
//                                 //   children: [
//                                 //     Text(
//                                 //       clinicGetModel.hospitalDetails![index].availability
//                                 //           ?.toString() ??
//                                 //           "Not Available",
//                                 //       style: TextStyle(
//                                 //         fontSize: 12.sp,
//                                 //         fontWeight: FontWeight.w400,
//                                 //         color: isSelected
//                                 //             ? Colors.white
//                                 //             : kTextColor,
//                                 //       ),
//                                 //     ),
//                                 //     Padding(
//                                 //       padding:
//                                 //       EdgeInsets.fromLTRB(5.w, 0, 0, 0),
//                                 //       child: Text(
//                                 //         clinicGetModel.hospitalDetails![index].
//                                 //             ?.toString() ??
//                                 //             "Not Available",
//                                 //         style: TextStyle(
//                                 //           fontSize: 11.sp,
//                                 //           fontWeight: FontWeight.w400,
//                                 //           color: isSelected
//                                 //               ? Colors.white
//                                 //               : kTextColor,
//                                 //         ),
//                                 //       ),
//                                 //     ),
//                                 //   ],
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           ),
//           VerticalSpacingWidget(height: 200.h),
//           CommonButtonWidget(title: "UPDATE", onTapFunction: (){
//             Navigator.push(context, MaterialPageRoute(builder: (ctx)=>BottomNavigationControlWidget(clinicId: selectedClinicId,)));
//           })
//         ],
//       ),
//     );
//   }
// }

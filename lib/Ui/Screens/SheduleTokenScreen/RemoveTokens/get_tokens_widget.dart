// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mediezy_doctor/Ui/CommonWidgets/appointment_date_card_widget.dart';
// import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
//
// class GetTokensWidget extends StatefulWidget {
//   const GetTokensWidget(
//       {super.key,
//       required this.isTimeout,
//       required this.isBooked,
//       required this.tokenId,
//       required this.tokenNumber,
//       required this.time,
//       required this.mrngContainerColor});
//
//   final String isTimeout;
//   final String isBooked;
//   final String tokenId;
//   final String tokenNumber;
//   final String time;
//   final Color mrngContainerColor;
//   // final VoidCallback onTap;
//
//   @override
//   State<GetTokensWidget> createState() => _GetTokensWidgetState();
// }
//
// class _GetTokensWidgetState extends State<GetTokensWidget> {
//   List<String> selectedTokenNumbers = [];
//
//   void resetSelectedTokens() {
//     setState(() {
//       selectedTokenNumbers.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         setState(() {
//           if (selectedTokenNumbers.contains(widget.tokenId)) {
//             selectedTokenNumbers.remove(widget.tokenId);
//           } else {
//             selectedTokenNumbers.add(widget.tokenId);
//           }
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.grey.shade500 : widget.mrngContainerColor,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: kMainColor, width: 1.w),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               widget.tokenNumber,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: kTextColor,
//               ),
//             ),
//             Text(
//               widget.time,
//               style: TextStyle(
//                 fontSize: 9.sp,
//                 fontWeight: FontWeight.bold,
//                 color: kTextColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

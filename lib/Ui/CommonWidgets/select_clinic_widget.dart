import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

import 'custom_dropdown_widget.dart';

class SelectClinicWidget extends StatelessWidget {
  const SelectClinicWidget({super.key, this.onChanged});
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HospitalController dController = Get.put(HospitalController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Clinic",
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.w600, color: kSubTextColor),
        ),
        const VerticalSpacingWidget(height: 5),
        GetBuilder<HospitalController>(builder: (clx) {
          return CustomDropDown(
            width: size.width * 0.55,
            value: dController.initialIndex,
            items: dController.hospitalDetails!.map((e) {
              return DropdownMenuItem(
                value: e.clinicId.toString(),
                child: Text(e.clinicName!),
              );
            }).toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }
}

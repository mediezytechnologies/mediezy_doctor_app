import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';

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
          style: size.width > 450 ? greyTab10B600 : grey13B600,
        ),
        const VerticalSpacingWidget(height: 3),
        GetBuilder<HospitalController>(builder: (clx) {
          return CustomDropDown(
            width: size.width * 0.55,
            value: dController.initialIndex.value,
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

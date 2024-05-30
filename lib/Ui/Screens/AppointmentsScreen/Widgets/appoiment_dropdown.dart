import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_appointments/get_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/select_clinic_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import '../../../../Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';

class AppoimentDropdown extends StatelessWidget {
  const AppoimentDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HospitalController controller = Get.put(HospitalController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectClinicWidget(
              onChanged: (newValue) {
                log(newValue!);
                controller.dropdownValueChanging(
                    newValue, controller.initialIndex!);
                BlocProvider.of<GetAppointmentsBloc>(context).add(
                  FetchAllAppointments(
                      date: controller.formatDate(),
                      clinicId: controller.initialIndex!,
                      scheduleType: controller.scheduleIndex.value),
                );
                BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
                    .add(FetchAllCompletedAppointments(
                  date: controller.formatDate(),
                  clinicId: controller.initialIndex!,
                  scheduleType: controller.scheduleIndex.value,
                ));
              },
            ),
            const VerticalSpacingWidget(height: 2),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Schedule",
              style: size.width > 450 ? greyTab10B600 : grey13B600,
            ),
            const VerticalSpacingWidget(height: 3),
            Obx(
              () {
                return CustomDropDown(
                  width: size.width * 0.4,
                  value: controller.scheduleIndex.value,
                  items: controller.scheduleData.map((entry) {
                    return DropdownMenuItem(
                      value: entry.scheduleId.toString(),
                      child: Text(entry.scheduleName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    log(newValue!);
                    controller.dropdownValueChanging(newValue, '0');
                    BlocProvider.of<GetAppointmentsBloc>(context).add(
                      FetchAllAppointments(
                          date: controller.formatDate(),
                          clinicId: controller.initialIndex!,
                          scheduleType: controller.scheduleIndex.value),
                    );
                    BlocProvider.of<GetAllCompletedAppointmentsBloc>(context)
                        .add(FetchAllCompletedAppointments(
                      date: controller.formatDate(),
                      clinicId: controller.initialIndex!,
                      scheduleType: controller.scheduleIndex.value,
                    ));
                    log("val : ${controller.scheduleIndex}");
                  },
                );
              },
            ),
            const VerticalSpacingWidget(height: 2),
          ],
        ),
      ],
    );
  }
}

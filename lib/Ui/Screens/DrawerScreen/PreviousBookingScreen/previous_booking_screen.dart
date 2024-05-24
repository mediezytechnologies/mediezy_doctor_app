import 'dart:developer';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/get_all_previous_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/PreviousBookingScreen/previous_booking_details_screen.dart';

import '../../../CommonWidgets/text_style_widget.dart';

class PreviousBookingScreen extends StatefulWidget {
  const PreviousBookingScreen({super.key});

  @override
  State<PreviousBookingScreen> createState() => _PreviousBookingScreenState();
}

class _PreviousBookingScreenState extends State<PreviousBookingScreen> {
  DateTime selectedDate = DateTime.now();
  late ValueNotifier<String> dropValueClinicNotifier;
  late PreviousAppointmentsModel previousAppointmentsModel;
  late ClinicGetModel clinicGetModel;

  // late GetAllAppointmentsModel getAllAppointmentsModel;

  final HospitalController dController = Get.put(HospitalController());

  // String clinicId = "";
  // late String selectedClinicId;
  // List<HospitalDetails> clinicValues = [];
  // String dropdownvalue = '';
  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<GetAllPreviousAppointmentsBloc>(context).add(
      FetchAllPreviousAppointments(
          date: formatDate(), clinicId: dController.initialIndex!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Bookings"),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Clinic",
                  style: size.width > 450 ? greyTab10B600 : grey13B600,
                ),
                const VerticalSpacingWidget(height: 5),
                GetBuilder<HospitalController>(
                  builder: (clx) {
                    return CustomDropDown(
                      width: double.infinity,
                      value: dController.initialIndex,
                      items: dController.hospitalDetails!.map((e) {
                        return DropdownMenuItem(
                          value: e.clinicId.toString(),
                          child: Text(e.clinicName!),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        log(newValue!);
                        dController.dropdownValueChanging(
                            newValue, dController.initialIndex!);
                        BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                            .add(
                          FetchAllPreviousAppointments(
                              date: formatDate(),
                              clinicId: dController.initialIndex!),
                        );
                      },
                    );
                  },
                ),
                // const VerticalSpacingWidget(height: 10),
                GestureDetector(
                  onTap: () async {
                    await selectDate(
                      context: context,
                      date: selectedDate,
                      onDateSelected: (DateTime picked) {
                        setState(() {
                          selectedDate = picked;
                        });
                      },
                    );
                    BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                        .add(
                      FetchAllPreviousAppointments(
                        date: formatDate(),
                        clinicId: dController.initialIndex!,
                      ),
                    );
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Date",
                        style: size.width > 450 ? greyTab10B600 : grey13B600,
                      ),
                      IconButton(
                        onPressed: () async {
                          await selectDate(
                            context: context,
                            date: selectedDate,
                            onDateSelected: (DateTime picked) async {
                              setState(() {
                                selectedDate = picked;
                              });
                            },
                          );
                          // ignore: use_build_context_synchronously
                          BlocProvider.of<GetAllPreviousAppointmentsBloc>(
                                  context)
                              .add(
                            FetchAllPreviousAppointments(
                              date: formatDate(),
                              clinicId: dController.initialIndex!,
                            ),
                          );
                        },
                        icon: Icon(
                          IconlyLight.calendar,
                          color: kMainColor,
                          size: size.width > 450 ? 12.sp : 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                  style: size.width > 450 ? blackTabMainText : blackMainText,
                ),
                const VerticalSpacingWidget(height: 10),
                BlocBuilder<GetAllPreviousAppointmentsBloc,
                    GetAllPreviousAppointmentsState>(builder: (context, state) {
                  if (state is GetAllPreviousAppointmentsLoading) {
                    // return _shimmerLoading();
                  }
                  if (state is GetAllPreviousAppointmentsError) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                  if (state is GetAllPreviousAppointmentsLoaded) {
                    previousAppointmentsModel =
                        BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                            .previousAppointmentsModel;
                    return previousAppointmentsModel
                            .previousAppointments!.isEmpty
                        ? Center(
                            child: Image(
                                height: size.height * .55,
                                image: const AssetImage(
                                    "assets/images/No Appointment to day-01.png")))
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: previousAppointmentsModel
                                      .previousAppointments!.length,
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      const VerticalSpacingWidget(height: 3),
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      PreviousBookingDetailsScreen(
                                                        appointmentId:
                                                            previousAppointmentsModel
                                                                .previousAppointments![
                                                                    index]
                                                                .appointmentId
                                                                .toString(),
                                                        patientId:
                                                            previousAppointmentsModel
                                                                .previousAppointments![
                                                                    index]
                                                                .patientId
                                                                .toString(),
                                                      )));
                                        },
                                        child: AppointmentCardWidget(
                                          tokenNumber: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .tokenNumber
                                              .toString(),
                                          patientImage: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .userImage ==
                                                  null
                                              ? ""
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .userImage
                                                  .toString(),
                                          patientName: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .patientName
                                              .toString(),
                                          time: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .startingtime
                                              .toString(),
                                          mediezyId: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .mediezyPatientId ==
                                                  null
                                              ? ""
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .mediezyPatientId
                                                  .toString(),
                                          mainSymptoms:
                                              previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .mainSymptoms!
                                                      .isEmpty
                                                  ? previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .otherSymptoms!
                                                      .first
                                                      .symtoms
                                                      .toString()
                                                  : previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .mainSymptoms!
                                                      .first
                                                      .mainsymptoms
                                                      .toString(),
                                          onlineStatus: "online",
                                          reachedStatus: "0",
                                          noStatus: 1,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //! select date
  Future<void> selectDate({
    required BuildContext context,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: ((context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
            ),
          ),
          child: child!,
        );
      }),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }
}

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/PreviousAppointments/previous_appointments_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/get_all_previous_appointments_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/PreviousBookingDetailsScreen/previous_booking_details_screen.dart';

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
  String clinicId = "";
  late String selectedClinicId;
  List<HospitalDetails> clinicValues = [];
  String dropdownvalue = '';
  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  @override
  void initState() {
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Clinic",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: kSubTextColor),
              ),
              const VerticalSpacingWidget(height: 5),
              BlocBuilder<GetClinicBloc, GetClinicState>(
                builder: (context, state) {
                  if (state is GetClinicLoaded) {
                    clinicGetModel =
                        BlocProvider.of<GetClinicBloc>(context).clinicGetModel;
                    if (clinicValues.isEmpty) {
                      clinicValues.addAll(clinicGetModel.hospitalDetails!);
                      dropValueClinicNotifier =
                          ValueNotifier(clinicValues.first.clinicName!);
                      clinicId = clinicValues.first.clinicId.toString();
                      selectedClinicId = clinicValues.first.clinicId.toString();
                      BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                          .add(
                        FetchAllPreviousAppointments(
                            date: formatDate(), clinicId: selectedClinicId),
                      );
                    }
                    return Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xFF9C9C9C))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: dropValueClinicNotifier,
                            builder:
                                (BuildContext context, String dropValue, _) {
                              return DropdownButtonFormField(
                                iconEnabledColor: kMainColor,
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                value: dropValue,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onChanged: (String? value) {
                                  dropValue = value!;
                                  dropValueClinicNotifier.value = value;
                                  clinicId = value;
                                  selectedClinicId = clinicValues
                                      .where((element) =>
                                          element.clinicName!.contains(value))
                                      .toList()
                                      .first
                                      .clinicId
                                      .toString();
                                  BlocProvider.of<
                                              GetAllPreviousAppointmentsBloc>(
                                          context)
                                      .add(
                                    FetchAllPreviousAppointments(
                                        date: formatDate(),
                                        clinicId: selectedClinicId),
                                  );
                                },
                                items: clinicValues
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    onTap: () {},
                                    value: value.clinicName!,
                                    child: Text(value.clinicName!),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const VerticalSpacingWidget(height: 10),
              InkWell(
                onTap: () {
                  selectDate(
                    context: context,
                    date: selectedDate,
                    onDateSelected: (DateTime picked) {
                      setState(() {
                        selectedDate = picked;
                      });
                    },
                  );
                },
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Date",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: kSubTextColor),
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
                        BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                            .add(
                          FetchAllPreviousAppointments(
                            date: formatDate(),
                            clinicId: selectedClinicId,
                          ),
                        );
                      },
                      icon: Icon(
                        IconlyLight.calendar,
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
              const VerticalSpacingWidget(height: 10),
              BlocBuilder<GetAllPreviousAppointmentsBloc,
                  GetAllPreviousAppointmentsState>(
                builder: (context, state) {
                  if (state is GetAllPreviousAppointmentsLoading) {
                    return SizedBox(
                      height: 400.h,
                      child: Center(
                        child: CircularProgressIndicator(color: kMainColor),
                      ),
                    );
                  }
                  if (state is GetAllPreviousAppointmentsError) {
                    return const Text("Something went wrong");
                  }
                  if (state is GetAllPreviousAppointmentsLoaded) {
                    previousAppointmentsModel =
                        BlocProvider.of<GetAllPreviousAppointmentsBloc>(context)
                            .previousAppointmentsModel;
                    return previousAppointmentsModel
                            .previousAppointments!.isEmpty
                        ? SizedBox(
                            height: 400.h,
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/No_previous_appointments.jpg"),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const VerticalSpacingWidget(height: 5),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: previousAppointmentsModel
                                  .previousAppointments!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreviousBookingDetailsScreen(
                                          name: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .patientName
                                              .toString(),
                                          age: previousAppointmentsModel
                                              .previousAppointments![index].age
                                              .toString(),
                                          whenItCome: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .whenitcomes
                                              .toString(),
                                          whenItStart: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .whenitstart
                                              .toString(),
                                          appointmentFor:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .appoinmentfor2!
                                                  .toList(),
                                          bookedPersonId:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .bookedPersonId
                                                  .toString(),
                                          patientId: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .patientDetails ==
                                                  null
                                              ? ""
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .patientDetails!
                                                  .id
                                                  .toString(),
                                          appointmentDate:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .date
                                                  .toString(),
                                          appointmentTime:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .tokenTime
                                                  .toString(),
                                          tokenNumber: previousAppointmentsModel
                                              .previousAppointments![index]
                                              .tokenNumber
                                              .toString(),
                                          usingRegularMedicine:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .regularmedicine
                                                  .toString(),
                                          addedMedicines:
                                              previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .medicines!
                                                  .toList(),
                                          additionalNote:
                                              previousAppointmentsModel
                                                          .previousAppointments![
                                                              index]
                                                          .notes ==
                                                      null
                                                  ? " "
                                                  : previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .notes
                                                      .toString(),
                                          labName: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .laboratoryName ==
                                                  null
                                              ? " "
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .laboratoryName
                                                  .toString(),
                                          labTestName: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .laboratoryName ==
                                                  null
                                              ? " "
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .laboratoryName
                                                  .toString(),
                                          medicalShopeName:
                                              previousAppointmentsModel
                                                          .previousAppointments![
                                                              index]
                                                          .medicalshopName ==
                                                      null
                                                  ? " "
                                                  : previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .medicalshopName
                                                      .toString(),
                                          reviewAfter: previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .reviewAfter ==
                                                  null
                                              ? " "
                                              : previousAppointmentsModel
                                                  .previousAppointments![index]
                                                  .reviewAfter!
                                                  .toString(),
                                          prescriptionImage:
                                              previousAppointmentsModel
                                                          .previousAppointments![
                                                              index]
                                                          .prescriptionImage ==
                                                      null
                                                  ? " "
                                                  : previousAppointmentsModel
                                                      .previousAppointments![
                                                          index]
                                                      .prescriptionImage
                                                      .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: kCardColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        //! user image
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/icons/profile pic.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                        const HorizontalSpacingWidget(
                                            width: 10),
                                        SizedBox(
                                          width: 180.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              //! name
                                              Text(
                                                previousAppointmentsModel
                                                    .previousAppointments![
                                                        index]
                                                    .patientName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              //! pain
                                              Text(
                                                previousAppointmentsModel
                                                        .previousAppointments![
                                                            index]
                                                        .appoinmentfor1!
                                                        .isEmpty
                                                    ? previousAppointmentsModel
                                                        .previousAppointments![
                                                            index]
                                                        .appoinmentfor2!
                                                        .first
                                                        .symtoms
                                                        .toString()
                                                    : previousAppointmentsModel
                                                        .previousAppointments![
                                                            index]
                                                        .appoinmentfor1!
                                                        .first
                                                        .symtoms
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: kSubTextColor),
                                              ),
                                              //! date and time
                                              Row(
                                                children: [
                                                  Text(
                                                    "Token No : ${previousAppointmentsModel.previousAppointments![index].tokenNumber.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: kTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    " | ",
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: kTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    previousAppointmentsModel
                                                        .previousAppointments![
                                                            index]
                                                        .date
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: kTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const HorizontalSpacingWidget(
                                                      width: 8),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }
                  return Container();
                },
              )
            ],
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

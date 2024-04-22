// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GenerateToken/clinic_get_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_completed_appointments_model.dart';
import 'package:mediezy_doctor/Model/GetAppointments/get_all_appointments_model.dart';
import 'package:mediezy_doctor/Model/Profile/ProfileGetModel.dart';
import 'package:mediezy_doctor/Repositary/Api/DropdownClinicGetX/dropdown_clinic_getx.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllAppointments/get_all_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_dropdown_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/patient_image_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/get_all_completed_appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/AppointmentDetailsScreen/appointment_details_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/AuthenticationsScreens/LoginScreen/login_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/AboutUsScreen/about_us_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/ContactUsScreen/contact_us_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/Labs/lab_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MedicalShoppe/medical_shoppe_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/MyProfileScreen/my_profile_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/PreviousBookingScreen/previous_booking_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/SuggestionScreen/suggestion_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/T&CScreen/t&c_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/DrawerScreen/suggest_doctor/suggest_doctor_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/demo.dart/dropdown/dropdown_bloc.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with TickerProviderStateMixin {
  late ProfileGetModel profileGetModel;
  late ClinicGetModel clinicGetModel;
  late GetAllAppointmentsModel getAllAppointmentsModel;
  late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  late TabController tabController;

  // bool _isLoading = true;

  final HospitalController controller = Get.put(HospitalController());

  late int? selectedValue;
  var items = {
    'All': 0,
    'Schedule 1': 1,
    'Schedule 2': 2,
    'Schedule 3': 3,
  };

  @override
  void initState() {
    selectedValue = items['All'];
    BlocProvider.of<GetClinicBloc>(context).add(FetchGetClinic());
    BlocProvider.of<ProfileGetBloc>(context).add(FetchProfileGet());

    //selectedValue = items['All'];
    getUserName();
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 500), () {
      // setState(() {
      //   _isLoading = false;
      // });
    });
    // startPolling();
    super.initState();
  }

  Future<void> getUserName() async {
    log("date =${controller.formatDate()}");
    log("idex1 =${controller.initialIndex}");
    log("index 2 =${controller.selectedDate}");
    BlocProvider.of<GetAllAppointmentsBloc>(context).add(FetchAllAppointments(
      date: controller.formatDate(),
      clinicId: controller.initialIndex!,
      scheduleType: controller.scheduleIndex,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // int? selectedValue = items['Schedule 1'];
    return WillPopScope(
      onWillPop: () async {
        GeneralServices.instance
            .appCloseDialogue(context, "Are you want to Exit", () async {
          SystemNavigator.pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        //! tab bar
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kMainColor,
          // backgroundColor: Color(0xff69979d),
          actions: [
            SizedBox(
              height: 40.h,
              width: 100.w,
              child: Image.asset("assets/icons/mediezy logo small.png"),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              BlocBuilder<ProfileGetBloc, ProfileGetState>(
                builder: (context, state) {
                  if (state is ProfileGetLoaded) {
                    profileGetModel = BlocProvider.of<ProfileGetBloc>(context)
                        .profileGetModel;
                    return DrawerHeader(
                      decoration: BoxDecoration(color: kMainColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: PatientImageWidget(
                                patientImage: profileGetModel
                                            .doctorDetails!.first.docterImage ==
                                        null
                                    ? ""
                                    : profileGetModel
                                        .doctorDetails!.first.docterImage
                                        .toString(),
                                radius: 20),
                          ),
                          Text(
                            "Dr.${profileGetModel.doctorDetails!.first.firstname.toString()} ${profileGetModel.doctorDetails!.first.secondname.toString()}",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            profileGetModel.doctorDetails!.first.mediezyDoctorId
                                .toString(),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          Text(
                            "+91 ${profileGetModel.doctorDetails!.first.mobileNumber.toString()}",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              ListTile(
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => MyProfileScreen(
                                drFirstName: profileGetModel
                                    .doctorDetails!.first.firstname
                                    .toString(),
                                drSecondName: profileGetModel
                                    .doctorDetails!.first.secondname
                                    .toString(),
                                email: profileGetModel
                                    .doctorDetails!.first.emailID
                                    .toString(),
                                phNo: profileGetModel
                                    .doctorDetails!.first.mobileNumber
                                    .toString(),
                                about: profileGetModel
                                    .doctorDetails!.first.about
                                    .toString(),
                                hospitalName: profileGetModel
                                    .doctorDetails!.first.mainHospital
                                    .toString(),
                                clinicName: profileGetModel
                                    .doctorDetails!.first.clinics!
                                    .toList(),
                                specifications: profileGetModel
                                    .doctorDetails!.first.specifications!
                                    .toList(),
                                subSpecification: profileGetModel
                                    .doctorDetails!.first.subspecifications!
                                    .toList(),
                                drImage: profileGetModel
                                    .doctorDetails!.first.docterImage
                                    .toString(),
                              ))); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Labs'),
                trailing: const Icon(Icons.science),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LabScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Medical Store'),
                trailing: const Icon(Icons.medical_services_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicalShoppeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Previous Bookings'),
                trailing: const Icon(Icons.book_online_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreviousBookingScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Suggest doctor'),
                trailing: Image(
                    height: 20.h,
                    image: const AssetImage("assets/icons/doctor_icon.png")),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuggestDoctorScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Feedback'),
                trailing: const Icon(Icons.edit_note_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuggestionScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Terms & Conditions'),
                trailing: const Icon(Icons.assignment_outlined),
                onTap: () {
                  // Handle item 2 tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsandConditionsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('About Us'),
                trailing: const Icon(Icons.assignment_turned_in_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Contact Us'),
                trailing: const Icon(Icons.mail_outline_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Log out'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  GeneralServices.instance.appCloseDialogue(
                      context, "Are you sure to log out", () async {
                    final preferences = await SharedPreferences.getInstance();
                    await preferences.remove('token');
                    await preferences.remove('doctorName');
                    await preferences.remove('DoctorId');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  });
                },
              ),
            ],
          ),
        ),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileGetBloc, ProfileGetState>(
                builder: (context, state) {
                  if (state is ProfileGetLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    );
                  }
                  if (state is ProfileGetLoaded) {
                    profileGetModel = BlocProvider.of<ProfileGetBloc>(context)
                        .profileGetModel;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 70.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kMainColor,
                        // color: Color(0xff69979d),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Dr.${profileGetModel.doctorDetails!.first.firstname.toString()} ${profileGetModel.doctorDetails!.first.secondname.toString()}",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Manage Your Practice With Us",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              FadedScaleAnimation(
                                scaleDuration:
                                    const Duration(milliseconds: 400),
                                fadeDuration: const Duration(milliseconds: 400),
                                child: PatientImageWidget(
                                    patientImage: profileGetModel.doctorDetails!
                                                .first.docterImage ==
                                            null
                                        ? ""
                                        : profileGetModel
                                            .doctorDetails!.first.docterImage
                                            .toString(),
                                    radius: 35),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              // const VerticalSpacingWidget(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "Select Clinic",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                      ),
                      GetBuilder<HospitalController>(builder: (clx) {
                        return CustomDropDown(
                          width: 200.w,
                          value: controller.initialIndex,
                          items: controller.hospitalDetails!.map((e) {
                            return DropdownMenuItem(
                              value: e.clinicId.toString(),
                              child: Text(e.clinicName!),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            log(newValue!);
                            controller.dropdownValueChanging(
                                newValue, controller.initialIndex!);
                            BlocProvider.of<GetAllAppointmentsBloc>(context)
                                .add(FetchAllAppointments(
                              date: controller.formatDate(),
                              clinicId: controller.initialIndex!,
                              scheduleType: controller.scheduleIndex,
                            ));
                            // selectedValue.toString()
                            BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                    context)
                                .add(FetchAllCompletedAppointments(
                              date: controller.formatDate(),
                              clinicId: controller.initialIndex!,
                              scheduleType: controller.scheduleIndex,
                            ));
                          },
                        );
                      }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Schedule",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: kSubTextColor),
                      ),
                      //dropdown==============//
                      BlocBuilder<DropdownBloc, DropdownState>(
                        builder: (context, state) {
                          return CustomDropDown(
                            width: 140.w,
                            value: state.changValue,
                            items: items.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, int?> entry) {
                                  // Specify the return type
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.key),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              BlocProvider.of<DropdownBloc>(context).add(
                                  DropdownSelectEvent(
                                      dropdownSelectnvLalu: newValue!));
                              // dropdownValue = newValue!;
                              selectedValue = items[newValue];
                              BlocProvider.of<GetAllAppointmentsBloc>(context)
                                  .add(FetchAllAppointments(
                                date: controller.formatDate(),
                                clinicId: controller.initialIndex!,
                                scheduleType: controller.scheduleIndex,
                              ));
                              // selectedValue.toString()
                              BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                  context)
                                  .add(FetchAllCompletedAppointments(
                                date: controller.formatDate(),
                                clinicId: controller.initialIndex!,
                                scheduleType: controller.scheduleIndex,
                              ));
                            },
                          );
                        },
                      ),

                      const VerticalSpacingWidget(height: 2),
                      // _isLoading
                      //     ? Shimmer.fromColors(
                      //         baseColor: Colors.grey.shade300,
                      //         highlightColor: Colors.grey.shade100,
                      //         child: Container(
                      //           height: 40.h,
                      //           width: 140.w,
                      //           decoration: BoxDecoration(
                      //               color: kCardColor,
                      //               borderRadius: BorderRadius.circular(5),
                      //               border: Border.all(
                      //                   color: const Color(0xFF9C9C9C))),
                      //         ),
                      //       )
                      //     : BlocBuilder<DropdownBloc, DropdownState>(
                      //         builder: (context, state) {
                      //           return CustomDropDown(
                      //             width: 140.w,
                      //             value: state.changValue,
                      //             items: items.entries
                      //                 .map<DropdownMenuItem<String>>(
                      //                     (MapEntry<String, int?> entry) {
                      //               // Specify the return type
                      //               return DropdownMenuItem<String>(
                      //                 value: entry.key,
                      //                 child: Text(entry.key),
                      //               );
                      //             }).toList(),
                      //             onChanged: (String? newValue) {
                      //               BlocProvider.of<DropdownBloc>(context).add(
                      //                   DropdownSelectEvent(
                      //                       dropdownSelectnvLalu: newValue!));
                      //               // dropdownValue = newValue!;
                      //               selectedValue = items[newValue];
                      //               BlocProvider.of<GetAllAppointmentsBloc>(
                      //                       context)
                      //                   .add(FetchAllAppointments(
                      //                       date: formatDate(),
                      //                       clinicId: selectedClinicId,
                      //                       scheduleType:
                      //                           selectedValue.toString()));
                      //               BlocProvider.of<
                      //                           GetAllCompletedAppointmentsBloc>(
                      //                       context)
                      //                   .add(FetchAllCompletedAppointments(
                      //                       date: formatDate(),
                      //                       clinicId: selectedClinicId,
                      //                       scheduleType:
                      //                           selectedValue.toString()));
                      //             },
                      //           );
                      //         },
                      //       ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Your Appointments",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: kSubTextColor),
                ),
              ),
              EasyDateTimeLine(
                initialDate: controller.selectedDate,
                disabledDates: _getDisabledDates(),
                onDateChange: (date) {
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(date);
                  controller.selectedDate = date;
                  BlocProvider.of<GetAllAppointmentsBloc>(context)
                      .add(
                    FetchAllAppointments(
                        date: formattedDate,
                        clinicId: controller.initialIndex!,
                        scheduleType: controller.scheduleIndex),
                  );
                  BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                      context)
                      .add(
                    FetchAllCompletedAppointments(
                        date: formattedDate,
                        clinicId: controller.initialIndex!,
                        scheduleType: controller.scheduleIndex),
                  );
                },
                activeColor: kMainColor,
                headerProps: const EasyHeaderProps(
                  selectedDateFormat: SelectedDateFormat.monthOnly,
                ),
                dayProps: EasyDayProps(
                  height: 50.h,
                  width: 50.w,
                  dayStructure: DayStructure.dayNumDayStr,
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)),
                        border: Border.all(color: kMainColor)),
                    dayNumStyle:
                    TextStyle(fontSize: 18.0, color: kTextColor),
                  ),
                  activeDayStyle: DayStyle(
                    borderRadius: 10,
                    dayNumStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: kCardColor),
                  ),
                  activeDayStrStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: kCardColor),
                ),
              ),
              const VerticalSpacingWidget(height: 5),
              BlocBuilder<GetAllAppointmentsBloc, GetAllAppointmentsState>(
                  builder: (context, state) {
                if (state is GetAllAppointmentsLoading) {
                  // return _shimmerLoading();
                }
                if (state is GetAllAppointmentsError) {
                  return const Center(
                    child: Text("Something Went Wrong"),
                  );
                }
                if (state is GetAllAppointmentsLoaded) {
                  getAllAppointmentsModel =
                      BlocProvider.of<GetAllAppointmentsBloc>(context)
                          .getAllAppointmentsModel;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // Set the background color of the tab bar
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius
                            ),
                            // color: kCardColor,
                            child: TabBar(
                              controller: tabController,
                              physics: const ClampingScrollPhysics(),
                              dividerColor: kCardColor,
                              unselectedLabelColor: kTextColor,
                              onTap: (d){
                                log("${tabController.index}");
                                if(tabController.index==0){
                                  BlocProvider.of<GetAllAppointmentsBloc>(context)
                                      .add(
                                    FetchAllAppointments(
                                        date: controller.formatDate(),
                                        clinicId: controller.initialIndex!,
                                        scheduleType: controller.scheduleIndex),
                                  );
                                }else{
                                  BlocProvider.of<GetAllCompletedAppointmentsBloc>(
                                      context)
                                      .add(
                                    FetchAllCompletedAppointments(
                                        date: controller.formatDate(),
                                        clinicId: controller.initialIndex!,
                                        scheduleType: controller.scheduleIndex),
                                  );
                                }
                              },
                              unselectedLabelStyle: TextStyle(
                                fontSize: 12.sp,
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kMainColor),
                              // color: Color(0xff8ebcbf)),
                              tabs: [
                                //! up coming
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Upcoming",
                                      ),
                                    ),
                                  ),
                                ),
                                //! completed
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("Completed"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              getAllAppointmentsModel.appointments!.isEmpty
                                  ? const Center(
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/No Appointment to day-01.png")))
                                  : SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Text(
                                              "Patient Count (${getAllAppointmentsModel.appointments!.length.toString()})",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: getAllAppointmentsModel
                                                .appointments!.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const VerticalSpacingWidget(
                                                        height: 3),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5.h, 0, 2.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            AppointmentDetailsScreen(
                                                          length:
                                                              getAllAppointmentsModel
                                                                  .appointments!
                                                                  .length,
                                                          position: index,
                                                          appointmentsDetails:
                                                              getAllAppointmentsModel
                                                                  .appointments!,
                                                          tokenId:
                                                              getAllAppointmentsModel
                                                                  .appointments![
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: AppointmentCardWidget(
                                                    tokenNumber:
                                                        getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .tokenNumber
                                                            .toString(),
                                                    patientImage:
                                                        getAllAppointmentsModel
                                                                    .appointments![
                                                                        index]
                                                                    .userImage ==
                                                                null
                                                            ? ""
                                                            : getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .userImage
                                                                .toString(),
                                                    patientName:
                                                        getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .patientName
                                                            .toString(),
                                                    time:
                                                        getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .startingtime
                                                            .toString(),
                                                    mediezyId: getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .mediezyPatientId ==
                                                            null
                                                        ? ""
                                                        : getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .mediezyPatientId
                                                            .toString(),
                                                    mainSymptoms:
                                                        getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .mainSymptoms!
                                                                .isEmpty
                                                            ? getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .otherSymptoms!
                                                                .first
                                                                .symtoms
                                                                .toString()
                                                            : getAllAppointmentsModel
                                                                .appointments![
                                                                    index]
                                                                .mainSymptoms!
                                                                .first
                                                                .symtoms
                                                                .toString(),
                                                    onlineStatus:
                                                        getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .onlineStatus
                                                            .toString(),
                                                    reachedStatus:
                                                        getAllAppointmentsModel
                                                            .appointments![
                                                                index]
                                                            .isReached
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                              //! completed
                              BlocBuilder<GetAllCompletedAppointmentsBloc,
                                      GeAllCompletedAppointmentsState>(
                                  builder: (context, state) {
                                if (state
                                    is GetAllCompletedAppointmentsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kMainColor,
                                    ),
                                  );
                                }
                                if (state is GetAllCompletedAppointmentsError) {
                                  return const Center(
                                    child: Text("Something Went Wrong"),
                                  );
                                }
                                if (state
                                    is GetAllCompletedAppointmentsLoaded) {
                                  getAllCompletedAppointmentsModel = BlocProvider
                                          .of<GetAllCompletedAppointmentsBloc>(
                                              context)
                                      .getAllCompletedAppointmentsModel;
                                }
                                return getAllCompletedAppointmentsModel
                                    .appointments!.isEmpty
                                    ? const Center(
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/No completed Appointment to day-01-01.png")))
                                    : SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Patient Count (${getAllCompletedAppointmentsModel.appointments!.length.toString()})",
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount:
                                        getAllCompletedAppointmentsModel
                                            .appointments!.length,
                                        separatorBuilder: (BuildContext
                                        context,
                                            int index) =>
                                        const VerticalSpacingWidget(
                                            height: 3),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(
                                                0, 5.h, 0, 2.h),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            GetAllCompletedAppointmentDetailsScreen(
                                                              tokenId: getAllCompletedAppointmentsModel
                                                                  .appointments![
                                                              index]
                                                                  .id
                                                                  .toString(),
                                                            )));
                                              },
                                              child:
                                              AppointmentCardWidget(
                                                tokenNumber:
                                                getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .tokenNumber
                                                    .toString(),
                                                patientImage: getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .userImage ==
                                                    null
                                                    ? ""
                                                    : getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .userImage
                                                    .toString(),
                                                patientName:
                                                getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .patientName
                                                    .toString(),
                                                time:
                                                getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .startingtime
                                                    .toString(),
                                                mediezyId: getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .mediezyPatientId ==
                                                    null
                                                    ? ""
                                                    : getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .mediezyPatientId
                                                    .toString(),
                                                // mainSymptoms: "",
                                                // mainSymptoms: getAllCompletedAppointmentsModel
                                                //     .appointments![
                                                // index]
                                                //     .otherSymptoms!
                                                //     .isEmpty
                                                //     ? getAllCompletedAppointmentsModel
                                                //     .appointments![
                                                // index]
                                                //     .mainSymptoms!
                                                //     .mainsymptoms
                                                //     .toString()
                                                //     : getAllCompletedAppointmentsModel
                                                //     .appointments![
                                                // index]
                                                //     .otherSymptoms!
                                                //     .first
                                                //     .symtoms
                                                //     .toString(),

                                                mainSymptoms: getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .mainSymptoms ==
                                                    null
                                                    ? getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .otherSymptoms!
                                                    .first
                                                    .symtoms
                                                    .toString()
                                                    : getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .mainSymptoms!
                                                    .mainsymptoms
                                                    .toString(),
                                                onlineStatus:
                                                getAllCompletedAppointmentsModel
                                                    .appointments![
                                                index]
                                                    .onlineStatus
                                                    .toString(),
                                                reachedStatus: "",
                                                // reachedStatus: getAllCompletedAppointmentsModel
                                                //                 .appointments![
                                                //                     index]
                                                //                 .isReached ==
                                                //             1 ||
                                                //         getAllCompletedAppointmentsModel
                                                //                 .appointments![
                                                //                     index]
                                                //                 .isReached ==
                                                //             null
                                                //     ? ""
                                                //     : "",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmerLoading() {
    return SizedBox(
      // color: Colors.yellow,
      height: 430.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const VerticalSpacingWidget(height: 10),
              Container(
                width: 130.w,
                height: 20.h,
                color: Colors.white,
              ),
              // const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 90.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                  Container(
                    width: 70.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                ],
              ),
              // const VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // VerticalSpacingWidget(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 180.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 8,),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}

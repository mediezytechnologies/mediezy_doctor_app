import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/BookAppointment/book_appointment_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetSymptoms/get_symptoms_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/custom_textfield.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Data/app_data.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class FillPatientDetailsScreen extends StatefulWidget {
  const FillPatientDetailsScreen(
      {super.key,
      required this.date,
      required this.tokenNumber,
      required this.tokenTime,
      required this.scheduleType,
      // required this.endingTime,
      required this.clinicId});

  final DateTime date;
  final String tokenNumber;
  final String tokenTime;

  // final String endingTime;
  final String clinicId;
  final String scheduleType;

  @override
  State<FillPatientDetailsScreen> createState() =>
      _FillPatientDetailsScreenState();
}

class _FillPatientDetailsScreenState extends State<FillPatientDetailsScreen> {
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController patientAgeController = TextEditingController();
  final TextEditingController patientContactNumberController =
      TextEditingController();
  final TextEditingController appointmentForController =
      TextEditingController();
  final TextEditingController daysController = TextEditingController();

  final FocusNode patientContactNumberFocusController = FocusNode();

  String dropdownValue = 'Male';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if there's any selected value from previous screen
    String? selectedValue =
        ModalRoute.of(context)!.settings.arguments as String?;
    if (selectedValue != null) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  int selectedStart = -1;
  int selectedCome = -1;
  int selectedSymptomsID = -1;
  String regularMedicine = "No";
  late GetSymptomsModel getSymptomsModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<GetSymptomsBloc>(context).add(FetchSymptoms());
    super.initState();
  }

  List<int> selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.scheduleType);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill Patient Details"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: CommonButtonWidget(
            title: "Book Token",
            onTapFunction: () {
              if (patientNameController.text.isEmpty) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please fill patient name");
              } else if (patientAgeController.text.isEmpty) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please fill patient age");
              } else if (patientContactNumberController.text.isEmpty) {
                GeneralServices.instance.showErrorMessage(
                    context, "Please fill patient contact number");
              } else if (selectedSymptoms.isEmpty) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please select symptoms");
              } else if (selectedStart == -1) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please select When it's comes");
              } else if (selectedCome == -1) {
                GeneralServices.instance
                    .showErrorMessage(context, "Please select How Frequently");
              } else {
                BlocProvider.of<BookAppointmentBloc>(context).add(
                  PassBookAppointMentEvent(
                    clinicId: widget.clinicId,
                    patientName: patientNameController.text,
                    date: formatDate(),
                    regularmedicine: regularMedicine.toString(),
                    whenitcomes: selectedStart == 3
                        ? "${daysController.text} days before"
                        : deceaseStartingTime[selectedStart],
                    whenitstart: deceaseRepeats[selectedCome],
                    tokenTime: widget.tokenTime,
                    tokenNumber: widget.tokenNumber,
                    gender: dropdownValue,
                    age: patientAgeController.text,
                    mobileNo: patientContactNumberController.text,
                    appoinmentfor1: appointmentForController.text.isEmpty
                        ? []
                        : [appointmentForController.text],
                    appoinmentfor2: selectedSymptoms,
                    scheduleType: widget.scheduleType,
                    // endTokenTime: widget.endingTime,
                  ),
                );
              }
            }),
      ),
      body: BlocListener<BookAppointmentBloc, BookAppointmentState>(
        listener: (context, state) {
          if (state is BookAppointmentLoaded) {
            showToastMessage("Book Token Successfully");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const BottomNavigationControlWidget()),
                (route) => false);
          }
          if (state is BookAppointmentError) {
            showToastMessage("Something went wrong\nTry again later");
          }
        },
        child: BlocBuilder<GetSymptomsBloc, GetSymptomsState>(
          builder: (context, state) {
            if (state is GetSymptomsLoaded) {
              getSymptomsModel =
                  BlocProvider.of<GetSymptomsBloc>(context).getSymptomsModel;
              return FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpacingWidget(height: 20),
                          //! name
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Patient Name",
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 10),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Age",
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize:
                                            size.width > 450 ? 11.sp : 14.sp),
                                    autofocus: true,
                                    cursorColor: kMainColor,
                                    controller: patientNameController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Patient name is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      hintStyle: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                      hintText: "Enter Patient Name",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 10),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize:
                                            size.width > 450 ? 12.sp : 14.sp),
                                    cursorColor: kMainColor,
                                    controller: patientAgeController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 3,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 2) {
                                        return "Age is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      counterText: "",
                                      hintStyle: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                      hintText: "25 age",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! phone number
                          Text(
                            "Contact Number",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize:
                                            size.width > 450 ? 12.sp : 14.sp),
                                    cursorColor: kMainColor,
                                    controller: patientContactNumberController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 10,
                                    focusNode:
                                        patientContactNumberFocusController,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 10) {
                                        return "Phone number is missing";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      counterText: "",
                                      hintStyle: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                      hintText: "Enter patient Phone number",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 10),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: size.width > 450 ? 45.h : 40.h,
                                  color: kCardColor,
                                  child: DropdownButton<String>(
                                    underline:
                                        const SizedBox(), // Set underline to null
                                    value: dropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    icon: Padding(
                                      padding: size.width > 450
                                          ? EdgeInsets.only(top: 10.h)
                                          : EdgeInsets.symmetric(
                                              vertical: 10.h,
                                              horizontal: 10.w,
                                            ),
                                      child: const Icon(Icons.arrow_drop_down),
                                    ), // Set the dropdown icon
                                    iconSize: size.width > 450
                                        ? 30.0
                                        : 24.0, // Adjust icon size if needed
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: size.width > 450
                                              ? EdgeInsets.only(
                                                  top: 10.h, left: 30.w)
                                              : EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 10.w,
                                                ),
                                          child: Text(
                                            value,
                                            style: size.width > 450
                                                ? blackTabMainText
                                                : blackMainText,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Text(
                            "Appointment for",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          const VerticalSpacingWidget(height: 10),
                          CustomTextField(
                              controller: appointmentForController,
                              hintText: "eg. Chest pain, Body ache, etc."),
                          const VerticalSpacingWidget(height: 10),
                          Wrap(
                            children: List.generate(
                              getSymptomsModel.symptoms!.length,
                              (index) => Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        if (selectedSymptoms.contains(
                                            getSymptomsModel
                                                .symptoms![index].id!)) {
                                          selectedSymptoms.remove(
                                              getSymptomsModel
                                                  .symptoms![index].id!);
                                        } else {
                                          selectedSymptoms.add(getSymptomsModel
                                              .symptoms![index].id!);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedSymptoms.contains(
                                                getSymptomsModel
                                                    .symptoms![index].id!)
                                            ? Colors.grey
                                            : kCardColor,
                                        border: Border.all(
                                            color: kMainColor, width: 1),
                                      ),
                                      margin: const EdgeInsets.all(3.0),
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        getSymptomsModel
                                            .symptoms![index].symtoms
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                size.width > 450 ? 9.sp : 11.sp,
                                            color: selectedSymptoms.contains(
                                                    getSymptomsModel
                                                        .symptoms![index].id!)
                                                ? Colors.white
                                                : kTextColor),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          Text(
                            "When it's comes",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              deceaseStartingTime.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    selectedStart =
                                        selectedStart == index ? -1 : index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedStart == index
                                        ? Colors.grey
                                        : kCardColor,
                                    border:
                                        Border.all(color: kMainColor, width: 1),
                                  ),
                                  margin: const EdgeInsets.all(3.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    deceaseStartingTime[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width > 450 ? 9.sp : 11.sp,
                                      color: selectedStart == index
                                          ? Colors.white
                                          : kTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VerticalSpacingWidget(height: 2.h),
                          if (selectedStart == 3)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "How many days",
                                  style:
                                      size.width > 450 ? greyTabMain : greyMain,
                                ),
                                const VerticalSpacingWidget(height: 5),
                                SizedBox(
                                  height: 40.h,
                                  child: TextFormField(
                                    cursorColor: kMainColor,
                                    controller: daysController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: size.width > 450
                                          ? greyTab10B600
                                          : grey13B600,
                                      hintText: "10 days",
                                      filled: true,
                                      fillColor: kCardColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const VerticalSpacingWidget(height: 10),
                          Text(
                            "How Frequently",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              deceaseRepeats.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    selectedCome =
                                        selectedCome == index ? -1 : index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedCome == index
                                        ? Colors.grey
                                        : kCardColor,
                                    border:
                                        Border.all(color: kMainColor, width: 1),
                                  ),
                                  margin: const EdgeInsets.all(3.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    deceaseRepeats[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.width > 450 ? 9.sp : 11.sp,
                                      color: selectedCome == index
                                          ? Colors.white
                                          : kTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Using any regular medicines?",
                                style: size.width > 450
                                    ? greyTab10B600
                                    : grey13B600,
                              ),
                              const HorizontalSpacingWidget(width: 10),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<String>(
                                            activeColor: kMainColor,
                                            value: "Yes",
                                            groupValue: regularMedicine,
                                            onChanged: (value) {
                                              setState(() {
                                                regularMedicine = value!;
                                              });
                                            }),
                                        Text(
                                          "Yes",
                                          style: size.width > 450
                                              ? blackTab9B400
                                              : black12B500,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                            activeColor: kMainColor,
                                            value: "No",
                                            groupValue: regularMedicine,
                                            onChanged: (value) {
                                              setState(() {
                                                regularMedicine = value!;
                                              });
                                            }),
                                        Text(
                                          "No",
                                          style: size.width > 450
                                              ? blackTab9B400
                                              : black12B500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Appointment on",
                            style: size.width > 450 ? greyTabMain : greyMain,
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Row(
                            children: [
                              Text(
                                DateFormat("dd-MM-yyy").format(widget.date),
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                              Text(
                                " | ",
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                              Text(
                                widget.tokenTime,
                                style: size.width > 450
                                    ? blackTabMainText
                                    : blackMainText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  String formatDate() {
    String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(widget.date);
    return formattedSelectedDate;
  }

  @override
  void dispose() {
    super.dispose();
    patientNameController.dispose();
    patientAgeController.dispose();
    appointmentForController.dispose();
    patientContactNumberController.dispose();
  }

  //* to show toast
  showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.redAccent,
        fontSize: 16.sp);
  }
}

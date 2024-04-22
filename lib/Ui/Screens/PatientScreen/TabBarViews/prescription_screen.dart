import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/GetPrescription/get_prescription_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/prescription_view_screen.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  late GetPrescriptionModel getPrescriptionModel;

  @override
  void initState() {
    BlocProvider.of<GetPrescriptionBloc>(context).add(FetchGetPrescription(
        patientId: widget.patientId, userId: widget.userId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GetPrescriptionBloc, GetPrescriptionState>(
      builder: (context, state) {
        if (state is GetPrescriptionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetPrescriptionError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        if (state is GetPrescriptionLoaded) {
          getPrescriptionModel = BlocProvider.of<GetPrescriptionBloc>(context)
              .getPrescriptionModel;

          if (getPrescriptionModel.documentData == null) {
            return Center(
              child: Image(
                image: const AssetImage("assets/images/no_data___.jpg"),
                height: 300.h,
                width: 300.w,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: getPrescriptionModel.documentData!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const VerticalSpacingWidget(height: 5),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => ViewFileWidget(
                                    viewFile: getPrescriptionModel
                                        .documentData![index].documentPath
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: kScaffoldColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage(
                                        'assets/icons/file.png',
                                      ),
                                    ),
                                    Text("View File")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const VerticalSpacingWidget(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Patient :",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                  ),
                                  Text(
                                    getPrescriptionModel
                                        .documentData![index].patient
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Record Date :",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    getPrescriptionModel.documentData![index]
                                        .patientPrescription!.first.date
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Prescribed by :",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Dr ${getPrescriptionModel.documentData![index].patientPrescription!.first.doctorName.toString()}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(
                                "Last updated - ${getPrescriptionModel.documentData![index].hoursAgo}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kSubTextColor),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => PrescriptionViewScreen(
                                        name: getPrescriptionModel
                                            .documentData![index].patient
                                            .toString(),
                                        patientId: getPrescriptionModel
                                            .documentData![index].patientId
                                            .toString(),
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 190.w, bottom: 5.h),
                                  child: Text(
                                    "View",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/health_records_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/AllHealthRecords/all_health_records_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class AllHealthRecordScreen extends StatefulWidget {
  const AllHealthRecordScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<AllHealthRecordScreen> createState() => _AllHealthRecordScreenState();
}

class _AllHealthRecordScreenState extends State<AllHealthRecordScreen> {
  late HealthRecordsModel healthRecordsModel;

  @override
  void initState() {
    BlocProvider.of<AllHealthRecordsBloc>(context).add(FetchAllHealthRecords(
        patientId: widget.patientId, userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final mWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AllHealthRecordsBloc, AllHealthRecordsState>(
      builder: (context, state) {
        if (state is AllHealthRecordsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AllHealthRecordsError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        if (state is AllHealthRecordsLoaded) {
          healthRecordsModel =
              BlocProvider.of<AllHealthRecordsBloc>(context).healthRecordsModel;
          if (healthRecordsModel.documentData == null) {
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
              child:   ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount:
                  healthRecordsModel.documentData!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const VerticalSpacingWidget(height: 3),
                  itemBuilder: (context, index) {
                    var allDocument =
                    healthRecordsModel.documentData![index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 5.h, 8.w, 2.h),
                      child: Container(
                        width: double.infinity,
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
                                      viewFile:
                                      healthRecordsModel
                                          .documentData![index]
                                          .documentPath
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 90.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    color: kScaffoldColor,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
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
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        allDocument.type == 1
                                            ? "Lab report"
                                            : (allDocument.type == 2)
                                            ? "Prescription"
                                            : (allDocument.type == 3)
                                            ? "Discharge summary"
                                            : "Scan Report",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const HorizontalSpacingWidget(
                                          width: 10),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Patient :",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: kSubTextColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        healthRecordsModel
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
                                        allDocument.type == 1
                                            ? "Test name : "
                                            : (allDocument.type == 4)
                                            ? "Scan name : "
                                            : "Doctor name : ",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: kSubTextColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 140.w,
                                        child: Text(
                                          allDocument.labReport != null &&
                                              allDocument.labReport!
                                                  .isNotEmpty
                                              ? "${allDocument.labReport!.first.testName}"
                                              : allDocument.patientPrescription !=
                                              null &&
                                              allDocument
                                                  .patientPrescription!
                                                  .isNotEmpty
                                              ? "Dr ${allDocument.patientPrescription!.first.doctorName}"
                                              : allDocument.dischargeSummary !=
                                              null &&
                                              allDocument
                                                  .dischargeSummary!
                                                  .isNotEmpty
                                              ? "Dr ${allDocument.dischargeSummary!.first.doctorName}"
                                              : allDocument.scanReport !=
                                              null &&
                                              allDocument
                                                  .scanReport!
                                                  .isNotEmpty
                                              ? "${allDocument.scanReport!.first.admittedFor}"
                                              : 'Doctor Name Not Available',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Record date :",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: kSubTextColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        healthRecordsModel
                                            .documentData![index].date
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
                                  Text(
                                    "Last updated - ${healthRecordsModel.documentData![index].hoursAgo.toString()}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

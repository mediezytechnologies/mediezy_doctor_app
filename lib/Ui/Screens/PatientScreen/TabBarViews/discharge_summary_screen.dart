import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/discharge_summary_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/DischargeSummary/discharge_summary_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class DischargeSummaryScreen extends StatefulWidget {
  const DischargeSummaryScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<DischargeSummaryScreen> createState() => _DischargeSummaryScreenState();
}

class _DischargeSummaryScreenState extends State<DischargeSummaryScreen> {
  late DischargeSummaryModel dischargeSummaryModel;

  @override
  void initState() {
    BlocProvider.of<DischargeSummaryBloc>(context).add(
        FetchGetUploadedDischargeSummary(
            patientId: widget.patientId, userId: widget.userId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //! discharge summary
    return BlocBuilder<DischargeSummaryBloc, DischargeSummaryState>(
      builder: (context, state) {
        if (state is DischargeSummaryLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          );
        }
        if (state is DischargeSummaryError) {
          return Center(
            child: Image(
              image:
                  const AssetImage("assets/images/something went wrong-01.png"),
              height: 200.h,
              width: 200.w,
            ),
          );
        }
        if (state is DischargeSummaryLoaded) {
          dischargeSummaryModel = BlocProvider.of<DischargeSummaryBloc>(context)
              .dischargeSummaryModel;
          return dischargeSummaryModel.documentData == null
              ? Image.asset("assets/images/no_data.jpg")
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: dischargeSummaryModel.documentData!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const VerticalSpacingWidget(height: 5),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
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
                                    viewFile: dischargeSummaryModel
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
                                        'assets/icons/Lab report.png',
                                      ),
                                    ),
                                    Text("View File")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const HorizontalSpacingWidget(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Patient : ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    dischargeSummaryModel
                                        .documentData![index].patient!
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
                                    "Record Date : ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    dischargeSummaryModel.documentData![index]
                                        .dischargeSummary!.first.date
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
                                    "Doctor name : ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Dr ${dischargeSummaryModel.documentData![index].dischargeSummary!.first.doctorName.toString()}",
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
                                    "Hospital name : ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    dischargeSummaryModel.documentData![index]
                                        .dischargeSummary!.first.hospitalName
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
                                    "Admitted for : ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: kSubTextColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    dischargeSummaryModel.documentData![index]
                                        .dischargeSummary!.first.admittedFor
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
                                "Last updated - ${dischargeSummaryModel.documentData![index].hoursAgo}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kSubTextColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const VerticalSpacingWidget(height: 5),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        }
        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/GetUploadedScanReportModel.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/ScanReport/scan_report_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class ScanningReportScreen extends StatefulWidget {
  const ScanningReportScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<ScanningReportScreen> createState() => _ScanningReportScreenState();
}

class _ScanningReportScreenState extends State<ScanningReportScreen> {
  late GetUploadedScanReportModel getUploadedScanReportModel;

  @override
  void initState() {
    BlocProvider.of<ScanReportBloc>(context).add(FetchGetUploadedScanReport(
        patientId: widget.patientId, userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ScanReportBloc, ScanReportState>(
      builder: (context, state) {
        if (state is ScanReportLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ScanReportError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        if (state is ScanReportLoaded) {
          getUploadedScanReportModel = BlocProvider.of<ScanReportBloc>(context)
              .getUploadedScanReportModel;
          if (getUploadedScanReportModel.documentData == null) {
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
                  itemCount: getUploadedScanReportModel.documentData!.length,
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
                                    viewFile: getUploadedScanReportModel
                                        .documentData![index].documentPath
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.width > 450 ? 100.h : 90.h,
                                width: size.width > 450 ? 60.w : 80.w,
                                decoration: BoxDecoration(
                                  color: kScaffoldColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      height: 30.h,
                                      width: 30.w,
                                      image: const AssetImage(
                                        'assets/icons/Lab report.png',
                                      ),
                                    ),
                                    Text("View File",
                                        style: size.width > 450
                                            ? blackTab9B400
                                            : black12B500)
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
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    getUploadedScanReportModel
                                        .documentData![index].patient!
                                        .toString(),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Record Date : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    getUploadedScanReportModel
                                        .documentData![index]
                                        .scanReport!
                                        .first
                                        .date
                                        .toString(),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Doctor name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Dr ${getUploadedScanReportModel.documentData![index].scanReport!.first.doctorName.toString()}",
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Center name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    getUploadedScanReportModel
                                        .documentData![index]
                                        .scanReport!
                                        .first
                                        .labName
                                        .toString(),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Scan test name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    getUploadedScanReportModel
                                        .documentData![index]
                                        .scanReport!
                                        .first
                                        .testName
                                        .toString(),
                                    style: size.width > 450
                                        ? blackTabMainText
                                        : blackMainText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(
                                "Last updated - ${getUploadedScanReportModel.documentData![index].hoursAgo}",
                                style:
                                    size.width > 450 ? greyTabMain : greyMain,
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

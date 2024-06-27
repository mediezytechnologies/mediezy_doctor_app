import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/lab_report_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/LabReport/lab_report_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class LabReportScreen extends StatefulWidget {
  const LabReportScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<LabReportScreen> createState() => _LabReportScreenState();
}

class _LabReportScreenState extends State<LabReportScreen> {
  late LabReportModel labReportModel;

  @override
  void initState() {
    BlocProvider.of<LabReportBloc>(context).add(
        FetchLabReport(patientId: widget.patientId, userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<LabReportBloc, LabReportState>(
      builder: (context, state) {
        if (state is LabReportLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LabReportError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        }
        if (state is LabReportLoaded) {
          labReportModel =
              BlocProvider.of<LabReportBloc>(context).labReportModel;
          if (labReportModel.documentData == null) {
            return Center(
              child: Image(
                image: const AssetImage("assets/images/icone.png"),
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
                  itemCount: labReportModel.documentData!.length,
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
                                    viewFile: labReportModel
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
                                    labReportModel.documentData![index].patient!
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
                                    labReportModel.documentData![index]
                                        .labReport!.first.date
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
                                    "Dr ${labReportModel.documentData![index].labReport!.first.doctorName.toString()}",
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
                                    "Lab name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    labReportModel.documentData![index]
                                        .labReport!.first.labName
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
                                    "Lab test name : ",
                                    style: size.width > 450
                                        ? greyTabMain
                                        : greyMain,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    labReportModel.documentData![index]
                                        .labReport!.first.testName
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
                                "Last updated - ${labReportModel.documentData![index].hoursAgo}",
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

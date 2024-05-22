import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/time_line_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/TimeLine/time_line_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class ViewInTimeLineScreen extends StatefulWidget {
  const ViewInTimeLineScreen(
      {super.key,
      required this.name,
      required this.patientId,
      required this.userId});

  final String name;
  final String patientId;
  final String userId;

  @override
  State<ViewInTimeLineScreen> createState() => _ViewInTimeLineScreenState();
}

class _ViewInTimeLineScreenState extends State<ViewInTimeLineScreen> {
  late TimeLineModel timeLineModel;

  @override
  void initState() {
    BlocProvider.of<TimeLineBloc>(context)
        .add(FetchTimeLine(patientId: widget.patientId, userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: BlocBuilder<TimeLineBloc, TimeLineState>(
        builder: (context, state) {
          if (state is TimeLineLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TimeLineError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is TimeLineLoaded) {
            timeLineModel =
                BlocProvider.of<TimeLineBloc>(context).timeLineModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "Test Reports (${timeLineModel.timeLine!.length})",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: timeLineModel.timeLine!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const VerticalSpacingWidget(height: 3),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: kMainColor,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 1,
                                        color: kMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const HorizontalSpacingWidget(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(timeLineModel
                                            .timeLine![index].labReport![0].date
                                            .toString()),
                                        HorizontalSpacingWidget(width: 5.w),
                                        const Text(
                                          "|",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        HorizontalSpacingWidget(width: 5.w),
                                        const Text(
                                          "Source : ",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          timeLineModel.timeLine![index]
                                              .labReport![0].labName
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ViewFileWidget(
                                                      viewFile: timeLineModel
                                                          .timeLine![index]
                                                          .documentPath
                                                          .toString(),
                                                    )));
                                      },
                                      child: Container(
                                        height: mHeight * .05,
                                        width: mWidth * .85,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                timeLineModel.timeLine![index]
                                                    .labReport![0].testName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 17,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
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
      ),
    );
  }
}

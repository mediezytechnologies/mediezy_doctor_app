import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/ScheduleToken/custom_tooltip.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class ScheduleHelpScreen extends StatefulWidget {
  const ScheduleHelpScreen({Key? key, required this.clinicName})
      : super(key: key);
  final String clinicName;

  @override
  _ScheduleHelpScreenState createState() => _ScheduleHelpScreenState();
}

class _ScheduleHelpScreenState extends State<ScheduleHelpScreen> {
  final List<String> _days1 = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  void _handleCheckboxChange(String label, bool newValue) {
    setState(() {
      checkboxData[label] = newValue;
    });
    // saveCheckboxData(label, newValue);
  }

  final TooltipController _controller = TooltipController();
  bool done = false;

  @override
  void initState() {
    _controller.onDone(() {
      setState(() {
        done = true;
      });
    });

    super.initState();
  }

  Map<String, bool> checkboxData = {
    'Sunday': true,
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': true,
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      // overlayColor: Colors.red.withOpacity(.4),
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 1000),
      controller: _controller,
      startWhen: (initializedWidgetLength) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return initializedWidgetLength == 3 && !done;
      },
      preferredOverlay: GestureDetector(
        onTap: () {
          _controller.dismiss();
          //move the overlay forward or backwards, or dismiss the overlay
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blue.withOpacity(.2),
        ),
      ),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Help",
            style: TextStyle(
                fontSize: 18.sp, fontWeight: FontWeight.bold, color: kTextColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OverlayTooltipItem(
                    displayIndex: 0,
                    tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: MTooltip(
                          title: 'select clinic', controller: controller),
                    ),
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
                        Container(
                          height: 40.h,
                          width: 195.w,
                          decoration: BoxDecoration(
                              color: kCardColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xFF9C9C9C))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your clinic"),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  OverlayTooltipItem(
                    displayIndex: 1,
                    tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: MTooltip(
                          title: 'select schedule', controller: controller),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Schedule",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kSubTextColor),
                        ),
                        Container(
                          height: 40.h,
                          width: 145.w,
                          decoration: BoxDecoration(
                              color: kCardColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xFF9C9C9C))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Schedule 1"),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OverlayTooltipItem(
                    displayIndex: 2,
                    tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child:
                          MTooltip(title: "start date", controller: controller),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kSubTextColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                IconlyLight.calendar,
                                color: kMainColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "24-04-2024",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kTextColor),
                        ),
                      ],
                    ),
                  ),
                  OverlayTooltipItem(
                    displayIndex: 3,
                    tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child:
                          MTooltip(title: 'End date', controller: controller),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kSubTextColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                IconlyLight.calendar,
                                color: kMainColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "30-04-2024",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: kTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              //! select starting and ending time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! starting time
                  OverlayTooltipItem(
                    displayIndex: 4,
                    tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child:
                          MTooltip(title: 'start time', controller: controller),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Starting Time",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kSubTextColor),
                            ),
                            Icon(
                              IconlyLight.timeCircle,
                              color: kMainColor,
                            ),
                          ],
                        ),
                        const VerticalSpacingWidget(height: 5),
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          height: 35.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: kScaffoldColor,
                              border: Border.all(color: kMainColor),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              "11:00 AM",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //! ending time
                  OverlayTooltipItem(
                      displayIndex: 5,
                      tooltip: (controller) => Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: MTooltip(
                                title: 'ending time', controller: controller),
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ending Time",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kSubTextColor),
                              ),
                              Icon(
                                IconlyLight.timeCircle,
                                color: kMainColor,
                              ),
                            ],
                          ),
                          const VerticalSpacingWidget(height: 5),
                          Container(
                            height: 35.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: kScaffoldColor,
                                border: Border.all(color: kMainColor),
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text(
                                "1:00 PM",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const VerticalSpacingWidget(height: 10),
              OverlayTooltipItem(
                displayIndex: 6,
                tooltip: (controller) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child:
                      MTooltip(title: 'time duration', controller: controller),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Duration",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: kSubTextColor),
                    ),
                    const VerticalSpacingWidget(height: 5),
                    SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        // autofocus: true,
                        cursorColor: kMainColor,
                        // controller: timeDuration1Controller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        // focusNode:
                        // timeDurationFocusController,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 13.sp, color: kSubTextColor),
                          hintText: "10 min",
                          filled: true,
                          fillColor: kCardColor,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kMainColor)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: kMainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacingWidget(height: 10),
              Text(
                "Select Days",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: kSubTextColor),
              ),
              const VerticalSpacingWidget(height: 5),
              //! sunday monday tuesday
              OverlayTooltipItem(
                displayIndex: 7,
                tooltip: (controller) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: MTooltip(title: 'select days', controller: controller),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 5,
                      ),
                      itemCount: _days1.length,
                      itemBuilder: (context, index) {
                        final day = _days1[index];
                        final isChecked = checkboxData[day] ?? false;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              checkboxData[day] = !isChecked;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Checkbox(
                                  activeColor: kMainColor,
                                  value: isChecked,
                                  onChanged: (_) {
                                    setState(() {
                                      checkboxData[day] = !isChecked;
                                    });
                                  },
                                ),
                              ),
                              const HorizontalSpacingWidget(width: 10),
                              SizedBox(
                                width: 68.w,
                                child: Text(
                                  day,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: CommonButtonWidget(
              title: "Generate token", onTapFunction: () {}),
        ),
      ),
    );
  }

  Widget _sampleWidget() => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lorem Ipsum is simply dummy text of the printing and'
                'industry. Lorem Ipsum has been the industry\'s'
                'standard dummy text ever since the 1500s'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.bookmark_border),
                Icon(Icons.delete_outline_sharp)
              ],
            )
          ],
        ),
      );
}

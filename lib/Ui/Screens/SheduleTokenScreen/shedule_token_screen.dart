import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/CustomSchedule/custom_schedule_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/Reservation/reservation_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/SheduleTokenScreen/ScheduleToken/schedule_token_details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../CommonWidgets/vertical_spacing_widget.dart';
import 'LeaveScreen/leave_screen.dart';
import 'RemoveTokens/remove_token_screen.dart';

class SheduleTokenScreen extends StatefulWidget {
  const SheduleTokenScreen({super.key});

  @override
  State<SheduleTokenScreen> createState() => _SheduleTokenScreenState();
}

class _SheduleTokenScreenState extends State<SheduleTokenScreen> {
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    // Simulate loading time with a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => BottomNavigationControlWidget(
                      selectedIndex: 0,
                    )));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Schedule"),
        ),
        body: _isLoading
            ? _buildLoadingWidget()
            : FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        size.width > 450
                            ? const VerticalSpacingWidget(height: 20)
                            : const VerticalSpacingWidget(height: 0),
                        //! first section (Daily shedule)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    const ScheduleTokenDetailsScreen(),
                              ),
                            );
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                // height: 120.h,
                                "assets/images/token_schedule.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 8),
                        //! second section (custom schedule late,early,break)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const CustomScheduleScreen()));
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/customize schedule.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        //! third section (manage shedule)
                        const VerticalSpacingWidget(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const RemoveTokenScreen()));
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/remove_token.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        //! fourth section (leave shedule)
                        const VerticalSpacingWidget(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const LeaveScreen()));
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/Leave_Banner.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const ReservationScreen()));
                          },
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/reservation.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListView.builder(
        itemCount: 5, // Number of shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 107.h,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

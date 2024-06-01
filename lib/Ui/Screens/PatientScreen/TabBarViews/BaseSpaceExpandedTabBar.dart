import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class BaseSpaceExpandedTabBar extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;

  const BaseSpaceExpandedTabBar({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  @override
  _BaseSpaceExpandedTabBarState createState() =>
      _BaseSpaceExpandedTabBarState();
}

class _BaseSpaceExpandedTabBarState extends State<BaseSpaceExpandedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpacingWidget(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(131, 187, 222,
                  251), // Set the background color of the tab bar
              borderRadius: BorderRadius.circular(10), // Set border radius
            ),
            child: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: kMainColor),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.white,
              tabAlignment: TabAlignment.start,
              tabs: widget.tabs,
              labelColor: Colors.white, // Set the color of selected tab text
              labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.bold), // Set style for selected tab text
              unselectedLabelColor:
                  Colors.black, // Set the color of unselected tab text
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12), // Set style for unselected tab text
              isScrollable:
                  true, // Set to true for full view of text when selected
            ),
          ),
        ),
        const VerticalSpacingWidget(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}

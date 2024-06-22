import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/BaseSpaceExpandedTabBar.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/all_health_record_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/completed_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/discharge_summary_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/lab_report_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/prescription_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/scanning_report_screen.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/vitals_screen.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        backgroundColor: kCardColor,
        title: const Text("Health Record"),
        centerTitle: true,
      ),
      bottomNavigationBar: Platform.isIOS
          ? SizedBox(
              height: size.height * 0.038,
              width: double.infinity,
            )
          : const SizedBox(),
      body: BaseSpaceExpandedTabBar(
        tabs: const [
          Tab(height: 35, text: 'All'),
          Tab(height: 35, text: 'Completed'),
          Tab(height: 35, text: 'Vitals'),
          Tab(height: 35, text: 'Prescription'),
          Tab(height: 35, text: 'Lab report'),
          Tab(height: 35, text: 'Scan report'),
          Tab(height: 35, text: 'Discharge summary'),
        ],
        tabViews: [
          AllHealthRecordScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          ),
          CompletedScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          ),
          AllVitalsScreen(
            patientId: widget.patientId,
          ),
          PrescriptionScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          ),
          LabReportScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          ),
          ScanningReportScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          ),
          DischargeSummaryScreen(
            patientId: widget.patientId,
            userId: widget.userId,
          )
        ],
      ),
    );
  }
}

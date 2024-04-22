import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/completed_appointments_ht_rcd_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/completedAppointmentsHR/completed_appointments_health_record_bloc.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/CompletedAppointmentCardWidget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen(
      {super.key, required this.patientId, required this.userId});

  final String patientId;
  final String userId;

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  // late GetAllCompletedAppointmentsModel getAllCompletedAppointmentsModel;
  late GetCompletedAppointmentsHealthRecordModel
      getCompletedAppointmentsHealthRecordModel;

  @override
  void initState() {
    BlocProvider.of<CompletedAppointmentsHealthRecordBloc>(context).add(
        FetchCompletedAppointmentsByPatientId(
            patientId: widget.patientId, userId: widget.userId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedAppointmentsHealthRecordBloc,
        CompletedAppointmentsHealthRecordState>(
      builder: (context, state) {
        if (state is CompletedAppointmentsHealthRecordLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          );
        }
        if (state is CompletedAppointmentsHealthRecordError) {
          return Center(
            child: Image(
              image:
                  const AssetImage("assets/images/something went wrong-01.png"),
              height: 200.h,
              width: 200.w,
            ),
          );
        }
        if (state is CompletedAppointmentsHealthRecordLoaded) {
          getCompletedAppointmentsHealthRecordModel =
              BlocProvider.of<CompletedAppointmentsHealthRecordBloc>(context)
                  .getCompletedAppointmentsHealthRecordModel;
          return getCompletedAppointmentsHealthRecordModel.appointmentDetails ==
                  null
              ? Center(
                  child: Image.asset("assets/images/no_data___.jpg"),
                )
              : ListView.builder(
                  itemCount: getCompletedAppointmentsHealthRecordModel
                      .appointmentDetails!.length,
                  itemBuilder: (context, index) {
                    return CompletedAppointmentCardWidget(
                      prescriptions: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].doctorMedicines!
                          .toList(),
                      clinicName: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].clinicName
                          .toString(),
                      doctorImage: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].doctorImage
                          .toString(),
                      doctorName: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].doctorName
                          .toString(),
                      labName: getCompletedAppointmentsHealthRecordModel
                                  .appointmentDetails![index].labName ==
                              null
                          ? ""
                          : getCompletedAppointmentsHealthRecordModel
                              .appointmentDetails![index].labName
                              .toString(),
                      labTestName: getCompletedAppointmentsHealthRecordModel
                                  .appointmentDetails![index].labTest ==
                              null
                          ? ""
                          : getCompletedAppointmentsHealthRecordModel
                              .appointmentDetails![index].labTest
                              .toString(),
                      note: getCompletedAppointmentsHealthRecordModel
                                  .appointmentDetails![index].notes ==
                              null
                          ? ""
                          : getCompletedAppointmentsHealthRecordModel
                              .appointmentDetails![index].notes
                              .toString(),
                      patientName: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].patientName
                          .toString(),
                      prescriptionImage:
                          getCompletedAppointmentsHealthRecordModel
                                      .appointmentDetails![index]
                                      .prescriptionImage ==
                                  null
                              ? ""
                              : getCompletedAppointmentsHealthRecordModel
                                  .appointmentDetails![index].prescriptionImage
                                  .toString(),
                      // reviewAfter: getCompletedAppointmentsHealthRecordModel
                      //     .appointmentDetails![index].
                      //     .reviewAfter ==
                      //     null
                      //     ? ""
                      //     : getCompletedAppointmentsHealthRecordModel
                      //     .appointmentDetails![index].reviewAfter
                      //     .toString(),
                      tokenDate: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].date
                          .toString(),
                      tokenTime: getCompletedAppointmentsHealthRecordModel
                          .appointmentDetails![index].tokenStartTime
                          .toString(),
                      symptoms: getCompletedAppointmentsHealthRecordModel
                                  .appointmentDetails![index].mainSymptoms ==
                              null
                          ? getCompletedAppointmentsHealthRecordModel
                              .appointmentDetails![index]
                              .otherSymptoms![0]
                              .symtoms
                              .toString()
                          : getCompletedAppointmentsHealthRecordModel
                              .appointmentDetails![index]
                              .mainSymptoms!
                              .mainsymptoms
                              .toString(),
                    );
                  });
        }
        return Container();
      },
    );
  }
}

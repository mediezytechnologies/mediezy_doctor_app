import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/get_all_vitals/get_all_vitals_bloc.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/TabBarViews/vitals_card_widget.dart';

class AllVitalsScreen extends StatefulWidget {
  const AllVitalsScreen({super.key, required this.patientId});

  final String patientId;

  @override
  State<AllVitalsScreen> createState() => _AllVitalsScreenState();
}

class _AllVitalsScreenState extends State<AllVitalsScreen> {
  @override
  void initState() {
    BlocProvider.of<GetAllVitalsBloc>(context)
        .add(FetchVitals(patientId: widget.patientId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<GetAllVitalsBloc, GetAllVitalsState>(
        builder: (context, state) {
          if (state is GetAllVitalsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is GetAllVitalsError) {
            return Center(
              child: Image(
                image: const AssetImage(
                    "assets/images/something went wrong-01.png"),
                height: 200.h,
                width: 200.w,
              ),
            );
          }
          if (state is GetAllVitalsLoaded) {
            return state.getVitalsModel.vitals == null
                ? Center(
                    child: Image.asset("assets/images/no_data___.jpg"),
                  )
                : ListView.builder(
                    itemCount: state.getVitalsModel.vitals!.length,
                    itemBuilder: (context, index) {
                      final vitals = state.getVitalsModel.vitals![index];
                      return VitalsCardWidget(
                        appointmentDate: vitals.date.toString(),
                        dia: vitals.dia.toString(),
                        doctorName: vitals.doctorFirstname.toString(),
                        heartRate: vitals.heartRate.toString(),
                        height: vitals.height.toString(),
                        patientName: vitals.patientName.toString(),
                        spo2: vitals.spo2.toString(),
                        sys: vitals.sys.toString(),
                        temperature: vitals.temperature.toString(),
                        temperatureType: vitals.temperatureType.toString(),
                        weight: vitals.weight.toString(),
                      );
                    });
          }
          return Container();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/get_prescription_view_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/GetPrescriptionView/get_prescription_view_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/view_file_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class PrescriptionViewScreen extends StatefulWidget {
  const PrescriptionViewScreen(
      {super.key,
      required this.name,
      required this.patientId,
      required this.userId});

  final String name;
  final String patientId;
  final String userId;

  @override
  State<PrescriptionViewScreen> createState() => _PrescriptionViewScreenState();
}

class _PrescriptionViewScreenState extends State<PrescriptionViewScreen> {
  late GetPrescriptionViewModel getPrescriptionViewModel;

  @override
  void initState() {
    BlocProvider.of<GetPrescriptionViewBloc>(context)
        .add(FetchGetPrescriptionView(
      patientId: widget.patientId,
      userId: widget.userId,
    ));
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
      body: BlocBuilder<GetPrescriptionViewBloc, GetPrescriptionViewState>(
        builder: (context, state) {
          if (state is GetPrescriptionViewLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetPrescriptionViewError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is GetPrescriptionViewLoaded) {
            getPrescriptionViewModel =
                BlocProvider.of<GetPrescriptionViewBloc>(context)
                    .getPrescriptionViewModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "Prescriptions (${getPrescriptionViewModel.prescriptions!.length})",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: getPrescriptionViewModel.prescriptions!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const VerticalSpacingWidget(height: 3),
                    itemBuilder: (context, index) {
                      return Container(
                        height: mHeight * .13,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kCardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              const HorizontalSpacingWidget(width: 10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.date_range,
                                              color: kMainColor,
                                            ),
                                            HorizontalSpacingWidget(width: 5.w),
                                            Text(
                                              getPrescriptionViewModel
                                                  .prescriptions![index]
                                                  .patientPrescription![0]
                                                  .date
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        HorizontalSpacingWidget(
                                            width: mWidth * .42),
                                        Image(
                                          image: const AssetImage(
                                            "assets/icons/pdf.png",
                                          ),
                                          height: mHeight * .03,
                                          width: mWidth * .06,
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => ViewFileWidget(
                                                    viewFile:
                                                        getPrescriptionViewModel
                                                            .prescriptions![
                                                                index]
                                                            .documentPath
                                                            .toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Container(
                                        height: mHeight * .07,
                                        width: mWidth * .8,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            // color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Image(
                                                    height: 30,
                                                    width: 30,
                                                    image: AssetImage(
                                                      "assets/icons/stethoscope.png",
                                                    ),
                                                  ),
                                                  HorizontalSpacingWidget(
                                                      width: 5.w),
                                                  Text(
                                                    getPrescriptionViewModel
                                                        .prescriptions![index]
                                                        .patientPrescription![0]
                                                        .doctorName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                size: 17,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
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

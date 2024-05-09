import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Model/HealthRecords/patients_get_model.dart';
import 'package:mediezy_doctor/Repositary/Bloc/patients/search_patients/search_patients_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Screens/PatientScreen/patients_card_widget.dart';

class SearchPatientsScreen extends StatefulWidget {
  const SearchPatientsScreen({super.key});

  @override
  State<SearchPatientsScreen> createState() => _SearchPatientsScreenState();
}

class _SearchPatientsScreenState extends State<SearchPatientsScreen> {
  final TextEditingController searchController = TextEditingController();
  late PatientsGetModel patientsGetModel;

  @override
  void initState() {
    BlocProvider.of<SearchPatientsBloc>(context)
        .add(FetchSearchPatients(searchQuery: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Search Patients"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: kMainColor,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (newValue) {
                      BlocProvider.of<SearchPatientsBloc>(context)
                          .add(FetchSearchPatients(searchQuery: newValue));
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        IconlyLight.search,
                        color: kMainColor,
                        size: size.width > 400 ? 14.sp : 20.sp,
                      ),
                      hintStyle: size.width > 400 ? greyTab10B600 : grey13B600,
                      hintText: "Search Your Patients",
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<SearchPatientsBloc, SearchPatientsState>(
                  builder: (context, state) {
                    if (state is SearchPatientsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is SearchPatientsError) {
                      return Center(
                        child: Image(
                          image: const AssetImage(
                              "assets/images/something went wrong-01.png"),
                          height: 200.h,
                          width: 200.w,
                        ),
                      );
                    }
                    if (state is SearchPatientsLoaded) {
                      patientsGetModel =
                          BlocProvider.of<SearchPatientsBloc>(context)
                              .patientsGetModel;
                      if (patientsGetModel.patientData != null &&
                          patientsGetModel.patientData!.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: patientsGetModel.patientData!.length,
                            itemBuilder: (context, index) {
                              var patientData =
                                  patientsGetModel.patientData![index];
                              return PatientsCardWidget(
                                patientId: patientData.id.toString(),
                                userId: patientData.userId.toString(),
                                patientName: patientData.firstname.toString(),
                                age: patientData.displayAge.toString(),
                                gender: patientData.gender.toString(),
                                userImage: patientsGetModel
                                            .patientData![index].userImage ==
                                        null
                                    ? ""
                                    : patientsGetModel
                                        .patientData![index].userImage
                                        .toString(),
                                mediezyPatientId:
                                    patientData.mediezyPatientId.toString(),
                              );
                            });
                      } else {
                        return Column(
                          children: [
                            VerticalSpacingWidget(height: 130.h),
                            Center(
                              child: Image(
                                image: const AssetImage(
                                  "assets/images/You ahve no patients-01.png",
                                ),
                                height: 200.h,
                                color: kMainColor,
                                width: 200.w,
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Suggestions/suggestion_bloc.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';
import 'package:mediezy_doctor/Ui/Services/general_services.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final TextEditingController suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Suggestions"),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
        child: CommonButtonWidget(
            title: "Add",
            onTapFunction: () {
              BlocProvider.of<SuggestionBloc>(context)
                  .add(FetchSuggestions(message: suggestionController.text));
            }),
      ),
      body: BlocListener<SuggestionBloc, SuggestionState>(
        listener: (context, state) {
          if (state is SuggestionLoaded) {
            GeneralServices.instance
                .showSuccessMessage(context, "Your Feedback Added Successfull");
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
          }
          if (state is SuggestionError) {
            GeneralServices.instance
                .showErrorMessage(context, "Please Add Your Feedback");
            // Future.delayed(const Duration(seconds: 5), () {
            //   Navigator.pop(context);
            // });
          }
          // TODO: implement listener
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We would love your feedback",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              const VerticalSpacingWidget(height: 15),
              Text(
                "You've been using mediezy for a while now,\nand we'd love to know what you think about it",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
              ),
              const VerticalSpacingWidget(height: 10),
              Text(
                "Share your feedback",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              const VerticalSpacingWidget(height: 5),
              TextFormField(
                autofocus: true,
                cursorColor: kMainColor,
                controller: suggestionController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.newline,
                maxLines: 10,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15.sp, color: kSubTextColor),
                  hintText: "Describe your experience",
                  filled: true,
                  fillColor: kCardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              const VerticalSpacingWidget(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

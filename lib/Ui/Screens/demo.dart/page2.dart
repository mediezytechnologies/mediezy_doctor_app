import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Ui/Screens/demo.dart/page3.dart';
import 'dropdown/dropdown_bloc.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DropdownBloc, DropdownState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              DropdownButton<String>(
                value: state.changValue,
                onChanged: (String? newValue) {
                  BlocProvider.of<DropdownBloc>(context).add(
                      DropdownSelectEvent(dropdownSelectnvLalu: newValue!));
                },
                items: <String>['One', 'Two', 'Three', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page3(),));
              }, child: Text('ga'))
            ],
          ),
        );
      },
    );
  }
}

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.onpressed,
    required this.value,
    required this.items,
    required this.hint,
  });
  final void Function(String?) onpressed;
  final String? value;
  final List<DropdownMenuItem<String>> items;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text(hint),
        elevation: 6,
        borderRadius: BorderRadius.circular(20),
        // alignment: AlignmentDirectional.center,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        value: value,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        items: items,
        onChanged: onpressed,
      ),
    );
  }
}

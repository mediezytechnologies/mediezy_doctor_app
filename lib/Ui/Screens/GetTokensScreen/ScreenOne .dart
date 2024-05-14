import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/date_picker_demo.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final _dateC = TextEditingController();
  final _timeC = TextEditingController();

  ///Date
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);

  ///Time
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pickers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildUI(context),
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // _customBackgroundExample(),
        // const SizedBox(
        //   height: 32.0,
        // ),
        // const SizedBox(height: 20),
        DatePickerDemoClass(
          height: 150,
          width: 80,
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            // New date selected
            setState(() {
              selected = date;
            });
          },
        ),
        const SizedBox(height: 20),
        Text(selected.toString()),
        const SizedBox(height: 20),
        // TextFormField(
        //   controller: _timeC,
        //   decoration: const InputDecoration(
        //       labelText: 'Time picker', border: OutlineInputBorder()),
        // ),
        // const SizedBox(
        //   height: 32.0,
        // ),
        // TextFormField(
        //   controller: _dateC,
        //   decoration: const InputDecoration(
        //       labelText: 'Time picker', border: OutlineInputBorder()),
        // ),
        // const SizedBox(
        //   height: 32.0,
        // ),
        // ElevatedButton(
        //     onPressed: () => displayTimePicker(context),
        //     child: const Text("Pick Time")),
      ],
    );
  }

  // Future displayTimePicker(BuildContext context) async {
  //   var time = await showTimePicker(context: context, initialTime: timeOfDay);

  //   if (time != null) {
  //     setState(() {
  //       _timeC.text = "${time.hour}:${time.minute}";
  //     });
  //   }
  // }

  // EasyDateTimeLine _customBackgroundExample() {
  //   return EasyDateTimeLine(
  //     initialDate: DateTime.now(),
  //     onDateChange: (selectedDate) {
  //       //selectedDate the new date selected.
  //     },
  //     headerProps: const EasyHeaderProps(
  //       monthPickerType: MonthPickerType.switcher,
  //       dateFormatter: DateFormatter.fullDateDMY(),
  //     ),
  //     dayProps: const EasyDayProps(
  //       dayStructure: DayStructure.dayStrDayNum,
  //       activeDayStyle: DayStyle(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //           gradient: LinearGradient(
  //             begin: Alignment.topCenter,
  //             end: Alignment.bottomCenter,
  //             colors: [
  //               Color(0xff3371FF),
  //               Color(0xff8426D6),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

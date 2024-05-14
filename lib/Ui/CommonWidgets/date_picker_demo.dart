import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/vertical_spacing_widget.dart';

class DatePickerDemoClass extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DatePickerController? controller;
  final Color selectedTextColor;
  final Color selectionColor;
  final Color deactivatedColor;
  final TextStyle monthTextStyle;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final DateTime? initialSelectedDate;
  final List<DateTime>? inactiveDates;
  final List<DateTime>? activeDates;
  final DateChangeListener? onDateChange;
  final int daysCount;
  final String locale;
  const DatePickerDemoClass(
    this.startDate, {
    Key? key,
    this.width = 60,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 100000,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _DatePickerDemoClassState();
}

class _DatePickerDemoClassState extends State<DatePickerDemoClass> {
//   Widget _buildMonthPicker() {
//   if (_showMonthPicker(pickerType: MonthPickerType.dropDown)) {
//     return YourDropDownWidget(); // Replace YourDropDownWidget with your actual dropdown widget
//   } else if (_showMonthPicker(pickerType: MonthPickerType.switcher)) {
//     return YourMonthSwitcherWidget(); // Replace YourMonthSwitcherWidget with your actual month switcher widget
//   } else {
//     return Container(); // Return an empty container if none of the conditions are met
//   }
// }

  DateTime? _currentDate;

  ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  DateTime? currentDate;
  DateTime? date;
  String displayedMonth = DateFormat("MMM").format(DateTime.now());
  String displayedYear = DateFormat("yyyy").format(DateTime.now());
  @override
  void initState() {
    initializeDateFormatting(widget.locale, null);
    _currentDate = widget.initialSelectedDate;
    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }
    _controller.addListener(_onScroll);
    selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  void _onScroll() {
    final firstVisibleItemIndex = _controller.offset ~/ widget.width;
    final currentDate =
        widget.startDate.add(Duration(days: firstVisibleItemIndex));
    _updateDisplayedMonthAndYear(currentDate);
  }

  void _updateDisplayedMonthAndYear(DateTime date) {
    setState(() {
      displayedMonth =
          DateFormat("MMM", widget.locale).format(date).toUpperCase();
      displayedYear =
          DateFormat("yyyy", widget.locale).format(date).toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayedMonth,
                  style: size.width > 450 ? blackTabMainText : blackMainText,
                ),
                Text(
                  displayedYear,
                  style: size.width > 450 ? blackTabMainText : blackMainText,
                ),
              ],
            ),
          ),
          const VerticalSpacingWidget(height: 5),
          // SizedBox(
          //   height: size.height * 0.03,
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.daysCount,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                DateTime _date = widget.startDate.add(Duration(days: index));

                currentDate = widget.startDate.add(Duration(days: index));

                DateTime date = DateTime(_date.year, _date.month, _date.day);
                log(_date.toString());
                bool isDeactivated = false;

                if (widget.inactiveDates != null) {
                  for (DateTime inactiveDate in widget.inactiveDates!) {
                    if (_compareDate(date, inactiveDate)) {
                      isDeactivated = true;
                      break;
                    }
                  }
                }
                if (widget.activeDates != null) {
                  isDeactivated = true;
                  for (DateTime activateDate in widget.activeDates!) {
                    if (_compareDate(date, activateDate)) {
                      isDeactivated = false;
                      break;
                    }
                  }
                }
                log("current date ");

                bool isSelected = _currentDate != null
                    ? _compareDate(date, _currentDate!)
                    : false;
                return DateWidgets(
                  date: date,
                  monthTextStyle: isDeactivated
                      ? deactivatedMonthStyle
                      : isSelected
                          ? selectedMonthStyle
                          : widget.monthTextStyle,
                  dateTextStyle: isDeactivated
                      ? deactivatedDateStyle
                      : isSelected
                          ? selectedDateStyle
                          : widget.dateTextStyle,
                  dayTextStyle: isDeactivated
                      ? deactivatedDayStyle
                      : isSelected
                          ? selectedDayStyle
                          : widget.dayTextStyle,
                  width: widget.width,
                  locale: widget.locale,
                  selectionColor:
                      isSelected ? widget.selectionColor : Colors.transparent,
                  onDateSelected: (selectedDate) {
                    log("current date : $_currentDate");
                    if (isDeactivated) return;
                    if (widget.onDateChange != null) {
                      widget.onDateChange!(selectedDate);
                    }
                    setState(() {
                      _currentDate = selectedDate;
                    });
                  },
                  onMonthUpdated: (selectedDate) {
                    // Pass the callback function
                    _updateDisplayedMonthAndYear(selectedDate);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerDemoClassState? _datePickerState;

  // ignore: library_private_types_in_public_api
  void setDatePickerState(_DatePickerDemoClassState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    if (date.compareTo(_datePickerState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerState!.widget.startDate
                .add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      _datePickerState!._currentDate = date;
    }
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}

// Add this callback function type definition at the end of your file
typedef MonthUpdateCallback = void Function(DateTime selectedDate);

// Modify the DateWidgets widget to accept the callback function
class DateWidgets extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final MonthUpdateCallback? onMonthUpdated; // Add this line
  final String? locale;

  const DateWidgets({
    super.key,
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.onMonthUpdated, // Add this line
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                style: dayTextStyle,
              ),
              Text(
                date.day.toString(), // Date
                style: dateTextStyle,
              ),
              Text(
                DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                style: monthTextStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (onDateSelected != null) {
          onDateSelected!(date);
          if (onMonthUpdated != null) {
            // Call the callback function
            onMonthUpdated!(date);
          }
        }
      },
    );
  }
}

class AppColors {
  AppColors._();

  static const Color defaultDateColor = Colors.black;
  static const Color defaultDayColor = Colors.black;
  static const Color defaultMonthColor = Colors.black;
  static const Color defaultSelectionColor = Color(0x30000000);
  static const Color defaultDeactivatedColor = Color(0xFF666666);
}

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.defaultMonthColor,
  fontSize: Dimen.monthTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.defaultDateColor,
  fontSize: Dimen.dateTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.defaultDayColor,
  fontSize: Dimen.dayTextSize,
  fontWeight: FontWeight.w500,
);

/// Used by [DatePickerTimeline] for tap detection.
typedef DateSelectionCallback = void Function(DateTime selectedDate);

/// Signature for a function that is called when selected date is changed
///
/// Used by [DatePickerTimeline] for tap detection.
typedef DateChangeListener = void Function(DateTime selectedDate);

class Dimen {
  Dimen._();

  static const double dateTextSize = 24;
  static const double dayTextSize = 11;
  static const double monthTextSize = 11;
}

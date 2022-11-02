import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

//creation of the TableCalendar
//code obtained from TableCalendar repo: https://github.com/aleksanderwozniak/table_calendar
class _EventCalendarState extends State<EventCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late DateTime calendarStartDate;
  late DateTime calendarEndDate;

  @override
  void initState() {
    super.initState();
    final calendarRoot = DateTime.now();
    if (calendarRoot.month >= 1 && calendarRoot.month <= 6) {
      calendarStartDate =
          DateTime(calendarRoot.year, DateTime.january, calendarRoot.day);
      calendarEndDate =
          DateTime(calendarRoot.year, DateTime.june, calendarRoot.day);
    } else {
      calendarStartDate =
          DateTime(calendarRoot.year, DateTime.july, calendarRoot.day);
      calendarEndDate =
          DateTime(calendarRoot.year, DateTime.december, calendarRoot.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: calendarStartDate,
      lastDay: calendarEndDate,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}

//creates calendar page in app
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: EventCalendar());
  }
}

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:hendrix_today_app/home_screen.dart';
import 'package:hendrix_today_app/calendar_screen.dart';
import 'package:hendrix_today_app/search_screen.dart';
import 'package:hendrix_today_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; // new
import 'firebase.dart' as fb; //

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
  //late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  // List<Event> _getEventsForDay(DateTime day) {
  // return kEvents[day] ?? [];
  //}

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      //_selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  final Stream<QuerySnapshot> _usersStream =
      fb.db.collection('eventsListed').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          //sets the bounds for the calendar at 6 months before and after the current date
          final calendarRoot = DateTime.now();
          final calendarStartDate = DateTime(
              calendarRoot.year, calendarRoot.month - 6, calendarRoot.day);
          final calendarEndDate = DateTime(
              calendarRoot.year, calendarRoot.month + 6, calendarRoot.day);

          return SizedBox(
            child: ListView(children: [
              TableCalendar(
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
              ),
              ListBody(
                  //height: MediaQuery.of(context).size.height,
                  //width: MediaQuery.of(context).size.width,
                  //children: //ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                            elevation: 6.0,
                            child: ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["date"]),
                              onTap: () {
                                AlertDialog alert = AlertDialog(
                                  title: Text(data["title"]),
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 200, horizontal: 50),
                                  content:
                                      Column(children: [Text(data["desc"])]),
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                            ));
                      })
                      .toList()
                      .cast()),
              //),
            ]),
          );
          //);
        });
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

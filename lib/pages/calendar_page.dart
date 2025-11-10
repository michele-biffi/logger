import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/add_log_dialog.dart';
import 'package:logger/components/custom_app_bar.dart';
import 'package:logger/components/log_card.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, onDestinationSelected: (int) {}),
      backgroundColor: CustomColors.light,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomColors.orange,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0,
                left: 25,
                right: 25,
                bottom: 30,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _focusedDay.year.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _monthName(_focusedDay.month),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TableCalendar(
                    calendarFormat:
                        CalendarFormat.week, // prima c'era _calendarFormat
                    availableCalendarFormats: const {CalendarFormat.week: ''},
                    rowHeight: 48,
                    daysOfWeekHeight: 30,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
                    // onFormatChanged: (format) {},
                    headerVisible: false,
                    calendarStyle: CalendarStyle(
                      tablePadding: const EdgeInsets.all(0),
                      todayTextStyle: TextStyle(
                        color: CustomColors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.orange.shade900,
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: const TextStyle(color: Colors.white),
                      weekendTextStyle: const TextStyle(color: Colors.white),
                      outsideDaysVisible: false,
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white38),
                      weekendStyle: TextStyle(color: Colors.white38),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: CustomColors.light,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                children: [
                  const LogCard(
                    title: "Team meeting",
                    description: "Meeting di allineamento per l'app",
                    startTime: "8:00",
                    endTime: "10:00",
                    effort: 120,
                    important: false,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomBar(currentIndex: 1),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 8),
        child: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: () {
              showAddLogModal(context);
            },
            backgroundColor: CustomColors.orange,
            foregroundColor: CustomColors.light,
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }
}

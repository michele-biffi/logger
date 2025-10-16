import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_bottom_bar.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _monthName(_focusedDay.month),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TableCalendar(
                  calendarFormat: _calendarFormat,
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
                  onFormatChanged: (format) {},
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                    tablePadding: const EdgeInsets.all(0),
                    todayDecoration: const BoxDecoration(
                      color: Colors.white38,
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
          const SizedBox(height: 12),
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // swipe alto
                setState(() {
                  _calendarFormat = CalendarFormat.week;
                });
              } else if (details.primaryVelocity! > 0) {
                // swipe basso
                setState(() {
                  _calendarFormat = CalendarFormat.month;
                });
              }
            },
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          // Daily log
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const LogCard(
                    tag: "Workout",
                    description: "Allenamento spalle e braccia",
                    time: "08:30 AM",
                    tagColor: Colors.deepOrange,
                  ),
                  const SizedBox(height: 20),
                  const LogCard(
                    tag: "Meeting",
                    description: "Riunione progetto Flutter",
                    time: "10:00 AM",
                    tagColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 1),
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

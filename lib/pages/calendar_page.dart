import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/add_log_dialog.dart';
import 'package:logger/components/custom_bottom_bar.dart';
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
                  calendarFormat: _calendarFormat, // 👈 Usa il formato dinamico
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
                  onFormatChanged: (format) {
                    // Evita cambi accidentali se vuoi controllare solo tu il formato
                  },
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
                  Container(
                    color: CustomColors.darkOrange,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "CARD 1",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.light,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: CustomColors.darkOrange,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "CARD 2",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.light,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // _buildLogCard(
                  //  tag: "Projects",
                  //  description: "Added SSH keys for new project",
                  //  time: "9.00 - 9.30",
                  //  tagColor: Colors.orange.shade300,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            elevation: 4,
            onPressed: () {
              showAddLogModal(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: CustomColors.orange,
            foregroundColor: CustomColors.light,
            child: Icon(Icons.add, size: 25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(),
    );
  }

  Widget _buildLogCard({
    required String tag,
    required String description,
    required String time,
    required Color tagColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tag,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
          ),
        ],
      ),
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

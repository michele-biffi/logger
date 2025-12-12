import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/add_log_dialog.dart';
import 'package:logger/components/custom_app_bar.dart';
import 'package:logger/components/log_card.dart';
import 'package:logger/models/log.dart';
import 'package:logger/pages/analytics_page.dart';
import 'package:logger/pages/settings_page.dart';
import 'package:logger/pages/user.dart';
import 'package:logger/services/supabase_service.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final SupabaseService _supabaseService = SupabaseService();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isLoading = false;
  List<Log> _logs = [];
  int _drawerSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _fetchLogsForDay(_selectedDay!);
  }

  Future<void> _fetchLogsForDay(DateTime day) async {
    setState(() => _isLoading = true);

    try {
      final logs = await _supabaseService.getLogsForDay(day);
      setState(() {
        _logs = logs;
      });
    } catch (error) {
      debugPrint('Errore caricando i log: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante il caricamento dei log: $error'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addLog(Map<String, dynamic> newLogData) async {
    try {
      final startTime = newLogData['start_time'] as TimeOfDay;
      final endTime = newLogData['end_time'] as TimeOfDay;
      final selectedDate = _selectedDay!;

      final startDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTime.hour,
        startTime.minute,
      );
      final endDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        endTime.hour,
        endTime.minute,
      );

      final newLog = Log(
        id: '',
        title: newLogData['title'],
        description: newLogData['description'],
        startTime: startDateTime,
        endTime: endDateTime,
        effort: newLogData['effort'],
        isImportant: newLogData['is_important'],
        createdAt: selectedDate,
      );

      await _supabaseService.addLog(newLog);
      await _fetchLogsForDay(_selectedDay!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Log salvato con successo ✅'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore during il salvataggio: $error'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      debugPrint('Errore inserendo il log: $error');
    }
  }

  void _openAddLogModal() async {
    final result = await showAddLogModal(context);
    if (result != null) {
      await _addLog(result);
    }
  }

  Widget _buildCalendarView() {
    return Column(
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
                        color: CustomColors.whiteSmoke,
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
                        color: CustomColors.whiteSmoke,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TableCalendar(
                  calendarFormat: CalendarFormat.week,
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
                    _fetchLogsForDay(selectedDay);
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                    tablePadding: const EdgeInsets.all(0),
                    todayTextStyle: TextStyle(
                      color: CustomColors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: CustomColors.whiteSmoke,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange.shade900,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: const TextStyle(
                      color: CustomColors.whiteSmoke,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: CustomColors.whiteSmoke,
                    ),
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
            color: CustomColors.whiteSmoke,
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: CustomColors.orange,
              ),
            )
                : _logs.isEmpty
                ? const Center(child: Text("Nessun log per questo giorno"))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 5,
              ),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: LogCard(
                    title: log.title,
                    description: log.description ?? '',
                    startTime: DateFormat.Hm().format(log.startTime),
                    endTime: log.endTime != null
                        ? DateFormat.Hm().format(log.endTime!)
                        : '',
                    effort: log.effort ?? 0,
                    isImportant: log.isImportant,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageOptions = [
      UserPage(),
      AnalyticsPage(),
      SettingsPage(),
    ];

    return Scaffold(
      appBar: appBar(
        context,
        onDestinationSelected: (index) {
          setState(() {
            if (index == 0) { // Home
              _drawerSelectedIndex = -1;
            } else {
              final pageIndex = index - 1;
              if (_drawerSelectedIndex == pageIndex) {
                _drawerSelectedIndex = -1;
              } else {
                _drawerSelectedIndex = pageIndex;
              }
            }
          });
        },
        showBackButton: _drawerSelectedIndex != -1,
        onBack: () {
          setState(() {
            _drawerSelectedIndex = -1;
          });
        },
        onLogout: () {
          // TODO: Implement actual logout logic here
          print('Logout tapped from Calendar Page');
        },
      ),
      backgroundColor: CustomColors.whiteSmoke,
      body: _drawerSelectedIndex == -1
          ? _buildCalendarView()
          : pageOptions[_drawerSelectedIndex],
      floatingActionButton: _drawerSelectedIndex == -1
          ? Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 8),
        child: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: _openAddLogModal,
            backgroundColor: CustomColors.orange,
            foregroundColor: CustomColors.whiteSmoke,
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      )
          : null,
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


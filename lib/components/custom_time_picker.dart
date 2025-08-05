import 'package:flutter/material.dart';

class TimePickerDropdown extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;
  final TimeOfDay? initialTime;

  const TimePickerDropdown({
    super.key,
    required this.onTimeSelected,
    this.initialTime,
  });

  @override
  State<TimePickerDropdown> createState() => _TimePickerDropdownState();
}

class _TimePickerDropdownState extends State<TimePickerDropdown> {
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTime ?? TimeOfDay.now();
    _selectedHour = initial.hour;
    _selectedMinute = initial.minute - (initial.minute % 5);
  }

  void _notifyParent() {
    widget.onTimeSelected(
      TimeOfDay(hour: _selectedHour, minute: _selectedMinute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownMenu<int>(
                initialSelection: _selectedHour,
                label: Text("Ore"),
                onSelected: (value) {
                  if (value != null) {
                    setState(() => _selectedHour = value);
                    _notifyParent();
                  }
                },
                menuStyle: MenuStyle(
                  maximumSize: WidgetStateProperty.all(
                    Size(double.infinity, 200),
                  ),
                  visualDensity: VisualDensity.compact, // padding interno
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  alignment: AlignmentDirectional.centerStart,
                ),
                dropdownMenuEntries: List.generate(
                  24,
                  (index) => DropdownMenuEntry(
                    value: index,
                    label: index.toString().padLeft(2, '0'),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: DropdownMenu<int>(
                initialSelection: _selectedMinute,
                label: Text("Minuti"),
                onSelected: (value) {
                  if (value != null) {
                    setState(() => _selectedMinute = value);
                    _notifyParent();
                  }
                },
                menuStyle: MenuStyle(
                  maximumSize: WidgetStateProperty.all(
                    Size(double.infinity, 200),
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  alignment: AlignmentDirectional.centerStart,
                ),

                dropdownMenuEntries: List.generate(12, (index) {
                  final minute = index * 5;
                  return DropdownMenuEntry(
                    value: minute,
                    label: minute.toString().padLeft(2, '0'),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

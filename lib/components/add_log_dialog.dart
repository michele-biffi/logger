import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_time_picker.dart';

Future<Map<String, dynamic>?> showAddLogModal(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddLogForm(),
      );
    },
  );
}

class AddLogForm extends StatefulWidget {
  const AddLogForm({super.key});

  @override
  State<AddLogForm> createState() => _AddLogFormState();
}

class _AddLogFormState extends State<AddLogForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _effortController = TextEditingController();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.fromDateTime(
    DateTime.now().add(const Duration(hours: 1)),
  );
  bool isChecked = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _effortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.whiteSmoke,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add a Log',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: Colors.black, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Log details',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Starting time',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TimePickerDropdown(
                        onTimeSelected: (time) {
                          setState(() {
                            _startTime = time;
                          });
                        },
                        initialTime: _startTime,
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Ending time',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TimePickerDropdown(
                        onTimeSelected: (time) {
                          setState(() {
                            _endTime = time;
                          });
                        },
                        initialTime: _endTime,
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Effort in minutes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          controller: _effortController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g. 60',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            // salva effort
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 0.85,
                            child: Switch(
                              inactiveTrackColor: CustomColors.whiteSmoke,
                              trackOutlineColor:
                                  WidgetStateProperty.resolveWith<Color?>((
                                    Set<WidgetState> states,
                                  ) {
                                    if (states.contains(WidgetState.selected)) {
                                      return null;
                                    }
                                    return Colors.black38;
                                  }),
                              trackOutlineWidth: WidgetStateProperty.all(1),
                              activeTrackColor: CustomColors.orange,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Important',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final newLog = {
                              'title': _titleController.text.trim(),
                              'description': _descriptionController.text.trim(),
                              'start_time': _startTime,
                              'end_time': _endTime,
                              'effort':
                                  int.tryParse(_effortController.text.trim()) ??
                                  0,
                              'is_important': isChecked,
                            };

                            Navigator.of(context).pop(newLog);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.whiteSmoke,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

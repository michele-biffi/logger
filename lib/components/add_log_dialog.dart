import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_time_picker.dart';

Future<Map<String, dynamic>?> showAddLogModal(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: CustomColors.whiteSmoke,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const AddLogForm();
    },
  );
}

class AddLogForm extends StatefulWidget {
  const AddLogForm({super.key});

  @override
  State<AddLogForm> createState() => _AddLogFormState();
}

class _AddLogFormState extends State<AddLogForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _effortController = TextEditingController();
  TimeOfDay _startTime = TimeOfDay.now();
  final TimeOfDay _endTime = TimeOfDay.fromDateTime(
    DateTime.now().add(const Duration(hours: 1)),
  );
  bool isChecked = false;

  String? _selectedTag;
  final List<String> _availableTags = [
    'Elite',
    'Mailbot',
    'Call',
    'Sorint',
    'Tradelab',
    'Other',
  ];

  void _hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _hideKeyboard();
    _titleController.dispose();
    _descriptionController.dispose();
    _effortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add a Log',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    _hideKeyboard();
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.black, size: 28),
                ),
              ],
            ),
            //const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Log details',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Starting time',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 15),
                      TimePickerDropdown(
                        onTimeSelected: (time) {
                          setState(() {
                            _startTime = time;
                          });
                        },
                        initialTime: _startTime,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Effort in minutes',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          controller: _effortController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'es. 60',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Invalid';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Tag',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableTags.map((tag) {
                          final isSelected = _selectedTag == tag;
                          return ChoiceChip(
                            backgroundColor: CustomColors.alabasterGrey,
                            label: Text(tag),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedTag = selected ? tag : null;
                              });
                            },
                            selectedColor: CustomColors.orange.withValues(alpha: 0.2),
                            checkmarkColor: CustomColors.orange,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? CustomColors.orange
                                  : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? CustomColors.orange
                                    : Colors.black12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
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
                          const Text(
                            'Important',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _hideKeyboard();
                            if (_formKey.currentState!.validate()) {
                              final newLog = {
                                'title': _titleController.text.trim(),
                                'description': _descriptionController.text.trim(),
                                'start_time': _startTime,
                                'end_time': _endTime,
                                'effort':
                                    int.tryParse(_effortController.text.trim()) ?? 0,
                                'is_important': isChecked,
                                'tag': _selectedTag,
                              };

                              Navigator.of(context).pop(newLog);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          child: const Center(
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
                      const SizedBox(height: 20),
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

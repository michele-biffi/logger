import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_time_picker.dart';

void showAddLogModal(BuildContext context) {
  showModalBottomSheet(
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.light,
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
                      onTimeSelected: (time) {},
                      initialTime: TimeOfDay.now(),
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
                            inactiveTrackColor: CustomColors.light,
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
                          // salva
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
                              color: CustomColors.light,
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
    );
  }
}

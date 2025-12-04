import 'package:flutter/material.dart';
import 'package:logger/colors.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({
    super.key,
    required this.onDestinationSelected,
    this.selectedIndex = 0,
  });

  final Function(int) onDestinationSelected;
  final int selectedIndex;

  static const List<Map<String, dynamic>> _destinations = [
    {
      'label': 'My profile',
      'icon': Icons.person_outline_rounded,
      'selectedIcon': Icons.person_outline_rounded,
    },
    {
      'label': 'Analytics',
      'icon': Icons.show_chart_rounded,
      'selectedIcon': Icons.show_chart_rounded,
    },
    {
      'label': 'Settings',
      'icon': Icons.settings_outlined,
      'selectedIcon': Icons.settings_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.whiteSmoke,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 15),
          child: NavigationDrawer(
            indicatorColor: Colors.transparent,
            backgroundColor: CustomColors.whiteSmoke,
            onDestinationSelected: (index) {
              onDestinationSelected(index);
              Navigator.pop(context); // chiude il drawer
            },
            selectedIndex: selectedIndex,
            children: <Widget>[
              //const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      //backgroundImage: AssetImage('assets/profile.jpg'),
                      backgroundColor: CustomColors.orange,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Michele Biffi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.onyx,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'michelebiffi@sorint.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.onyx.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ..._destinations.map(
                (dest) => NavigationDrawerDestination(
                  label: Text(
                    dest['label'],
                    style: TextStyle(fontSize: 14, color: CustomColors.onyx),
                  ),
                  icon: Icon(dest['icon'], color: CustomColors.onyx, size: 22),
                  selectedIcon: Icon(
                    dest['selectedIcon'],
                    color: CustomColors.onyx,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

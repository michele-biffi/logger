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
      'icon': Icons.person_rounded,
      'selectedIcon': Icons.person,
    },
    {
      'label': 'Analytics',
      'icon': Icons.analytics_rounded,
      'selectedIcon': Icons.analytics,
    },
    {
      'label': 'Settings',
      'icon': Icons.settings_rounded,
      'selectedIcon': Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.light,
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
            backgroundColor: CustomColors.light,
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
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Michele Biffi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'michelebiffi@sorint.com',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ..._destinations.map(
                (dest) => NavigationDrawerDestination(
                  label: Text(dest['label']),
                  icon: Icon(dest['icon']),
                  selectedIcon: Icon(dest['selectedIcon']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

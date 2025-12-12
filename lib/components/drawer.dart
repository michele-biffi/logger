import 'package:flutter/material.dart';
import 'package:logger/colors.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({
    super.key,
    required this.onDestinationSelected,
    this.selectedIndex = 0,
    required this.onLogout,
  });

  final Function(int) onDestinationSelected;
  final int selectedIndex;
  final VoidCallback onLogout;

  static const List<Map<String, dynamic>> _destinations = [
    {'label': 'Home', 'icon': Icons.home_outlined},
    {'label': 'My profile', 'icon': Icons.person_outline_rounded},
    {'label': 'Analytics', 'icon': Icons.show_chart_rounded},
    {'label': 'Settings', 'icon': Icons.settings_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.whiteSmoke,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () {
                    onDestinationSelected(1);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        //backgroundImage: AssetImage('assets/profile.jpg'),
                        backgroundColor: CustomColors.orange,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
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
              ),
              const SizedBox(height: 40),
              // Use map with index to create ListTiles
              ..._destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final dest = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      dest['icon'],
                      color: CustomColors.onyx,
                      size: 22,
                    ),
                    title: Text(
                      dest['label'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.onyx,
                      ),
                    ),
                    selected: selectedIndex == index,
                    selectedTileColor: CustomColors.orange.withOpacity(0.2),
                    onTap: () {
                      onDestinationSelected(index);
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: CustomColors.orange),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: CustomColors.orange,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onLogout();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'LOGOUT',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 25,
                ),
                child: const Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: CustomColors.onyx.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

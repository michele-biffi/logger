import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
    {'label': 'Home', 'icon': HugeIcons.strokeRoundedHome03},
    {'label': 'My profile', 'icon': HugeIcons.strokeRoundedUser},
    {'label': 'Analytics', 'icon': HugeIcons.strokeRoundedChart01},
    {'label': 'Settings', 'icon': HugeIcons.strokeRoundedSettings01},
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
                              color: CustomColors.onyx.withAlpha(153),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ..._destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final dest = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: HugeIcon(
                      icon: dest['icon'],
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
                    selectedTileColor: CustomColors.orange.withAlpha(51),
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
                  vertical: 10,
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
                  vertical: 10,
                  horizontal: 25,
                ),
                child: const Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColors.onyx.withAlpha(153),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'made by @michelebiffi',
                      style: TextStyle(
                        fontSize: 10,
                        color: CustomColors.onyx.withAlpha(153),
                      ),
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

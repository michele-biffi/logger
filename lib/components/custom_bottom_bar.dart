import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:logger/components/add_log_dialog.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 3:
        showAddLogModal(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      HugeIcons.strokeRoundedHome04,
      HugeIcons.strokeRoundedCalendar04,
      HugeIcons.strokeRoundedUser,
      HugeIcons.strokeRoundedAdd01,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.all(0),
          height: 75,
          color: CustomColors.light,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              if (index == 3) {
                return GestureDetector(
                  onTap: () => _onItemTapped(context, index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: icons[index],
                          size: 25,
                          color: Colors.white,
                          strokeWidth: 1.8,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Log',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final isSelected = index == currentIndex;

              return IconButton(
                onPressed: () => _onItemTapped(context, index),
                icon: HugeIcon(
                  icon: icons[index],
                  size: isSelected ? 32 : 25,
                  color: isSelected ? CustomColors.orange : Colors.black,
                  strokeWidth: isSelected ? 1.8 : 1.5,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// TEST
                // IconButton(
                //   icon: Icon(
                //     Icons.home_rounded,
                //     color: CustomColors.dark,
                //     size: 30,
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HomePage()),
                //     );
                //   },
                // ),

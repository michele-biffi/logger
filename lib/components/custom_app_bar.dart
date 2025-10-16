import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:logger/colors.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: CustomColors.orange,
    toolbarHeight: 80,
    elevation: 0,
    automaticallyImplyLeading: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    leading: IconButton(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedMenu01,
        size: 30,
        color: Colors.white,
        strokeWidth: 1.5,
      ),
      onPressed: () {
        // Azione quando si preme il menu
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Menu pressed')));
      },
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: () {
            // Azione profilo utente
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('User Settings')));
          },
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              size: 30,
              color: CustomColors.orange,
              strokeWidth: 1.8,
            ),
          ),
        ),
      ),
    ],
  );
}

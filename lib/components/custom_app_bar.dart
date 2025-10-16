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
      statusBarIconBrightness: Brightness.light,
    ),
    actions: [
      IconButton(
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
        padding: EdgeInsets.only(right: 25),
      ),
    ],
  );
}

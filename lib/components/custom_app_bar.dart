import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/colors.dart';
import 'drawer.dart'; // import del drawer

AppBar appBar(
  BuildContext context, {
  required Function(int) onDestinationSelected,
}) {
  return AppBar(
    backgroundColor: CustomColors.orange,
    toolbarHeight: 80,
    elevation: 0,
    // non rendere un po piu scura l'app bar quando si scolla
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    //
    automaticallyImplyLeading: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.drag_handle_rounded,
          size: 28,
          color: Colors.white,
        ),
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'Drawer',
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => Align(
              alignment: Alignment.centerRight,
              child: Material(
                color: Colors.transparent,
                child: RightDrawer(
                  onDestinationSelected: onDestinationSelected,
                ),
              ),
            ),
            transitionBuilder: (_, anim, __, child) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: child,
              );
            },
          );
        },
        padding: const EdgeInsets.only(right: 25),
      ),
    ],
  );
}

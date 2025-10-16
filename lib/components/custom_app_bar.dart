import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:logger/pages/home.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 60,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: null,
    actions: null,
    flexibleSpace: Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedBlockchain01,
                size: 35.0,
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Logger', //cambiare con nome dinamico
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

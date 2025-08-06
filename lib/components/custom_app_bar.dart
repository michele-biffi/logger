import 'package:flutter/material.dart';
import 'package:logger/pages/user.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 70,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: null,
    actions: null,
    flexibleSpace: Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello, Michele',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
              child: Icon(Icons.person, color: Colors.black, size: 32),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    toolbarHeight: 75,
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
              onTap: () {},
              child: Icon(Icons.person, color: Colors.black, size: 32),
            ),
          ],
        ),
      ),
    ),
  );
}
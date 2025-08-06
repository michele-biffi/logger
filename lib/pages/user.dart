import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/add_log_dialog.dart';
import 'package:logger/components/custom_bottom_bar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: CustomColors.light,
      ),
      backgroundColor: CustomColors.light,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: CustomColors.orange,
              child: Icon(Icons.person, size: 50, color: CustomColors.light),
            ),
            SizedBox(height: 25),
            Text(
              'Michele Biffi',
              style: TextStyle(
                fontSize: 24,
                color: CustomColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                style: TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            elevation: 4,
            onPressed: () {
              showAddLogModal(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: CustomColors.orange,
            foregroundColor: CustomColors.light,
            child: Icon(Icons.add, size: 25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}

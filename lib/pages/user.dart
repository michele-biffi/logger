import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
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
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CustomColors.orange, width: 2),
              ),
              child: Center(
                child: Icon(Icons.person, size: 50, color: CustomColors.orange),
              ),
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
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.orange,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: CustomColors.light, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Modifica profilo',
                    style: TextStyle(color: CustomColors.light, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 2),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context),
      backgroundColor: CustomColors.light,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 25,
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hello, \nMichele', //cambiare con nome dinamico
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 0),
    );
  }
}


      // FLOATING BTN
      // floatingActionButton: SizedBox(
      //   width: 60,
      //   height: 60,
      //   child: FloatingActionButton(
      //     elevation: 4,
      //     onPressed: () {
      //       showAddLogModal(context);
      //     },
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(40),
      //     ),
      //     backgroundColor: CustomColors.orange,
      //     foregroundColor: CustomColors.light,
      //     child: Icon(Icons.add, size: 25),
      //   ),
      // ),
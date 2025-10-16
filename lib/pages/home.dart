import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/colors.dart';
import 'package:logger/components/custom_app_bar.dart';
//import 'package:logger/components/custom_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: CustomColors.light,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 25,
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Ciao, \nMichele!', //cambiare con nome dinamico
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Il tuo weekly summary',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const CustomBottomBar(currentIndex: 0),
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
import 'package:flutter/material.dart';
import 'package:logger/components/add_log_dialog.dart';
import 'package:logger/components/custom_app_bar.dart';
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
      appBar: appBar(),
      backgroundColor: Colors.lime,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('homepage', style: TextStyle(fontSize: 24))),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            elevation: 4,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddLogDialog(),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: Colors.limeAccent,
            foregroundColor: Colors.black,
            child: Icon(Icons.add, size: 25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}

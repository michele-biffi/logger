import 'package:flutter/material.dart';
import 'package:logger/colors.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            child: const Center(
              child: Icon(Icons.person, size: 50, color: CustomColors.orange),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Michele Biffi',
            style: TextStyle(
              fontSize: 24,
              color: CustomColors.onyx,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.orange,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.edit,
                  color: CustomColors.whiteSmoke,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Modifica profilo',
                  style: TextStyle(
                    color: CustomColors.whiteSmoke,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

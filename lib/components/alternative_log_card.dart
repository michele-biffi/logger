import 'package:flutter/material.dart';
import 'package:logger/colors.dart';

class AlternativeLogCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String description;
  final int effort; // in minuti
  final bool isImportant;

  const AlternativeLogCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
    required this.effort,
    required this.isImportant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.whiteSmoke,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TAG Container
                      const Text(
                        "MAILBOT",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "start ",
                        style: TextStyle(
                          color: CustomColors.onyx,
                          fontSize: 10,
                        ),
                      ),
                      //const SizedBox(width: 6),
                      Text(
                        // "$startTime - $endTime", before - to show both times
                        startTime,
                        style: TextStyle(
                          color: CustomColors.onyx,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  effort.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: CustomColors.onyx,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "mins",
                  style: TextStyle(fontSize: 12, color: CustomColors.onyx),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// show start time
//Text(
// "$startTime - $endTime", before - to show both times
//startTime,
//style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
//),

// TAG Container
//Icon(
//  Icons.bookmark_rounded,
//  color: isImportant ? Colors.black38 : Colors.black12,
//  size: 24,
//),
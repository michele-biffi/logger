import 'package:flutter/material.dart';
import 'package:logger/colors.dart';

class LogCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String title;
  final String description;
  final int effort; // in minuti
  final bool isImportant;

  const LogCard({
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
        color: CustomColors.alabasterGrey,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: CustomColors.onyx.withOpacity(0.4),
                ),
                const SizedBox(width: 4),
                Text(
                  // "$startTime - $endTime", before - to show both times
                  "started at $startTime",
                  style: TextStyle(
                    color: CustomColors.onyx.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.bookmark_rounded,
                  color: isImportant
                      ? CustomColors.orange
                      : Colors.grey.shade400,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColors.onyx,
              ),
            ),
            const SizedBox(height: 8),
            description.isNotEmpty
                ? Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CustomColors.onyx,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                // TAG
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "ELITE",
                    style: TextStyle(color: CustomColors.onyx, fontSize: 10),
                  ),
                ),

                // const Spacer(),
                // Text(
                //   effort.toString(),
                //   style: const TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(width: 6),
                // const Text("mins", style: TextStyle(fontSize: 12)),
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

//DIFFICULTY LEVEL TAG EXAMPLE
// Container(
//   padding: const EdgeInsets.symmetric(
//     horizontal: 12,
//     vertical: 6,
//   ),
//   //decoration: BoxDecoration(
//   //color: Colors.grey.shade200,
//   //borderRadius: BorderRadius.circular(8),
//   //),
//   child: Row(
//     children: [
//       Icon(Icons.circle, color: Colors.green, size: 12),
//       const SizedBox(width: 6),
//       Text(
//         "Easy",
//         style: TextStyle(color: Colors.green, fontSize: 12),
//       ),
//     ],
//   ),
// ),

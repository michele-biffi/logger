import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HugeIconButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final Color color;
  final double size;
  final VoidCallback? onPressed;

  const HugeIconButton({
    super.key,
    required this.icon,
    this.color = Colors.black,
    this.size = 30,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: HugeIcon(icon: icon, color: color, size: size),
    );
  }
}

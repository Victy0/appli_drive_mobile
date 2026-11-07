import 'package:flutter/material.dart';

class TextWithBackgroundColor extends StatelessWidget {
  final String text;
  final double fontSize;
  final String color;
  final String align;

  const TextWithBackgroundColor({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.align = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _colorBackground(color),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: align == "right"
            ? MainAxisAlignment.end
            : align == "left"
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorBackground(String color) {
    switch (color) {
      case "blue":
        return Colors.blue.withValues(alpha: 0.35);
      case "green":
        return Colors.green.withValues(alpha: 0.4);
      case "orange":
        return Colors.orange.withValues(alpha: 0.35);
      case "purple":
        return Colors.purple.withValues(alpha: 0.35);
      case "red":
        return Colors.red.withValues(alpha: 0.4);
      case "yellow":
        return Colors.yellow.withValues(alpha: 0.4);
      default:
        return Colors.grey.withValues(alpha: 0.3);
    }
  }
}

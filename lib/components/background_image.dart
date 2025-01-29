import 'package:flutter/material.dart';

class BackgroundImage extends StatefulWidget {
  final String color;
  const BackgroundImage({super.key, required this.color});

  @override
  BackgroundImageState createState() => BackgroundImageState();
}

class BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          _defineColor(widget.color),
          BlendMode.darken,
        ),
        child: Opacity(
        opacity: 0.6,
          child: Image.asset(
            'assets/images/white_background.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Color _defineColor(color) {
    switch (color) {
      case "blue":
        return const Color.fromARGB(255, 14, 179, 255).withOpacity(0.3);
      case "grey":
      default:
        return const Color.fromARGB(255, 155, 155, 155).withOpacity(0.3);
    }
  }
}
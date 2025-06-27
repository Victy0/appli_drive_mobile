import 'package:flutter/material.dart';

class BackgroundImage extends StatefulWidget {
  final String color;
  final bool animateColor;
  const BackgroundImage({super.key, required this.color, this.animateColor = false});

  @override
  BackgroundImageState createState() => BackgroundImageState();
}

class BackgroundImageState extends State<BackgroundImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.animateColor) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      )..forward();

      _fadeAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      );
    }
  }

  Color _defineColor(String color) {
    switch (color) {
      case "darkBlue":
        return const Color.fromARGB(255, 0, 81, 255).withValues(alpha: 0.3);
      case "blue":
        return const Color.fromARGB(255, 0, 162, 255).withValues(alpha: 0.3);
      case "purple":
        return const Color.fromARGB(255, 174, 0, 255).withValues(alpha: 0.3);
      case "yellow":
        return const Color.fromARGB(255, 255, 217, 0).withValues(alpha: 0.3);
      case "red":
        return const Color.fromARGB(255, 255, 43, 43).withValues(alpha: 0.3);
      case "pink":
        return const Color.fromARGB(255, 255, 43, 244).withValues(alpha: 0.3);
      case "orange":
        return const Color.fromARGB(255, 255, 123, 0).withValues(alpha: 0.3);
      case "green":
        return const Color.fromARGB(255, 51, 255, 0).withValues(alpha: 0.3);
      case "grey":
      default:
        return const Color.fromARGB(255, 155, 155, 155).withValues(alpha: 0.3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/white_background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: widget.animateColor
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      color: _defineColor(widget.color),
                    ),
                  )
                : Container(
                    color: _defineColor(widget.color),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.animateColor) {
      _controller.dispose();
    }
    super.dispose();
  }
}
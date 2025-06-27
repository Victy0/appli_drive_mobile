import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedWhiteButton extends StatefulWidget {
  final String text;
  const AnimatedWhiteButton({super.key, required this.text});

  @override
  AnimatedWhiteButtonState createState() => AnimatedWhiteButtonState();
}

class AnimatedWhiteButtonState extends State<AnimatedWhiteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  void _startAnimationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      _controller.forward(from: 0);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startAnimationTimer();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.cyanAccent.withValues(alpha: 0.6),
                  Colors.purpleAccent.withValues(alpha: 0.8),
                  Colors.blueAccent.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
                stops: [
                  _animation.value - 0.6,
                  _animation.value - 0.4,
                  _animation.value,
                  _animation.value + 0.4,
                  _animation.value + 0.6
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.lighten,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
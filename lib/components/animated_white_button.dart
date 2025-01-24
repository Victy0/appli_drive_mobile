import 'package:flutter/material.dart';

class AnimatedWhiteButton extends StatefulWidget {
  final AnimationController controller;
  final String text;
  const AnimatedWhiteButton({super.key, required this.controller, required this.text});

  @override
  AnimatedWhiteButtonState createState() => AnimatedWhiteButtonState();
}

class AnimatedWhiteButtonState extends State<AnimatedWhiteButton> {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.cyanAccent.withOpacity(0.6),
                Colors.purpleAccent.withOpacity(0.8),
                Colors.blueAccent.withOpacity(0.6),
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
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ) 
        );
      },
    );
  }
}
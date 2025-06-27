import 'dart:ui';

import 'package:flutter/material.dart';

class PadImage extends StatefulWidget {
  final bool hasAppliarise;
  const PadImage({super.key, required this.hasAppliarise});

  @override
  PadImageState createState() => PadImageState();
}

class PadImageState extends State<PadImage> with SingleTickerProviderStateMixin {
  double _tiltAngle = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _tiltAngle = _animation.value;
        });
      });
  }

  void _animateBackToCenter() {
    _animation = Tween<double>(
      begin: _tiltAngle,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _controller.stop();
          _tiltAngle += details.delta.dx * 0.01;
          _tiltAngle = _tiltAngle.clamp(-0.2, 0.2);
        });
      },
      onPanEnd: (_) => _animateBackToCenter(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.hasAppliarise
              ? dantemonImage()
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 430,
                      height: 430,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/7code/7code_pad.png",
                        height: 410,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget dantemonImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 430,
          height: 430,
          alignment: Alignment.center,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.8),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                "assets/images/7code/CODE.png",
                width: 430,
                height: 430,
              ),
            ),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.007)
            ..rotateY(_tiltAngle),
          child: Image.asset(
            "assets/images/7code/CODE.png",
            width: 430,
            height: 430,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

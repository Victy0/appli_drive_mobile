import 'dart:ui';

import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppliariseImage extends StatefulWidget {
  final Appmon appmon;
  const AppliariseImage({super.key, required this.appmon});

  @override
  AppliariseImageState createState() => AppliariseImageState();
}

class AppliariseImageState extends State<AppliariseImage> with SingleTickerProviderStateMixin {
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

    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
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
    return Column(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _controller.stop();
              _tiltAngle += details.delta.dx * 0.01;
              _tiltAngle = _tiltAngle.clamp(-0.2, 0.2);
            });
          },
          onPanEnd: (_) {
            _animateBackToCenter();
          },
          child: Stack(
            children: [
              // APPMON CONTRAST IMAGE
              Container(
                width: 320,
                height: 320,
                alignment: Alignment.center,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.8),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      "assets/images/appmons/${widget.appmon.id}.png",
                      width: 315,
                      height: 315,
                    ),
                  ),
                ),
              ),
              // APPMON IMAGE
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.007)
                  ..rotateY(_tiltAngle),
                child: Image.asset(
                  "assets/images/appmons/${widget.appmon.id}.png",
                  width: 310,
                  height: 310,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        TextWithWhiteShadow(
          text: AppLocalization.of(context).translate("appmons.names.${widget.appmon.name}"),
          fontSize: 40,
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

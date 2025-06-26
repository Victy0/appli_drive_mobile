import 'dart:ui';

import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppLinkImage extends StatefulWidget {
  final Appmon appmon;
  final Appmon appmonLinked;
  final String linkColor;
  const AppLinkImage({super.key, required this.appmon, required this.appmonLinked, required this.linkColor});

  @override
  AppLinkImageState createState() => AppLinkImageState();
}

class AppLinkImageState extends State<AppLinkImage> with SingleTickerProviderStateMixin {
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

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.0
    ).animate(_controller)
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
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // APPMON LINKED CONTRAST IMAGE
              Transform.translate(
                offset: const Offset(100, -120),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.007)
                    ..rotateY(_tiltAngle),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return scanlineShader(bounds.size);
                    },
                    blendMode: BlendMode.srcATop,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8),
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        "assets/images/appmons/${widget.appmonLinked.id}.png",
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // APPMON CONTRAST IMAGE
              Transform.translate(
                offset: const Offset(-65, 5),
                child: Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8),
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        "assets/images/appmons/${widget.appmon.id}.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ),
              // APPMON LINKED IMAGE
              Transform.translate(
                offset: const Offset(100, -120),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.007)
                    ..rotateY(_tiltAngle),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return scanlineShader(bounds.size);
                    },
                    blendMode: BlendMode.srcATop,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        defineColor(widget.linkColor),
                        BlendMode.modulate,
                      ),
                      child: Image.asset(
                        "assets/images/appmons/${widget.appmonLinked.id}.png",
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // APPMON IMAGE
              Transform.translate(
                offset: const Offset(-70, 0),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.007)
                    ..rotateY(_tiltAngle),
                  child: Image.asset(
                    "assets/images/appmons/${widget.appmon.id}.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextWithWhiteShadow(
                      text: AppLocalization.of(context).translate("appmons.names.${widget.appmon.name}"),
                      fontSize: 40,
                      height: 1.0,
                      align: "left",
                    ),
                  ),
                ],
              ),
              const TextWithWhiteShadow(
                text: "PLUS",
                fontSize: 30,
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextWithWhiteShadow(
                      text: AppLocalization.of(context).translate("appmons.names.${widget.appmonLinked.name}"),
                      fontSize: 40,
                      height: 1.0,
                      align: "right",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color defineColor(color) {
    switch (color) {
      case "blue":
        return const Color.fromARGB(255, 0, 162, 255).withOpacity(0.6);
      case "purple":
        return const Color.fromARGB(255, 188, 45, 255).withOpacity(0.6);
      case "yellow":
        return const Color.fromARGB(255, 255, 217, 0).withOpacity(0.6);
      case "red":
        return const Color.fromARGB(255, 255, 11, 11).withOpacity(0.6);
      case "pink":
        return const Color.fromARGB(255, 255, 43, 244).withOpacity(0.6);
      case "orange":
        return const Color.fromARGB(255, 255, 123, 0).withOpacity(0.6);
      case "green":
        return const Color.fromARGB(255, 44, 219, 0).withOpacity(0.6);
      case "grey":
      default:
        return const Color.fromARGB(255, 155, 155, 155).withOpacity(0.6);
    }
  }

  Shader scanlineShader(Size size) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: List.generate(
        (size.height / 2).floor(),
        (i) => i.isEven
          ? Colors.white.withOpacity(0.5)
          : Colors.transparent,
      ),
      stops: List.generate(
        (size.height / 2).floor(),
        (i) => i / (size.height / 2),
      ),
      tileMode: TileMode.repeated,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

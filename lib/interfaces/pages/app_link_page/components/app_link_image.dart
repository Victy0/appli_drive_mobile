import 'dart:async';
import 'dart:ui';

import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AppLinkImage extends StatefulWidget {
  final Appmon appmon;
  final Appmon appmonLinked;
  final String linkColor;
  const AppLinkImage({super.key, required this.appmon, required this.appmonLinked, required this.linkColor});

  @override
  AppLinkImageState createState() => AppLinkImageState();
}

class AppLinkImageState extends State<AppLinkImage> {
  double _tiltAngle = 0.0;
  StreamSubscription<AccelerometerEvent>? _accelSub;
  
  @override
  void initState() {
    super.initState();

    _accelSub = accelerometerEvents.listen((AccelerometerEvent event) {
      if (!mounted) return;
      setState(() {
        _tiltAngle = event.x * 0.02;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Stack(
          alignment: Alignment.center,
          children: [
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
                  ..rotateY(-_tiltAngle),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return _buildScanlineShader(bounds.size);
                  },
                  blendMode: BlendMode.srcATop,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      _defineColor(widget.linkColor),
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
        // SPACING
        const SizedBox(height: 5),
        // APPMON NAME
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).translate("appmons.names.${widget.appmon.name}"),
              style: const TextStyle(
                fontSize: 40,
                height: 1.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, 2),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            Text(
              AppLocalization.of(context).translate("PLUS"),
              style: const TextStyle(
                fontSize: 30,
                height: 1.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, 2),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            Text(
              AppLocalization.of(context).translate("appmons.names.${widget.appmonLinked.name}"),
              style: const TextStyle(
                fontSize: 40,
                height: 1.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(2, -2),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-2, 2),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _defineColor(color) {
    switch (color) {
      case "blue":
        return const Color.fromARGB(255, 0, 162, 255).withOpacity(0.6);
      case "purple":
        return const Color.fromARGB(255, 174, 0, 255).withOpacity(0.6);
      case "yellow":
        return const Color.fromARGB(255, 255, 217, 0).withOpacity(0.6);
      case "red":
        return const Color.fromARGB(255, 255, 11, 11).withOpacity(0.6);
      case "pink":
        return const Color.fromARGB(255, 255, 43, 244).withOpacity(0.6);
      case "orange":
        return const Color.fromARGB(255, 255, 123, 0).withOpacity(0.6);
      case "green":
        return const Color.fromARGB(255, 51, 255, 0).withOpacity(0.6);
      case "grey":
      default:
        return const Color.fromARGB(255, 155, 155, 155).withOpacity(0.6);
    }
  }

  Shader _buildScanlineShader(Size size) {
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
    _accelSub?.cancel();
    super.dispose();
  }
}

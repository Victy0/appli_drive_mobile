import 'dart:async';
import 'dart:ui';

import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AppliariseImage extends StatefulWidget {
  final Appmon appmon;
  const AppliariseImage({super.key, required this.appmon});

  @override
  AppliariseImageState createState() => AppliariseImageState();
}

class AppliariseImageState extends State<AppliariseImage> {
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
                    Colors.white.withOpacity(0.8),
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
        // SPACING
        const SizedBox(height: 5),
        // APPMON NAME
        TextWithWhiteShadow(
          text: AppLocalization.of(context).translate("appmons.names.${widget.appmon.name}"),
          fontSize: 40,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _accelSub?.cancel();
    super.dispose();
  }
}

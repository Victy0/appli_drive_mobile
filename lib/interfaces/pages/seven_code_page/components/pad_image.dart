import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PadImage extends StatefulWidget {
  final bool hasAppliarise;
  const PadImage({super.key, required this.hasAppliarise});

  @override
  PadImageState createState() => PadImageState();
}

class PadImageState extends State<PadImage> {
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
                Colors.white.withOpacity(0.8),
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
    _accelSub?.cancel();
    super.dispose();
  }
}

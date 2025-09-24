import 'dart:math';
import 'dart:ui';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppLinkInit extends StatefulWidget {
  final Appmon appmon;
  final Appmon appmonLinked;
  final Appmon? appmonFusioned;
  const AppLinkInit({
    super.key,
    required this.appmon,
    required this.appmonLinked,
    required this.appmonFusioned,
  });

  @override
  State<AppLinkInit> createState() => AppLinkInitState();
}

class AppLinkInitState extends State<AppLinkInit> with TickerProviderStateMixin {
  final List<Offset> initialPositions = [];

  late final AnimationController _contentController;
  late final AnimationController _cornerController;

  double _getAppmonLinkedRatio(){
    if(widget.appmon.grade.id > widget.appmonLinked.grade.id) {
      return 50;
    }
    return 10;
  }

  Offset _spiralPosition(Offset start, Offset center, Size size, double t, {double turns = 3.5}) {
    final dx = start.dx - center.dx;
    final dy = start.dy - center.dy;
    final initialRadius = sqrt(dx * dx + dy * dy);
    final startAngle = atan2(dy, dx);
    final eased = Curves.easeInOut.transform(t);
    final r = initialRadius * (1 - eased);
    final theta = startAngle + turns * 2 * pi * eased;

    final x = center.dx + r * cos(theta);
    final y = center.dy + r * sin(theta);
    return Offset(x, y);
  }

  @override
  void initState() {
    super.initState();

    _contentController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _cornerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 13),
    );
    _cornerController.forward().whenComplete(() {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _cornerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final center = Offset(size.width / 2, size.height / 2);

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_contentController, _cornerController]),
            builder: (context, child) {
              return Stack(
                children: [
                  // APPMON 1
                  Builder(
                    builder: (context) {
                      final t = _cornerController.value;
                      final imgSize = lerpDouble(200, 150, t) ?? 150;
                      final start = Offset(imgSize / 2, imgSize / 2);
                      final pos = _spiralPosition(start, center, size, t, turns: 14);
                      return Positioned(
                        left: pos.dx - imgSize / 2,
                        top: pos.dy - imgSize / 2,
                        child: Opacity(
                          opacity: 1,
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            child: SizedBox(
                              width: imgSize,
                              height: imgSize,
                              child: Image.asset(
                                "assets/images/appmons/${widget.appmon.id}.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // APPMON 2
                  Builder(
                    builder: (context) {
                      final t = _cornerController.value;
                      final imgSize = lerpDouble(200, 150, t) ?? 150;
                      final start = Offset(size.width - imgSize / 2, size.height - imgSize / 2);
                      final pos = _spiralPosition(start, center, size, t, turns: 14);
                      return Positioned(
                        left: pos.dx - imgSize / 2,
                        top: pos.dy - imgSize / 2,
                        child: Opacity(
                        opacity: 1,
                        child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            child: SizedBox(
                              width: imgSize,
                              height: imgSize,
                              child: Image.asset(
                                "assets/images/appmons/${widget.appmonLinked.id}.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // APPMON FINAL
                  if(widget.appmonFusioned != null) ...[
                    Center(
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _contentController,
                          curve: Curves.easeInOut,
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(
                            "assets/images/appmons/${widget.appmonFusioned?.id}.png",
                            width: widget.appmonFusioned?.imageSize.toDouble(),
                            height: widget.appmonFusioned?.imageSize.toDouble(),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _contentController,
                          curve: Curves.easeInOut,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // APPMON LINKED CONTRAST IMAGE
                            Transform.translate(
                              offset: const Offset(100, -120),
                              child: OverflowBox(
                                maxWidth: 500,
                                maxHeight: 500,
                                child: SizedBox(
                                  width: widget.appmonLinked.imageSize - _getAppmonLinkedRatio(),
                                  height: widget.appmonLinked.imageSize - _getAppmonLinkedRatio(),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.007)
                                      ..rotateY(0.0),
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return scanlineShader(bounds.size);
                                      },
                                      blendMode: BlendMode.srcATop,
                                      child: ColorFiltered(
                                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                        child: Image.asset(
                                          "assets/images/appmons/${widget.appmonLinked.id}.png",
                                          width: widget.appmonLinked.imageSize - _getAppmonLinkedRatio(),
                                          height: widget.appmonLinked.imageSize - _getAppmonLinkedRatio(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // APPMON CONTRAST IMAGE
                            Transform.translate(
                              offset: const Offset(-65, 5),
                              child: OverflowBox(
                                maxWidth: 500,
                                maxHeight: 500,
                                child: SizedBox(
                                  width: widget.appmon.imageSize + 10,
                                  height: widget.appmon.imageSize + 10,
                                  child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      child: Image.asset(
                                        "assets/images/appmons/${widget.appmon.id}.png",
                                        width: widget.appmon.imageSize + 10,
                                        height: widget.appmon.imageSize + 10,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Shader scanlineShader(Size size) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: List.generate(
        (size.height / 2).floor(),
        (i) => i.isEven
          ? Colors.white.withValues(alpha: 0.5)
          : Colors.transparent,
      ),
      stops: List.generate(
        (size.height / 2).floor(),
        (i) => i / (size.height / 2),
      ),
      tileMode: TileMode.repeated,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  }
}

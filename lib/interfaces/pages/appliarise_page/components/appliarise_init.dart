import 'dart:math';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppliariseInit extends StatefulWidget {
  final Appmon appmon;
  const AppliariseInit({
    super.key,
    required this.appmon,
  });

  @override
  State<AppliariseInit> createState() => AppliariseInitState();
}

class AppliariseInitState extends State<AppliariseInit> with TickerProviderStateMixin {
  final List<Offset> initialPositions = [];

  late final AnimationController _textController;
  late final AnimationController _contentController;
  late final Animation<double> _moveCurve;
  late final Animation<double> _opacityAnimation;

  List<String> words = [];
  List<double> fontSizes = [];
  bool showWords = false;

  String _getAppliariseText(){
    switch(widget.appmon.grade.name){
      case "super":
        return "SUPER\nAPPLIARISE";
      case "ultimate":
        return "ULTIMATE\nAPPLIARISE";
      case "god":
        return "GOSH\nAPPLIARISE";
      default:
        return "APPLIARISE";
    }
  }

  void _generateFontSizes() {
    if (fontSizes.length != words.length) {
      fontSizes.clear();
      for (int i = 0; i < words.length; i++) {
        fontSizes.add(Random().nextInt(16) + 15);
      }
    }
  }

  int _getDelayAnimationText(int grade) {
    if (grade == 2) {
      return 1;
    }
    return 0;
  }

  int _getDelayAnimationContent(int grade) {
    if (grade == 2) {
      return 3;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    words = [
      widget.appmon.name.toUpperCase(), "APPMON", widget.appmon.grade.name.toUpperCase(), "DIGITAL",
      widget.appmon.type.name.toUpperCase(), "DIGIMON", widget.appmon.app.toUpperCase(), "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
      widget.appmon.name.toUpperCase(), "APPMON", widget.appmon.grade.name.toUpperCase(), "DIGITAL",
      widget.appmon.type.name.toUpperCase(), "DIGIMON", widget.appmon.app.toUpperCase(), "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
      widget.appmon.name.toUpperCase(), "APPMON", widget.appmon.grade.name.toUpperCase(), "DIGITAL",
      widget.appmon.type.name.toUpperCase(), "DIGIMON", widget.appmon.app.toUpperCase(), "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
      widget.appmon.name.toUpperCase(), "APPMON", widget.appmon.grade.name.toUpperCase(), "DIGITAL",
      widget.appmon.type.name.toUpperCase(), "DIGIMON", widget.appmon.app.toUpperCase(), "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
    ];
    _generateFontSizes();
    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3 + _getDelayAnimationText(widget.appmon.grade.id)),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8 + _getDelayAnimationContent(widget.appmon.grade.id)),
    );
    _moveCurve = CurvedAnimation(
      parent: _contentController,
      curve: Curves.fastOutSlowIn,
    );

    Future.delayed(Duration(seconds: 4 + _getDelayAnimationText(widget.appmon.grade.id)), () {
      _textController.forward();
      setState(() => showWords = true);
      _contentController.forward();
    });

    final random = Random();
    for (int i = 0; i < words.length; i++) {
      initialPositions.add(Offset(
        random.nextDouble() * 2 - 1,
        random.nextDouble() * 2 - 1,
      ));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                final scale = Tween<double>(begin: 1.0, end: 0.4)
                  .transform(Curves.easeInOut.transform(_textController.value));
                final opacity = _opacityAnimation.value;
                return Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Text(
                      _getAppliariseText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (showWords)
            AnimatedBuilder(
              animation: _contentController,
              builder: (context, child) {
                return Stack(
                  children: [
                    for (int i = 0; i < words.length; i++)
                      Positioned(
                        left: size.width / 2 +
                            initialPositions[i].dx *
                                size.width *
                                (1 - _moveCurve.value),
                        top: size.height / 2 +
                            initialPositions[i].dy *
                                size.height *
                                (1 - _moveCurve.value),
                        child: Opacity(
                          opacity: 1 - _contentController.value,
                          child: Transform.translate(
                            offset: const Offset(-70, 0),
                            child: Text(
                              words[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizes[i],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            "assets/images/appmons/${widget.appmon.id}.png",
                            width: widget.appmon.imageSize.toDouble(),
                            height: widget.appmon.imageSize.toDouble(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

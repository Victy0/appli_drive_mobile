import 'dart:math';

import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppliariseInit extends StatefulWidget {
  final Appmon appmon;
  const AppliariseInit({super.key, required this.appmon});

  @override
  State<AppliariseInit> createState() => AppliariseInitState();
}

class AppliariseInitState extends State<AppliariseInit> with TickerProviderStateMixin {
  List<String> words = [];
  final List<Offset> initialPositions = [];

  late final AnimationController _textController;
  late final AnimationController _contentController;
  late final Animation<double> _opacityAnimation;

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

  @override
  void initState() {
    super.initState();
    words = [
      widget.appmon.name, "APPMON", widget.appmon.grade.name, "DIGITAL", widget.appmon.type.name, "DIGIMON", widget.appmon.app, "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
      widget.appmon.name, "APPMON", widget.appmon.grade.name, "DIGITAL", widget.appmon.type.name, "CONNECT", widget.appmon.app, "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
      widget.appmon.name, "APPMON", widget.appmon.grade.name, "DIGITAL", widget.appmon.type.name, "DIGIMON", widget.appmon.app, "APP",
      "アプモン", "アプリモンスター", "NET", "CODE", "アプリアライズ", "人工知能", "MONSTER", "デジモン",
    ];
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _textController.forward().whenComplete(() {
        setState(() => showWords = true);
        _contentController.forward();
      });
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
                                (1 - _contentController.value),
                        top: size.height / 2 +
                            initialPositions[i].dy *
                                size.height *
                                (1 - _contentController.value),
                        child: Opacity(
                          opacity: 1 - _contentController.value,
                          child: Text(
                            words[i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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

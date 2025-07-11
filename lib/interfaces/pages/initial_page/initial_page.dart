import 'dart:math';

import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/interfaces/components/version_app.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/services/audio_service_continuous.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';

class InitialPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const InitialPage({super.key, required this.onLanguageChange});

  @override
  InitialPageState createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> with TickerProviderStateMixin {
  final PreferencesService _preferencesService = PreferencesService();
  final AudioPlayer _audioPlayerContinuous = AudioServiceContinuous.instance.player;

  final Screen _screen = Screen();
  Stream<ScreenStateEvent>? _screenStream;

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  late AnimationController _controllerText;
  late Animation<double> _opacityAnimationText;

  void _startMonitoring() {
    _screenStream = _screen.screenStateStream;
    _screenStream?.listen((event) {
      if (event == ScreenStateEvent.SCREEN_OFF) {
        _audioPlayerContinuous.pause();
      } else if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
        _audioPlayerContinuous.resume();
      }
    });
  }

  Future<void> _checkIfLanguageHasBeenChosen() async {
    String? languageCode = await _preferencesService.getString(
      AppPreferenceKey.selectLanguage,
    );

    if (languageCode == null) {
      _showLanguageDialog();
    }
  }

  Future<void> _showLanguageDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: widget.onLanguageChange),
    );
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerContinuous.play(AssetSource('sounds/initial_page.mp3'));
    _startMonitoring();

    _controllers = List.generate(12, (index) {
      return AnimationController(
        vsync: this,
        duration: Duration(seconds: 3 + index % 4),
      )..repeat();
    });
    _animations = _controllers.map((controller) {
      return Tween<double>(begin: -0.2, end: 1.2).animate(controller);
    }).toList();

    _controllerText = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _opacityAnimationText = Tween<double>(begin: 0.0, end: 1.0).animate(_controllerText);

    _checkIfLanguageHasBeenChosen();
  }

  void _navigateToHomePage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await _audioPlayerContinuous.stop();
    navigator.pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(onLanguageChange: widget.onLanguageChange, initSound: true),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: Alignment.center,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: -1.0,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
      onTap: () => _navigateToHomePage(context),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [Color.fromARGB(255, 2, 0, 70), Color.fromARGB(255, 12, 71, 182)],
                ),
              ),
              child: AnimatedBuilder(
                animation: Listenable.merge(_controllers),
                builder: (context, child) {
                  return CustomPaint(
                    painter: NeonLinesPainter(_animations.map((anim) => anim.value).toList()),
                    child: Container(),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 350,
                height: 350,
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _opacityAnimationText,
                  builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimationText.value,
                    child: child,
                  );
                },
                  child: Text(
                    AppLocalization.of(context).translate("pages.initialPage.tapToStart"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: VersionApp(),
              ),
            ),
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllerText.dispose();
    super.dispose();
  }
}

class NeonLinesPainter extends CustomPainter {
  final List<double> progressValues;
  NeonLinesPainter(this.progressValues);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double maxLength = max(size.width, size.height);

    for (int i = 0; i < progressValues.length; i++) {
      double angle = (2 * pi / progressValues.length) * i;
      double animatedProgress = progressValues[i] * maxLength;

      Paint paint = Paint()
        ..color = const Color.fromARGB(225, 31, 241, 237).withOpacity((1.0 - progressValues[i] * 0.8).clamp(0.0, 1.0))
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);

      Offset start = Offset(
        center.dx + cos(angle) * (animatedProgress * 0.1),
        center.dy + sin(angle) * (animatedProgress * 0.1),
      );

      Offset end = Offset(
        center.dx + cos(angle) * animatedProgress,
        center.dy + sin(angle) * animatedProgress,
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

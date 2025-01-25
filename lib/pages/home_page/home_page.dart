import 'dart:async';

import 'package:appli_drive_mobile/components/animated_white_button.dart';
import 'package:appli_drive_mobile/components/layout_details/detail_rectangle_left.dart';
import 'package:appli_drive_mobile/components/layout_details/detail_rectangle_right.dart';
import 'package:appli_drive_mobile/pages/home_page/components/header_icons.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/pages/home_page/components/menu_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HomePage({super.key, required this.onLanguageChange});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _controller;
  Timer? _timer;

  void _startAnimationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      _controller.forward(from: 0);
    });
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.play(AssetSource('sounds/start.mp3'));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _startAnimationTimer();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 223, 223, 223),
      body: Stack(
        children: [
          // detail top
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                HeaderIcons(onLanguageChange: widget.onLanguageChange),
                const DetailRectangleLeft(),
              ]
            ),
          ),
          // content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      AppLocalization.of(context).translate("pages.homePage.pairing"),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "- ${AppLocalization.of(context).translate("appmons.names")} -",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('criar dialog para confirmar Appliarise');
                      },
                      child: Image.asset(
                        'assets/images/chips/gatchmon.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 70),

                GestureDetector(
                  onTap: () {
                    print('Abrir camera para ler qr code');
                  },
                  child: AnimatedWhiteButton(controller: _controller, text: 'APPLIARISE'),
                ),

                const SizedBox(height: 20),

                const MenuIcons(),
              ],
            ),
          ),
          // detail bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${AppLocalization.of(context).translate("pages.homePage.appliDriveVersion")} - STANDART",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const DetailRectangleRight(),
              ]
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

import 'package:appli_drive_mobile/components/animated_white_button.dart';
import 'package:appli_drive_mobile/components/background_image.dart';
import 'package:appli_drive_mobile/components/layout_details/detail_rectangle_left.dart';
import 'package:appli_drive_mobile/components/layout_details/detail_rectangle_right.dart';
import 'package:appli_drive_mobile/pages/home_page/components/header_icons.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/pages/home_page/components/menu_icons.dart';
import 'package:appli_drive_mobile/pages/home_page/components/pairing_menu.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HomePage({super.key, required this.onLanguageChange});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.play(AssetSource('sounds/start.mp3'));
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(color: "grey"),
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
                const PairingMenu(),
                const SizedBox(height: 70),
                GestureDetector(
                  onTap: () {
                    print('Abrir camera para ler qr code');
                  },
                  child: const AnimatedWhiteButton(text: 'APPLIARISE'),
                ),
                const SizedBox(height: 20),
                MenuIcons(onLanguageChange: widget.onLanguageChange),
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
}

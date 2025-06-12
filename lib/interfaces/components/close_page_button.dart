import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../services/audio_service_momentary.dart';

class ClosePageButton extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const ClosePageButton({super.key, required this.onLanguageChange});

  @override
  ClosePageButtonState createState() => ClosePageButtonState();
}

class ClosePageButtonState extends State<ClosePageButton> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: GestureDetector(
          onTap: () {
            _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(
                  onLanguageChange: widget.onLanguageChange,
                  initSound: false,
                ),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalization.of(context).translate("components.closePageButton.exit"),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

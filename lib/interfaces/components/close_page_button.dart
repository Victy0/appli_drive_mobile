import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../services/audio_service_momentary.dart';

class ClosePageButton extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final void Function(BuildContext)? onTap;
  const ClosePageButton({super.key, required this.onLanguageChange, this.onTap});

  @override
  ClosePageButtonState createState() => ClosePageButtonState();
}

class ClosePageButtonState extends State<ClosePageButton> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;

  void _defaultOnTap(BuildContext context) {
    _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(
          onLanguageChange: widget.onLanguageChange,
          initSound: false,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(context);
            } else {
              _defaultOnTap(context);
            }
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
              TextWithWhiteShadow(
                text: AppLocalization.of(context).translate("components.closePageButton.exit"),
                fontSize: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

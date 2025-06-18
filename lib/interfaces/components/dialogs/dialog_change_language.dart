import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogChangeLanguage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const DialogChangeLanguage({super.key, required this.onLanguageChange});

  @override
  DialogChangeLanguageState createState() => DialogChangeLanguageState();
}

class DialogChangeLanguageState extends State<DialogChangeLanguage> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  final List<Map<String, dynamic>> _languages = [
    {'label': 'Português', 'locale': const Locale('pt', 'BR'), 'flag': 'assets/images/flags/br.png'},
    {'label': 'English', 'locale': const Locale('en', 'US'), 'flag': 'assets/images/flags/us.png'},
    {'label': '日本語', 'locale': const Locale('ja', 'JP'), 'flag': 'assets/images/flags/jp.png'},
  ];

  late Locale _selectedLocale;

  Future<Locale> getSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selected_language');
    String? countryCode = prefs.getString('selected_country');

    if (languageCode != null && countryCode != null) {
      return Locale(languageCode, countryCode);
    }

    return WidgetsBinding.instance.platformDispatcher.locale;
  }

  @override
  void initState() {
    super.initState();
    getSavedLocale().then((locale) {
      setState(() {
        _selectedLocale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("components.dialogs.changeLanguage.chooseLanguage"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<Locale>(
              value: _selectedLocale,
              onChanged: (Locale? newLocale) {
                setState(() {
                  _selectedLocale = newLocale!;
                });
                widget.onLanguageChange(_selectedLocale);
              },
              items: _languages.map<DropdownMenuItem<Locale>>((language) {
                return DropdownMenuItem<Locale>(
                  value: language['locale'],
                  child: Row(
                    children: [
                      Image.asset(
                        language['flag'],
                        width: 35,
                        height: 25,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        language['label'],
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('selected_language', _selectedLocale.languageCode);
            await prefs.setString('selected_country', _selectedLocale.countryCode ?? '');

            navigator.pop();
          },
          child: const Icon(
            Icons.check,
            size: 40.0,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class DialogChangeLanguage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const DialogChangeLanguage({super.key, required this.onLanguageChange});

  @override
  DialogChangeLanguageState createState() => DialogChangeLanguageState();
}

class DialogChangeLanguageState extends State<DialogChangeLanguage> {
  Locale _selectedLocale = const Locale('pt', 'BR');

  final List<Map<String, dynamic>> _languages = [
    {'label': 'Português', 'locale': const Locale('pt', 'BR'), 'flag': 'assets/images/flags/br.png'},
    {'label': 'English', 'locale': const Locale('en', 'US'), 'flag': 'assets/images/flags/us.png'},
    {'label': '日本語', 'locale': const Locale('ja', 'JP'), 'flag': 'assets/images/flags/jp.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("componentsDialogs.changeLanguage.chooseLanguage"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      content: Column(
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
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            Icons.check_circle_rounded,
            size: 30.0,
            color: Colors.green,
          )
        ),
      ],
    );
  }
}
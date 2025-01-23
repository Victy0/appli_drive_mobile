import 'package:appli_drive_mobile/components/icon_information.dart';
import 'package:appli_drive_mobile/components/icon_language.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HomePage({super.key, required this.onLanguageChange});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: Stack(
        children: [
          Center(
            child: Text(AppLocalization.of(context).translate("components.versionApp.version"))
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 36.0, right: 16.0, bottom: 16.0, left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IconInformation(),
                  IconLanguage(onLanguageChange: widget.onLanguageChange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

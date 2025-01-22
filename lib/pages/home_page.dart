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
        ],
      ),
    );
  }
}
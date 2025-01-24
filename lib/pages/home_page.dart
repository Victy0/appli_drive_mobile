import 'package:appli_drive_mobile/components/detail_rectangle_left_component.dart';
import 'package:appli_drive_mobile/components/detail_rectangle_right_component.dart';
import 'package:appli_drive_mobile/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/components/icon_information.dart';
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
                // system icons
                Padding(
                  padding: const EdgeInsets.only(top: 36.0, right: 16.0, bottom: 16.0, left: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IconInformation(),
                      IconButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: widget.onLanguageChange),
                        ),
                        icon: Image.asset(
                          'assets/images/icons/language_box.png',
                          height: 40,
                        ),
                      )
                    ],
                  ),
                ),
                const DetailRectangleLeftComponent(),
              ]
            ),
          ),
          // content
          Center(
            child: Text(AppLocalization.of(context).translate("components.versionApp.version"))
          ),
          // detail bottom
          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: DetailRectangleRightComponent(),
          ),
        ],
      ),
    );
  }
}

class InvertedDiagonalClipper extends CustomClipper<Path> {
  final double breakSize;
  const InvertedDiagonalClipper({required this.breakSize});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(breakSize, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

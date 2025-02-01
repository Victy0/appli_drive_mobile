import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppmonImage extends StatefulWidget {
  final Appmon appmon;
  const AppmonImage({super.key, required this.appmon});

  @override
  AppmonImageState createState() => AppmonImageState();
}

class AppmonImageState extends State<AppmonImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/appmons/${widget.appmon.id}.png",
          width: 310,
          height: 310,
        ),
        const SizedBox(height: 5),
        Text(
          AppLocalization.of(context).translate("appmons.names.${widget.appmon.name}"),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
              Shadow(
                color: Colors.white,
                offset: Offset(2, 2),
                blurRadius: 10,
              ),
              Shadow(
                color: Colors.white,
                offset: Offset(-2, -2),
                blurRadius: 10,
              ),
              Shadow(
                color: Colors.white,
                offset: Offset(2, -2),
                blurRadius: 10,
              ),
              Shadow(
                color: Colors.white,
                offset: Offset(-2, 2),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

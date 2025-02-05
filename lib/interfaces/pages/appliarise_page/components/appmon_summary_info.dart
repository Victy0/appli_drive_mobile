import 'dart:ui';

import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppmonSummaryInfo extends StatefulWidget {
  final Appmon appmon;
  const AppmonSummaryInfo({super.key, required this.appmon});

  @override
  AppmonSummaryInfoState createState() => AppmonSummaryInfoState();
}

class AppmonSummaryInfoState extends State<AppmonSummaryInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          margin: const EdgeInsets.only(left: 0, right: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/apps/${widget.appmon.id}.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  AppLocalization.of(context).translate("appmons.apps.${widget.appmon.app}"),
                  style: const TextStyle(
                    fontSize: 24,
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
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 5),

        Container(
          margin: const EdgeInsets.only(left: 30, right: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                AppLocalization.of(context).translate("appmons.types.${widget.appmon.type.name}"),
                style: const TextStyle(
                  fontSize: 24,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: 
                  Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/types/${widget.appmon.type.name}.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

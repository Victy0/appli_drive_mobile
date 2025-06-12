import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppLinkSummaryInfo extends StatefulWidget {
  final Appmon appmon;
  final Appmon appmonLinked;
  const AppLinkSummaryInfo({super.key, required this.appmon, required this.appmonLinked});

  @override
  AppLinkSummaryInfoState createState() => AppLinkSummaryInfoState();
}

class AppLinkSummaryInfoState extends State<AppLinkSummaryInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          margin: const EdgeInsets.only(left: 0, right: 10),
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

        Container(
          margin: const EdgeInsets.only(left: 10, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  AppLocalization.of(context).translate("appmons.apps.${widget.appmonLinked.app}"),
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
                  textAlign: TextAlign.right,
                ),
              ),
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
                    "assets/images/apps/${widget.appmonLinked.id}.png",
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

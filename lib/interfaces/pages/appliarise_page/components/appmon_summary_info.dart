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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  "assets/images/apps/${widget.appmon.id}.png",
                  width: 60,
                  height: 60,
                ),
              ),
              Expanded(
                child: Text(
                  AppLocalization.of(context).translate("appmons.apps.${widget.appmon.app}"),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                AppLocalization.of(context).translate("appmons.types.${widget.appmon.type.name}"),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  "assets/images/types/${widget.appmon.type.name}.png",
                  width: 60,
                  height: 60,
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}

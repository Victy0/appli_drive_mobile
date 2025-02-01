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
        Text(
          "APP ${AppLocalization.of(context).translate("appmons.grades.${widget.appmon.grade.name}")}",
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppLocalization.of(context).translate("appmons.apps.${widget.appmon.app}"),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          AppLocalization.of(context).translate("appmons.types.${widget.appmon.type.name}"),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

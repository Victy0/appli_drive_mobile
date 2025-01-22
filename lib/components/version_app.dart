import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class VersionApp extends StatelessWidget {
  const VersionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("${AppLocalization.of(context).translate("version")} 0.0.1");
  }
}
import 'package:appli_drive_mobile/components/dialogs/dialog_change_language.dart';
import 'package:flutter/material.dart';

class IconLanguage extends StatelessWidget {
  final Function(Locale) onLanguageChange;
  const IconLanguage({super.key, required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: onLanguageChange),
      ),
      icon: Image.asset(
        'assets/images/icons/language_box.png',
        height: 40,
      ),
    );
  }
}

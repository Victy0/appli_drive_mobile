import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_appmon_code_list.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_change_language.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class HeaderIconsHome extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HeaderIconsHome({super.key, required this.onLanguageChange});

  @override
  HeaderIconsHomeState createState() => HeaderIconsHomeState();
}

class HeaderIconsHomeState extends State<HeaderIconsHome> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late List<Map<String, dynamic>> appmonCodeList;
  
  _getAppmonCodeList() async {
    appmonCodeList = await _databaseHelper.getAppmonCodeList();
  }

  @override
  void initState() {
    super.initState();
    _getAppmonCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconInformation(context),
          const SizedBox(width: 15),
          iconLanguage(context, widget.onLanguageChange),
          const Spacer(),
          iconAppmonListCode(context)
        ],
      ),
    );
  }

  Widget iconInformation(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Center( 
              child: Text(
                'Título',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            content: const SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contexto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.check,
                  size: 40.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        icon: Image.asset(
          'assets/images/icons/question_mark_box.png',
          height: 40,
        ),
      ),
    );
  }

  Widget iconLanguage(context, onLanguageChange) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DialogChangeLanguage(onLanguageChange: onLanguageChange),
        ),
        icon: Image.asset(
          'assets/images/icons/language_box.png',
          height: 40,
        ),
      ),
    );
  }

  Widget iconAppmonListCode(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DialogAppmonCodeList(appmonCodeList: appmonCodeList),
        ),
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 40,
        ),
      ),
    );
  }
}

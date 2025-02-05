import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DialogAppmonCodeList extends StatefulWidget {
  final List<Map<String, dynamic>> appmonCodeList;
  const DialogAppmonCodeList({super.key, required this.appmonCodeList});

  @override
  DialogAppmonCodeListState createState() => DialogAppmonCodeListState();
}

class DialogAppmonCodeListState extends State<DialogAppmonCodeList> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("componentsDialogs.appmonCodeList.codeList"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildGroupedList(widget.appmonCodeList),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.check,
            size: 40.0,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGroupedList(List<Map<String, dynamic>> appmonCodeList) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in appmonCodeList) {
      String gradeName = item['gradeName'];
      if (!groupedItems.containsKey(gradeName)) {
        groupedItems[gradeName] = [];
      }
      groupedItems[gradeName]!.add(item);
    }

    List<Widget> codeWidgets = [];

    groupedItems.forEach((gradeName, items) {
      codeWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            AppLocalization.of(context).translate("appmons.grades.$gradeName"),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      );
      for (var item in items) {
        codeWidgets.add(
          Column(
            children: [
              ListTile(
                leading: Image.asset(
                  "assets/images/apps/${item['id']}.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  item['code'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
    return codeWidgets;
  }
}

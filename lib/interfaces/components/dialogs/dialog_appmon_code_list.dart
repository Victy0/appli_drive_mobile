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

  _getAppmonQuantityByGrade(String grade) {
    switch(grade) {
      case "standard":
        return 74;
      case "super":
        return 37;
      case "ultimate":
        return 14;
      case "god":
        return 6;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  AppLocalization.of(context).translate("components.dialogs.appmonCodeList.codeList"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: groupedList(widget.appmonCodeList),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> groupedList(List<Map<String, dynamic>> appmonCodeList) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in appmonCodeList) {
      String gradeName = item['gradeName'];
      groupedItems.putIfAbsent(gradeName, () => []).add(item);
    }

    return groupedItems.entries.map((entry) {
      final gradeName = entry.key;
      final items = entry.value;
      final titleText = AppLocalization.of(context).translate("appmons.grades.$gradeName");
      final appmonQuantity = _getAppmonQuantityByGrade(gradeName);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              childrenPadding: const EdgeInsets.all(16),
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      titleText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${items.length}/$appmonQuantity",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              children: items.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/apps/${item['id']}.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
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
              }).toList(),
            ),
          ),
        ),
      );
    }).toList();
  }
}

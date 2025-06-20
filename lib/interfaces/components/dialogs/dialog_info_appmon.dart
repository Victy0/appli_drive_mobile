import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DialogInfoAppmon extends StatefulWidget {
  final Appmon? appmon;
  final String interface;
  final String imageDirectory;
  final bool showChipContainer;
  const DialogInfoAppmon({
    super.key,
    required this.appmon,
    required this.interface,
    this.imageDirectory = "apps",
    this.showChipContainer = false,
  });

  @override
  DialogInfoAppmonState createState() => DialogInfoAppmonState();
}

class DialogInfoAppmonState extends State<DialogInfoAppmon> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _getColorDialogBackground(),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              nameContainer(),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      appContainer(),
                      divider(),
                      gradeContainer(),
                      divider(),
                      typeContainer(),
                      divider(),
                      powerContainer(),
                      divider(),
                      profileContainer(),
                      if (widget.showChipContainer) ...[
                        divider(),
                        chipContainer(),
                      ],
                    ],
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

  Color _getColorDialogBackground() {
    switch (widget.interface){
      case "appliArise":
        return const Color.fromARGB(255, 223, 222, 222);
      case "7code":
        return const Color.fromARGB(255, 189, 145, 190);
      case "dataCenter":
      default:
        return const Color.fromARGB(255, 171, 224, 255);
    }
  }

  Color _getColorBackground() {
    return const Color.fromARGB(255, 255, 255, 255);
  }

  Color _getColorBorderAndText() {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  Widget nameContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalization.of(context)
                        .translate("components.dialogs.infoAppmon.name"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _getColorBorderAndText(),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalization.of(context)
                        .translate("appmons.names.${widget.appmon?.name}"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _getColorBorderAndText(),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Divider(
        height: 10,
        thickness: 1,
        color: Colors.transparent,
      ),
    );
  }

  Widget appContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.app"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              children: [
                if (widget.appmon?.app != "open")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      "assets/images/${widget.imageDirectory}/${widget.appmon?.id}.png",
                      width: 45,
                      height: 45,
                    ),
                  ),
                Expanded(
                  child: Text(
                    AppLocalization.of(context).translate("appmons.apps.${widget.appmon?.app}"),
                    style: TextStyle(
                      color: _getColorBorderAndText(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget gradeContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.grade"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalization.of(context).translate("appmons.grades.${widget.appmon?.grade.name}"),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget typeContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.type"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              children: [
                if (widget.appmon?.type.name != "none")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      "assets/images/types/${widget.appmon!.type.name}.png",
                      width: 45,
                      height: 45,
                    ),
                  ),
                Expanded(
                  child: Text(
                    AppLocalization.of(context).translate("appmons.types.${widget.appmon?.type.name}"),
                    style: TextStyle(
                      color: _getColorBorderAndText(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget powerContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.power"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.appmon?.power.toString() ?? "",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.profile"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:Text(
                      AppLocalization.of(context).translate("appmons.profiles.${widget.appmon?.code.toLowerCase()}"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _getColorBorderAndText(),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chipContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalization.of(context).translate("components.dialogs.infoAppmon.chip"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getColorBorderAndText(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/${widget.imageDirectory}/${widget.appmon?.id}.png",
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

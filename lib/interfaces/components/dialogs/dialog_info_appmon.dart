import 'package:appli_drive_mobile/interfaces/components/text_with_background_color.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
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
  final AudioService _audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent, // Remove o fundo padrão para mostrar o gradiente
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: _getDialogGradientBackground(),
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
                        divider(),
                        appContainer(),
                        divider(),
                        typeContainer(),
                        divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: gradeContainer(),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: serieContainer(),
                            ),
                          ],
                        ),
                        divider(),
                        powerContainer(),
                        divider(),
                        profileContainer(),
                        divider(),
                        techniqueContainer(),
                        if (widget.showChipContainer) ...[
                          divider(),
                          chipContainer(),
                        ],
                        divider(),
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
                      _audioService.playEffect("click");
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
      ),
    );
  }

  Gradient _getDialogGradientBackground() {
  switch (widget.interface) {
    case "appliArise":
      return const LinearGradient(
        colors: [Color.fromARGB(255, 92, 92, 92), Color.fromARGB(255, 211, 211, 211), Color.fromARGB(255, 255, 255, 255)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case "7code":
      return const LinearGradient(
        colors: [Color.fromARGB(255, 124, 82, 126), Color.fromARGB(255, 180, 136, 180), Color.fromARGB(255, 240, 212, 240)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case "dataCenter":
    default:
      return const LinearGradient(
        colors: [Color.fromARGB(255, 88, 160, 255), Color.fromARGB(255, 144, 193, 248), Color.fromARGB(255, 189, 219, 253)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextWithWhiteShadow(
                  text: AppLocalization.of(context).translate("appmons.names.${widget.appmon?.name}"),
                  fontSize: 30,
                  align: "left",
                  height: 1.0,
                  applySoftWrap: true
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithBackgroundColor(
                        text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.app"),
                        fontSize: 24,
                        color: "grey",
                        align: "right",
                      ),
                      Divider(
                        color: _getColorBorderAndText(),
                        thickness: 2,
                        height: 4,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
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
                ),
                if (widget.appmon?.app != "open") ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      "assets/images/${widget.imageDirectory}/${widget.appmon?.id}.png",
                      width: 65,
                      height: 65,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gradeContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.grade"),
              fontSize: 24,
              color: "grey",
              align: "right",
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).translate("appmons.grades.${widget.appmon?.grade.name}"),
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

  Widget serieContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getColorBackground(),
        border: Border.all(color: _getColorBorderAndText(), width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.serie"),
              fontSize: 24,
              color: "grey",
              align: "right",
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.appmon?.serie ?? "",
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithBackgroundColor(
                        text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.type"),
                        fontSize: 24,
                        color: "grey",
                        align: "right",
                      ),
                      Divider(
                        color: _getColorBorderAndText(),
                        thickness: 2,
                        height: 4,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
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
                ),
                if (widget.appmon?.app != "open") ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      "assets/images/types/${widget.appmon!.type.name}.png",
                      width: 65,
                      height: 65,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithBackgroundColor(
                        text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.power"),
                        fontSize: 24,
                        color: "grey",
                        align: "right",
                      ),
                      Divider(
                        color: _getColorBorderAndText(),
                        thickness: 2,
                        height: 4,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.appmon?.power.toString() ?? "",
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
                ),
                if (widget.appmon?.app != "open") ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      'assets/images/icons/explosion_box.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
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
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.profile"),
              fontSize: 24,
              color: "grey",
              align: "right",
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

  Widget techniqueContainer() {
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
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.infoAppmon.technique"),
              fontSize: 24,
              color: "grey",
              align: "right",
            ),
            Divider(
              color: _getColorBorderAndText(),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).translate("appmons.techniques.${widget.appmon?.id}"),
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
                    fontSize: 24,
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

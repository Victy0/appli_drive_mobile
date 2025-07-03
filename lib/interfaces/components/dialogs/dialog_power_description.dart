import 'package:appli_drive_mobile/interfaces/components/text_with_background_color.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class DialogPowerDescription extends StatefulWidget {
  final Appmon? appmon;
  final Appmon? appmonLinked;
  const DialogPowerDescription({
    super.key,
    required this.appmon,
    this.appmonLinked,
  });

  @override
  DialogPowerDescriptionState createState() => DialogPowerDescriptionState();
}

class DialogPowerDescriptionState extends State<DialogPowerDescription> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 122, 122, 122),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 92, 92, 92), Color.fromARGB(255, 211, 211, 211), Color.fromARGB(255, 255, 255, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        divider(),
                        descriptionContainer(
                          "attack",
                          "orange",
                          widget.appmon?.attack ?? 0,
                          widget.appmonLinked?.attack,
                        ),
                        divider(),
                        descriptionContainer(
                          "defense",
                          "purple",
                          widget.appmon?.defense ?? 0,
                          widget.appmonLinked?.defense,
                        ),
                        divider(),
                        descriptionContainer(
                          "energy",
                          "yellow",
                          widget.appmon?.energy ?? 0,
                          widget.appmonLinked?.energy,
                        ),
                        divider(),
                        descriptionContainer(
                          "resistance",
                          "red",
                          widget.appmon?.resistance ?? 0,
                          widget.appmonLinked?.resistance,
                        ),
                        divider(),
                        descriptionContainer(
                          "ability",
                          "blue",
                          widget.appmon?.ability ?? 0,
                          widget.appmonLinked?.ability,
                        ),
                        divider(),
                        if(widget.appmonLinked == null)...[
                          techniqueContainer(),
                          divider(),
                        ]
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

  Widget nameContainer() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.powerDescription.name"),
              fontSize: 24,
              color: "grey",
              align: "center",
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 2,
              height: 0,
            ),
            Row(
              children: [
                if (widget.appmonLinked == null) ...[
                  Expanded(
                    child: Text(
                      AppLocalization.of(context)
                          .translate("appmons.names.${widget.appmon?.name}"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              AppLocalization.of(context)
                                  .translate("appmons.names.${widget.appmon?.name}"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorAppmonGrade(widget.appmon?.type.name, false),
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          const Text(
                            "PLUS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              AppLocalization.of(context)
                                  .translate("appmons.names.${widget.appmonLinked?.name}"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorAppmonGrade(widget.appmonLinked?.type.name, true),
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget descriptionContainer(String name, String color, int valueAppmon, int? valueAppmonLinked) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.powerDescription.$name"),
              fontSize: 24,
              color: color,
              align: "right",
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                getColoredValueText(valueAppmon, valueAppmonLinked)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getColoredValueText(int valueAppmon, int? valueAppmonLinked) {
    if (valueAppmonLinked != null) {
      int total = valueAppmon + valueAppmonLinked;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '$valueAppmon',
                style: TextStyle(
                  color: colorAppmonGrade(widget.appmon?.type.name, false)
                ),
              ),
              const TextSpan(text: ' + '),
              TextSpan(
                text: '$valueAppmonLinked',
                style: TextStyle(
                  color: colorAppmonGrade(widget.appmonLinked?.type.name, true)
                ),
              ),
              const TextSpan(text: ' = '),
              TextSpan(text: '$total'),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15), 
        child: Text(
          valueAppmon.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  Color? colorAppmonGrade(String? type, bool linked) {
    switch (type) {
      case "entertainment":
        if(linked) {
          return Colors.red;
        }
        return Colors.red[800];
      case "game":
        if(linked) {
          return Colors.orange;
        }
        return Colors.orange[800];
      case "life":
        if(linked) {
          return const Color.fromARGB(255, 248, 66, 127);
        }
        return const Color.fromARGB(255, 219, 36, 103);
      case "navi":
        if(linked) {
          return const Color.fromARGB(255, 76, 219, 80);
        }
        return const Color.fromARGB(255, 45, 170, 52);
      case "social":
        if(linked) {
          return Colors.blue[600];
        }
        return Colors.blue[800];
      case "system":
        if(linked) {
          return const Color.fromARGB(255, 255, 234, 40);
        }
        return const Color.fromARGB(255, 230, 207, 0);
      case "tool":
        if(linked) {
          return const Color.fromARGB(255, 137, 39, 176);
        }
        return Colors.purple[800];
    }
    return Colors.black;
  }

  Widget techniqueContainer() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.powerDescription.technique"),
              fontSize: 24,
              color: "grey",
              align: "left",
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 2,
              height: 0,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Ação ao clicar no botão
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 60, 255),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                child: Text(
                  AppLocalization.of(context).translate("components.dialogs.powerDescription.technique"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
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
      ),
    );
  }
}

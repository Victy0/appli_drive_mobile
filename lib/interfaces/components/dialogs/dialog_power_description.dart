import 'package:appli_drive_mobile/interfaces/components/text_with_background_color.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
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
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage('assets/images/background/powerDescription.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
            Colors.grey.withValues(alpha: 0.2),
              BlendMode.srcATop,
            ),
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
                        rowInfo(
                          descriptionContainer(
                            "attack",
                            "orange",
                            widget.appmon?.attack ?? 0,
                            widget.appmonLinked?.attack,
                          ),
                          descriptionContainer(
                            "defense",
                            "purple",
                            widget.appmon?.defense ?? 0,
                            widget.appmonLinked?.defense,
                          )
                        ),
                        divider(),
                        rowInfo(
                          descriptionContainer(
                            "energy",
                            "yellow",
                            widget.appmon?.energy ?? 0,
                            widget.appmonLinked?.energy,
                          ),
                          descriptionContainer(
                            "resistance",
                            "red",
                            widget.appmon?.resistance ?? 0,
                            widget.appmonLinked?.resistance,
                          )
                        ),
                        divider(),
                        rowInfo(
                          descriptionContainer(
                            "ability",
                            "blue",
                            widget.appmon?.ability ?? 0,
                            widget.appmonLinked?.ability,
                          ),
                          descriptionContainer(
                            "data",
                            "grey",
                            widget.appmon?.data ?? 0,
                            widget.appmonLinked?.data,
                          )
                        ),
                        divider(),
                        divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/traces/${widget.appmon?.id}.png",
                              width: 185,
                              fit: BoxFit.contain,
                            ),
                            if(widget.appmonLinked != null)...[
                              const SizedBox(width: 1),
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return scanlineShader(bounds.size);
                                },
                                blendMode: BlendMode.srcATop,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    defineColor(widget.appmonLinked?.type.name ?? ""),
                                    BlendMode.modulate,
                                  ),
                                  child: Image.asset(
                                    "assets/images/traces/${widget.appmonLinked?.id}.png",
                                    width: 185,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
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

  Widget rowInfo(Widget element1, Widget element2) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: element1,
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: element2,
        ),
      ],
    );
  }

  Widget nameContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            if (widget.appmonLinked == null) ...[
              Expanded(
                child: TextWithWhiteShadow(
                  text: AppLocalization.of(context).translate("appmons.names.${widget.appmon?.name}"),
                  fontSize: 30,
                  height: 1.0,
                  align: "center",
                  applySoftWrap: true,
                ),
              ),
            ] else ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextWithWhiteShadow(
                          text: AppLocalization.of(context).translate("appmons.names.${widget.appmon?.name}"),
                          fontSize: 30,
                          height: 1.0,
                          align: "center",
                          applySoftWrap: true,
                        ),
                      ),
                      TextWithWhiteShadow(
                        text: "PLUS",
                        fontSize: 24,
                        height: 1.0,
                        align: "center",
                        applySoftWrap: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextWithWhiteShadow(
                          text: AppLocalization.of(context).translate("appmons.names.${widget.appmonLinked?.name}"),
                          fontSize: 30,
                          height: 1.0,
                          align: "center",
                          applySoftWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            TextWithBackgroundColor(
              text: AppLocalization.of(context).translate("components.dialogs.powerDescription.$name"),
              fontSize: 22,
              color: color,
              align: "left",
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
              thickness: 2,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
    int totalValue = valueAppmon;
    if (valueAppmonLinked != null) {
      totalValue = totalValue + valueAppmonLinked;
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15), 
        child: Text(
          totalValue.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
  }

  Shader scanlineShader(Size size) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: List.generate(
        (size.height / 2).floor(),
        (i) => i.isEven
          ? Colors.white.withValues(alpha: 0.5)
          : Colors.transparent,
      ),
      stops: List.generate(
        (size.height / 2).floor(),
        (i) => i / (size.height / 2),
      ),
      tileMode: TileMode.repeated,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  Color defineColor(String color) {
    switch (color) {
      case "social":
        return const Color.fromARGB(255, 0, 162, 255).withValues(alpha: 0.6);
      case "tool":
        return const Color.fromARGB(255, 188, 45, 255).withValues(alpha: 0.6);
      case "system":
        return const Color.fromARGB(255, 255, 217, 0).withValues(alpha: 0.6);
      case "entertainment":
        return const Color.fromARGB(255, 255, 11, 11).withValues(alpha: 0.6);
      case "life":
        return const Color.fromARGB(255, 255, 43, 244).withValues(alpha: 0.6);
      case "game":
        return const Color.fromARGB(255, 255, 123, 0).withValues(alpha: 0.6);
      case "navi":
        return const Color.fromARGB(255, 44, 219, 0).withValues(alpha: 0.6);
      default:
        return const Color.fromARGB(255, 155, 155, 155).withValues(alpha: 0.6);
    }
  }
}

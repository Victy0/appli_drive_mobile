import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class AppmonPresentation extends StatefulWidget {
  final String? appmonName;
  final String? appmonId;
  final String textBackgroundColor;

  const AppmonPresentation({
    super.key,
    required this.appmonName,
    required this.appmonId,
    required this.textBackgroundColor,
  });

  @override
  State<AppmonPresentation> createState() => AppmonPresentationState();
}

class AppmonPresentationState extends State<AppmonPresentation> {
  String _getAppmonIntroduction() {
    String appmonIntro = AppLocalization.of(context).translate("pages.firstSetupPage.forEveryApplicationTherIsAnAppmon");
    String appmonPartner = AppLocalization.of(context).translate("pages.firstSetupPage.iAmYourPartnerAppmon");
    String appmonmNane = AppLocalization.of(context).translate("appmons.names.${widget.appmonName ?? ""}");
    return "$appmonIntro $appmonPartner$appmonmNane.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor(widget.textBackgroundColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  _getAppmonIntroduction(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ["yellow", "white"].contains(widget.textBackgroundColor)
                      ? Colors.black
                      : Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 250,
          width: 250,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return scanlineShader(bounds.size);
            },
            blendMode: BlendMode.srcATop,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 221, 221, 221),
                BlendMode.modulate,
              ),
              child: Image.asset(
                "assets/images/appmons/${widget.appmonId}.png",
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor(widget.textBackgroundColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  AppLocalization.of(context).translate("pages.firstSetupPage.presentation.${widget.appmonId}"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ["yellow", "white"].contains(widget.textBackgroundColor)
                      ? Colors.black
                      : Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

  Color? backgroundColor(String color) {
    switch(color) {
      case "red":
        return Colors.red[400];
      case "blue":
        return Colors.blue[700];
      case "grey":
        return Colors.grey[600];
      case "yellow":
        return Colors.yellow[400];
      case "purple":
        return Colors.purple[600];
      case "white":
        return Colors.grey[300];
    }
    return Colors.white.withValues(alpha: 0.1);
  }
}

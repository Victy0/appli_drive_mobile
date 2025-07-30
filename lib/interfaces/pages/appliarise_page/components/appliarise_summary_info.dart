import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:flutter/material.dart';

class AppliariseSummaryInfo extends StatefulWidget {
  final Appmon appmon;
  const AppliariseSummaryInfo({super.key, required this.appmon});

  @override
  AppliariseSummaryInfoState createState() => AppliariseSummaryInfoState();
}

class AppliariseSummaryInfoState extends State<AppliariseSummaryInfo> {
  bool _showSummary = false;

  int _getDelayAnimation(int grade) {
    if (grade == 2) {
      return 1;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
      Future.delayed(Duration(seconds: 3 + _getDelayAnimation(widget.appmon.grade.id)), () {
      setState(() {
        _showSummary = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // APP
        AnimatedOpacity(
          opacity: _showSummary ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Container(
            margin: const EdgeInsets.only(left: 0, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/apps/${widget.appmon.id}.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Expanded(
                  child: TextWithWhiteShadow(
                    text: AppLocalization.of(context).translate("appmons.apps.${widget.appmon.app}"),
                    fontSize: 24,
                    applySoftWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        // SPACING
        const SizedBox(height: 5),
        // TYPE
        AnimatedOpacity(
          opacity: _showSummary ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWithWhiteShadow(
                  text: AppLocalization.of(context).translate("appmons.types.${widget.appmon.type.name}"),
                  fontSize: 24,
                  align: "right",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/types/${widget.appmon.type.name}.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

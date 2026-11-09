import 'package:appli_drive_mobile/interfaces/pages/challenges_page/components/riddle/riddle_7code.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:flutter/material.dart';

class Group7code extends StatefulWidget {
  final String topic;
  final int actualChallenge;

  const Group7code({
    super.key,
    required this.topic,
    required this.actualChallenge,
  });

  @override
  State<Group7code> createState() => Group7codeState();
}

class Group7codeState extends State<Group7code> {
  final AudioService _audioService = AudioService();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
            childrenPadding: const EdgeInsets.only(bottom: 8),
            backgroundColor: Colors.grey[50],
            collapsedBackgroundColor: Colors.grey[50],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalization.of(context).translate(
                      "pages.challengesPage.topic.${widget.topic}.description"
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${widget.actualChallenge - 1}/7",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            children: [
              for (int number = 1; number <= 7; number++) ...[
                GestureDetector(
                  onTap: () {
                    if (widget.actualChallenge != number) {
                      return;
                    }
                    _openRiddle7code(number);
                  },
                  child: Opacity(
                    opacity: number > widget.actualChallenge ? 0.3 : 1.0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                          Text(
                            AppLocalization.of(context).translate("pages.challengesPage.topic.${widget.topic}.challenge.$number"),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          if (number < widget.actualChallenge) ...[
                            const Icon(Icons.check_circle, size: 15)
                          ] else if (number == widget.actualChallenge) ... [
                            const Icon(Icons.arrow_forward_ios, size: 15)
                          ]
                          ,
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ],
          )
        ),
      ),
    );
  }

  void _openRiddle7code(int numberChallenge) async {
    if (!mounted) return;
    _audioService.playEffect("click");
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Riddle7code(numberChallenge: numberChallenge),
    );
  }
}

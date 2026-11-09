import 'package:appli_drive_mobile/localizations/app_localization.dart';
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
  @override
  Widget build(BuildContext context) {
    int challengeCompleted = widget.actualChallenge - 1;

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
                  "$challengeCompleted/7",
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
                  /*onTap: () {
                    // definir ação ao clicar
                  },*/
                  child: Opacity(
                    opacity: number > challengeCompleted ? 0.3 : 1.0,
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
                          if (number < challengeCompleted) ...[
                            const Icon(Icons.check_circle, size: 15)
                          ] else if (number == challengeCompleted) ... [
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
}

import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class GroupedCardList extends StatefulWidget {
  final List<Map<String, dynamic>> hintList;

  const GroupedCardList({
    super.key,
    required this.hintList,
  });

  @override
  State<GroupedCardList> createState() => GroupedCardListState();
}

class GroupedCardListState extends State<GroupedCardList> {
  String _getNumberRevealdedToTotal(int revealedSize, String type) {
    int total = 0;
    switch(type){
      case "appmon":
        total = 6;
        break;
      case "appliDrive":
        total = 1;
        break;
      case "7code":
        total = 0;
    }
    return "$revealedSize/$total";
  }

  void _showHint(String hintCode) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.grey[50],
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalization.of(context).translate("pages.hintsPage.texts.$hintCode"),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.hintList.map((hint) {
        final type = hint['type'] ?? 'N/A';
        final numbers = (hint['number'] as List).map((e) => e.toString()).toList();
        final hasNumbers = numbers.isNotEmpty;

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
              child: hasNumbers
                ? ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.only(bottom: 8),
                    backgroundColor: Colors.grey[50],
                    collapsedBackgroundColor: Colors.grey[50],
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalization.of(context).translate("pages.hintsPage.types.$type"),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _getNumberRevealdedToTotal(numbers.length, type),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    children: numbers.map((number) {
                      return GestureDetector(
                        onTap: () {
                          _showHint("$type$number");
                        },
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
                                  AppLocalization.of(context).translate("pages.hintsPage.titles.$type$number"),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios, size: 15),
                              ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalization.of(context).translate("pages.hintsPage.types.$type"),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _getNumberRevealdedToTotal(0, type),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    tileColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

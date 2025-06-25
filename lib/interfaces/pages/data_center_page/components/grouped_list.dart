import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class GroupedList extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  final List<Map<String, dynamic>> appmonReveleadedList;
  final List<String> appmonRevealedIdsUser;

  const GroupedList({
    super.key,
    required this.databaseHelper,
    required this.appmonReveleadedList,
    required this.appmonRevealedIdsUser,
  });

  @override
  State<GroupedList> createState() => GroupedListState();
}

class GroupedListState extends State<GroupedList> {
  List<Widget> _buildGroupedList(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in widget.appmonReveleadedList) {
      String gradeName = item['gradeName'];
      if (!groupedItems.containsKey(gradeName)) {
        groupedItems[gradeName] = [];
      }
      groupedItems[gradeName]!.add(item);
    }

    List<Widget> codeWidgets = [];
    groupedItems.forEach((gradeName, items) {
      codeWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextWithWhiteShadow(
            text: AppLocalization.of(context).translate("appmons.grades.$gradeName"),
            fontSize: 22,
          ),
        ),
      );

      for (var item in items) {
        final isDisabled = !widget.appmonRevealedIdsUser.contains(item['id']);
        codeWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Opacity(
              opacity: isDisabled ? 0.3 : 1.0,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  leading: Image.asset(
                    "assets/images/apps/${item['id']}.png",
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item['name'].toString().toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: isDisabled ? null : () => _openAppmonDialog(item['code']),
                ),
              ),
            ),
          ),
        );
      }
    });
    return codeWidgets;
  }

  void _openAppmonDialog(String code) async {
    final result = await widget.databaseHelper.getAppmonByCode(code);
    if (!mounted) return;

    if (result != null) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (_) => DialogInfoAppmon(appmon: result, interface: "dataCenter"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildGroupedList(context),
    );
  }
}

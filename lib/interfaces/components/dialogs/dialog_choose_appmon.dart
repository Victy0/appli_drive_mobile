import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_appmon_list.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogChooseAppmon extends StatefulWidget {
  final AppliDriveManagementService appliDriveManagementService;
  final int appliDriveVersion;
  final DatabaseHelper databaseHelper;
  final Appmon? currentAppmon;
  const DialogChooseAppmon({
    super.key,
    required this.appliDriveManagementService,
    required this.appliDriveVersion,
    required this.databaseHelper,
    this.currentAppmon,
  });

  @override
  DialogChooseAppmonState createState() => DialogChooseAppmonState();
}

class DialogChooseAppmonState extends State<DialogChooseAppmon> {
  final PreferencesService _preferencesService = PreferencesService();
  final AudioService _audioService = AudioService();

  late List<Map<String, dynamic>> _appmonCodeList;
  late String? _lastAppmonBuddyEvolutionCode;

  String _errorCode = "";
  String _selectedCode = "";
  String _selectedName = "";

  void _getAppmonCodeList() async {
    _appmonCodeList = await widget.databaseHelper.getAppmonCodeList(widget.currentAppmon?.grade.id ?? 4);
  }

  void _getLastAppmonBuddyEvolutionCode() async {
    _lastAppmonBuddyEvolutionCode = await _preferencesService.getLastAppmonEvolutionBuddyCode();
  }

  @override
  void initState() {
    super.initState();
    _getAppmonCodeList();
    _getLastAppmonBuddyEvolutionCode();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("components.dialogs.insertCode.selectAnAppmon"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        _selectedCode == ""
                          ? AppLocalization.of(context).translate("components.dialogs.insertCode.select")
                          : _selectedName.toUpperCase(),
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                iconAppmonListCode(context),
              ],
            ),
            if (_errorCode != "") 
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  AppLocalization.of(context).translate(_errorCode),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                _audioService.stopAppLinkWait();
                _audioService.playEffect("back");
                _audioService.resumeBackground();
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                size: 40.0,
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                String? code = _selectedCode;
                if(code.isEmpty || code == "") {
                  _audioService.playEffect("error");
                  setState(() { _errorCode = "components.dialogs.insertCode.selectionIsRequired"; });
                  return;
                }
                final appmon = await widget.appliDriveManagementService.apliariseOrApplinkByCode(
                  code.toUpperCase(),
                  widget.currentAppmon,
                  widget.appliDriveVersion,
                  _lastAppmonBuddyEvolutionCode,
                );
                if(appmon == null) {
                  _audioService.playEffect("error");
                  setState(() { _errorCode = "components.dialogs.insertCode.invalidAppmon"; });
                  return;
                }
                _audioService.stopAppLinkWait();
                navigator.pop(appmon);
              },
              child: const Icon(
                Icons.check,
                size: 40.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget iconAppmonListCode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () async {
          final selected = await showDialog<Map<String, dynamic>>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
              DialogAppmonList(appmonCodeList: _appmonCodeList),
          );

          if (selected != null && selected.isNotEmpty) {
            setState(() {
              _selectedCode = selected['code'];
              _selectedName = selected['name'];
              _errorCode = "";
            });
          }
        },
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 45,
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

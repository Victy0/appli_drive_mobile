import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/appli_drive_management_service.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogInsertCode extends StatefulWidget {
  final AppliDriveManagementService appliDriveManagementService;
  final int appliDriveVersion;
  final Appmon? currentAppmon;
  const DialogInsertCode({
    super.key,
    required this.appliDriveManagementService,
    required this.appliDriveVersion,
    this.currentAppmon,
  });

  @override
  DialogInsertCodeState createState() => DialogInsertCodeState();
}

class DialogInsertCodeState extends State<DialogInsertCode> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  final TextEditingController _controller = TextEditingController();

  String _errorCode = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("components.dialogs.insertCode.enterAppmonCode"),
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
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              controller: _controller,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                LengthLimitingTextInputFormatter(3),
                UpperCaseTextFormatter(),
              ],
              keyboardType: TextInputType.text,
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
                _audioPlayerMomentary.play(AssetSource('sounds/click.mp3'));
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
                String code = _controller.text;
                if( code == "") {
                  _audioPlayerMomentary.play(AssetSource('sounds/error.mp3'));
                  setState(() { _errorCode = "components.dialogs.insertCode.codeIsRequired"; });
                  return;
                }
                final appmon = await widget.appliDriveManagementService.apliariseOrApplinkByCode(
                  code.toUpperCase(),
                  widget.currentAppmon,
                  widget.appliDriveVersion,
                );
                if(appmon == null) {
                  _audioPlayerMomentary.play(AssetSource('sounds/error.mp3'));
                  setState(() { _errorCode = "components.dialogs.insertCode.invalidCode"; });
                  return;
                }
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

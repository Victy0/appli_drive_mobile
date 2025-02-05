import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service_momentary.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogInsertCode extends StatefulWidget {
  const DialogInsertCode({super.key});

  @override
  DialogInsertCodeState createState() => DialogInsertCodeState();
}

class DialogInsertCodeState extends State<DialogInsertCode> {
  final AudioPlayer _audioPlayerMomentary = AudioServiceMomentary.instance.player;
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  String _errorCode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Text(
          AppLocalization.of(context).translate("componentsDialogs.insertCode.enterAppmonCode"),
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
                String code = _controller.text;
                if( code == "") {
                  _audioPlayerMomentary.play(AssetSource('sounds/error.mp3'));
                  setState(() { _errorCode = "componentsDialogs.insertCode.codeIsRequired"; });
                  return;
                }
                List<Appmon> appmonList = await _databaseHelper.getAppmonByCode(code.toUpperCase());
                if(appmonList.isEmpty) {
                  _audioPlayerMomentary.play(AssetSource('sounds/error.mp3'));
                  setState(() { _errorCode = "componentsDialogs.insertCode.invalidCode"; });
                  return;
                }
                Navigator.pop(context, appmonList[0]);
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

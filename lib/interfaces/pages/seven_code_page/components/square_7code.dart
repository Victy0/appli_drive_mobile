import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class Square7Code extends StatefulWidget {
  final String code;
  final bool disabled;
  final bool hasAppliarise;
  final DatabaseHelper databaseHelper;
  const Square7Code({
    super.key,
    required this.code,
    required this.disabled,
    required this.hasAppliarise,
    required this.databaseHelper,
  });

  @override
  Square7CodeState createState() => Square7CodeState();
}

class Square7CodeState extends State<Square7Code> {
  Future<void> _handle7codeInfo() async {
    final appmon7Code = await widget.databaseHelper.getSevenCodeInfo(widget.code);

    if (!mounted) return;

    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogInfoAppmon(
        appmon: appmon7Code,
        interface: "7code",
        imageDirectory: "7code",
        showChipContainer: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.disabled
      ? Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        )
      : GestureDetector(
          onTap: () async {
            _handle7codeInfo();
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/7code/${widget.code}.png',
              fit: BoxFit.contain,
            ),
          ),
        );
  }
}

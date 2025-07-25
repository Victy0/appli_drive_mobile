import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_appmon_code_list.dart';
import 'package:appli_drive_mobile/models/grade_appmon.dart';
import 'package:appli_drive_mobile/services/instant_audio_service.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class AppliariseHeader extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  final GradeAppmon grade;
  final bool tutorialFinished;
  const AppliariseHeader({
    super.key,
    required this.databaseHelper,
    required this.grade,
    required this.tutorialFinished
  });

  @override
  AppliariseHeaderState createState() => AppliariseHeaderState();
}

class AppliariseHeaderState extends State<AppliariseHeader> {
  final InstantAudioService _instantAudioPlayer = InstantAudioService();

  late List<Map<String, dynamic>> appmonCodeList;
  
  void _getAppmonCodeList() async {
    appmonCodeList = await widget.databaseHelper.getAppmonCodeList(widget.grade.id);
  }

  @override
  void initState() {
    super.initState();
    _getAppmonCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //if(widget.grade.name == "standard")
          //  iconPairing(context),
          const Spacer(),
          if(widget.tutorialFinished)
            iconAppmonListCode(context)
        ],
      ),
    );
  }

  Widget iconPairing(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => {
          _instantAudioPlayer.play("click"),
          showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 241, 241, 241),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Center( 
                child: Text(
                  'Título',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              content: const SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Contexto',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    _instantAudioPlayer.play("click"),
                    Navigator.pop(context),
                  },
                  child: const Icon(
                    Icons.check,
                    size: 40.0,
                    color: Colors.green,
                  )
                ),
              ],
            ),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/link_box.png',
          height: 40,
        ),
      )
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
        onPressed: () => {
          _instantAudioPlayer.play("click"),
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => DialogAppmonCodeList(appmonCodeList: appmonCodeList),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 40,
        ),
      ),
    );
  }
}

import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:flutter/material.dart';

class AppliariseHeader extends StatefulWidget {
  final Appmon appmon;
  final bool tutorialFinished;
  const AppliariseHeader({
    super.key,
    required this.appmon,
    required this.tutorialFinished
  });

  @override
  AppliariseHeaderState createState() => AppliariseHeaderState();
}

class AppliariseHeaderState extends State<AppliariseHeader> {
  final AudioService _audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //if(widget.appmon.grade.name == "standard")
          //  iconPairing(context),
          const Spacer(),
          infoButton(),
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
                    _audioService.playEffect("click"),
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

  Widget infoButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: IconButton(
        onPressed: () => {
          _audioService.playAudioSequence([
            "sounds/appliarise/appmon_name/${widget.appmon.id}.mp3",
          ]),
          showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => DialogInfoAppmon(appmon: widget.appmon, interface: "appliArise"),
          ),
        },
        icon: Image.asset(
          'assets/images/icons/magnifying_glass_box.png',
          height: 45,
        ),
      ),
    );
  }
}

import 'package:appli_drive_mobile/interfaces/pages/appliarise_page/appliarise_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';

class PairingMenu extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final String appmonPairingName;
  final List<Map<String, String>> appmonEvolutionInfo;
  const PairingMenu({
    super.key,
    required this.onLanguageChange,
    required this.appmonPairingName,
    required this.appmonEvolutionInfo
  });

  @override
  PairingMenuState createState() => PairingMenuState();
}

class PairingMenuState extends State<PairingMenu> with SingleTickerProviderStateMixin {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late AnimationController _controllerRotation;
  late Animation<double> _rotationAnimation;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controllerRotation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controllerRotation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerRotation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;
          _controllerRotation.forward();
        });
      }
    });

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.03,
    ).animate(CurvedAnimation(
      parent: _controllerRotation,
      curve: Curves.easeInOut,
    ));

    _controllerRotation.forward();
  }

  void _showConfirmationDialog(Appmon appmon) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 241, 241, 241),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Center( 
          child: Text(
            'APPLIARISE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        content: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${AppLocalization.of(context).translate("pages.homePage.confirmAppliarise")}${AppLocalization.of(context).translate("appmons.names.${appmon.name}")}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AppliarisePage(
                      onLanguageChange: widget.onLanguageChange,
                      appmon: appmon,
                    ),
                  ));
                },
                child: const Icon(
                  Icons.check,
                  size: 40.0,
                  color: Colors.green,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _nextImage() {
    if (_currentIndex < widget.appmonEvolutionInfo.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          AppLocalization.of(context).translate("pages.homePage.pairing"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "- ${AppLocalization.of(context).translate("appmons.names.${widget.appmonPairingName}")} -",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_left,
                size: 50,
                color: (_currentIndex > 0) ? Colors.black : Colors.transparent,
              ),
              onPressed: _currentIndex > 0 ? _previousImage : null,
            ),
            InkWell(
              onTap: () async {
                final appmon = await _databaseHelper.getAppmonByCode(widget.appmonEvolutionInfo[_currentIndex]['code'] ?? "");
                if (!mounted) return;
                if (appmon != null) {
                  _showConfirmationDialog(appmon);
                }
              },
              child: RotationTransition(
                turns: _rotationAnimation,
                child: Image.asset(
                  'assets/images/apps/${widget.appmonEvolutionInfo[_currentIndex]['id']}.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_right,
                size: 50,
                color: (_currentIndex < widget.appmonEvolutionInfo.length - 1)
                  ? Colors.black
                  : Colors.transparent,
              ),
              onPressed: _currentIndex < widget.appmonEvolutionInfo.length - 1
                ? _nextImage
                : null,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    super.dispose();
  }
}
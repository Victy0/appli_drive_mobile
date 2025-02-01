import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:flutter/material.dart';

class PairingMenu extends StatefulWidget {
  const PairingMenu({super.key});

  @override
  PairingMenuState createState() => PairingMenuState();
}

class PairingMenuState extends State<PairingMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controllerRotation;
  late Animation<double> _rotationAnimation;

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
          "- ${AppLocalization.of(context).translate("appmons.names.gatchmon")} -",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {
            print('criar dialog para confirmar Appliarise');
          },
          child: RotationTransition(
            turns: _rotationAnimation,
            child: Image.asset(
              'assets/images/apps/D1Y8.png',
              width: 200,
              height: 200,
            ),
          ),
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
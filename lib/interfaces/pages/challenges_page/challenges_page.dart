import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/components/custom_app_bar.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
//import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const ChallengesPage({super.key, required this.onLanguageChange});

  @override
  ChallengesPageState createState() => ChallengesPageState();
}

class ChallengesPageState extends State<ChallengesPage> {
  //final PreferencesService _preferencesService = PreferencesService();
  final AudioService _audioService = AudioService();

  //List<Map<String, dynamic>> _challengesList = [];
  bool _isLoading = true;

  void _getChallegensList() async {
    setState(() {
      //_challengesList = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _audioService.playBackground("common");
    _getChallegensList();
  }

  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: CustomAppBar(
        titleText: AppLocalization.of(context).translate("pages.challengesPage.challenges"),
        image: "assets/images/icons/task.png",
        backgroundColor: const [
          Color.fromARGB(255, 255, 183, 124),
          Color.fromARGB(255, 253, 139, 8),
        ],
        textBlack: true,
      ),
      body: Stack(
        children: [
          const BackgroundImage(
            color: "orange",
            scope: "common",
            animateColor: true,
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          ClosePageButton(onLanguageChange: widget.onLanguageChange, onTap: _returnToHomePage),
        ],
      ),
    );
  }
}
